//
//  TSStorageManager.m
//  Cetetek-Youyou
//
//  Created by song leilei on 12-10-10.
//  Copyright (c) 2012年 cetetek. All rights reserved.
//

#import "TSStorageManager.h"
#import "FMDatabase.h"




static TSStorageManager *sharedInstance = nil;

@interface TSStorageManager()



@end

@implementation TSStorageManager

//@synthesize db = mDB;

+(TSStorageManager *) sharedStorageManager
{
    @synchronized(self) {
        if (nil == sharedInstance) {
            [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

+(id) allocWithZone:(NSZone*)zone
{
    @synchronized(self)
    {
        if(sharedInstance ==nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return sharedInstance;
}

-(id) copyWithZone:(NSZone*)zone
{
    return self;
}

-(id) init
{
    @synchronized(self) {
        [super init];
        /*
         * Do your special initialization here
         */
        
        
        return self;
    }
}

-(id) retain
{
    return self;
}

-(oneway void) release
{
    // do nothing
}

-(id) autorelease
{
    return self;
}

-(NSUInteger) retainCount
{
    return NSUIntegerMax; // This is sooo not zero
}


#pragma -mark ---------- Init Method -------------

- (void)open
{
    @synchronized(self) {
        NSFileManager *fm = [NSFileManager defaultManager];
        
        // create folder for database if needed
        NSString *dir = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,
                                                             NSUserDomainMask,
                                                             YES)
                         lastObject];
        NSString *dbfolder = [dir stringByAppendingPathComponent:DATABASE_FOLDER];
        
        NSLog(@"DBPath = %@",dbfolder);
        if (![fm fileExistsAtPath:dbfolder]) {
            NSLog(@"start to create database folder");
            NSError *error = nil;
            if (![fm createDirectoryAtPath:dbfolder withIntermediateDirectories:YES attributes:nil error:&error]) {
                NSLog(@"Ooops, cannot create database folder - %@", dbfolder);
                return;
            }
        }
        // create database if it does not exist
        NSString* dbfile = [dbfolder stringByAppendingPathComponent:DATABASE_NAME];
        
        self.db = [FMDatabase databaseWithPath:dbfile];
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbfile];
    }
}

- (void)close
{
    @synchronized(self) {
        //[self.db close];
    }
}


#pragma -mark ---------- DB operation Method -------------

-(BOOL) executeSQLUpdate:(NSString *) sqlStatement{
    
    __block BOOL result = NO;
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db open];
        result = [db executeUpdate:sqlStatement];
        [db close];
    }];
    
    return result;
}

-(FMResultSet*) querySql:(NSString*)sql{
    
    __block FMResultSet *rs = nil;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        rs = [db executeQuery:sql];
        
        [db close];
    }];
    
    return rs;
}


-(NSMutableArray *) querySql:(NSString *) tableName
          withColumnsInArray:(NSArray *) columns
            withWhereClauses:(NSString *) whereClause
                 withOrderBy:(NSString *) orderBy withOderType:(TS_ORDER_E) order
{
    /*
     *  SQL specification:
     *      SELECT columnname,... FROM tablename,... [WHERE ...] [ORDER BY ...];
     */
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@ %@  ORDER BY %@ %@",
                     [NSString stringWithFormat:@"rowid, %@", columns ? [self combineNamesArray:columns] : @"*"],
                     tableName,
                     whereClause ? [NSString stringWithFormat:@"WHERE %@", whereClause] : @"",
                     orderBy == nil ? @"" : orderBy,
                     orderBy ? (ORDER_BY_ASC == order ? @"ASC" : @"DESC") : @"rowid ASC"];
    
    
    __block NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    
    [self.dbQueue inDatabase:^(FMDatabase *db)   {
        [db open];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]){
            
            NSMutableDictionary *dic = [[[NSMutableDictionary alloc]init] autorelease];
            for(NSString *column in columns){
                
                if([column isEqualToString:@"rowid"] || [column isEqualToString:@"MD5"]|| [column isEqualToString:@"MD5_STR"]||[column isEqualToString:@"MODEL_CONTENT"]){
                    [dic setObject:[rs stringForColumn:column] forKey:column];
                }
                else{
                    NSString *columnReturn = [column substringFromIndex:7];
                    [dic setObject:[rs stringForColumn:column] forKey:columnReturn];
                }
            }
            [array addObject:dic];
        }
        [rs close];
        
        [db close];
    }];
    
    return array;
}



-(NSString *)getInterFaceCache:(NSString *)tableName columnName:(NSString*)columnName md5Str:(NSString*)md5Str{
    
    NSString *md5Value = [md5Str MD5];
    NSArray *array = [self querySql:tableName
                 withColumnsInArray:[NSArray arrayWithObjects:@"rowid",[NSString stringWithFormat:@"COLUMN_%@",columnName],@"MD5", nil]
                   withWhereClauses:[NSString stringWithFormat:@"MD5 = '%@'",md5Value]
                        withOrderBy:@"rowid"
                       withOderType:ORDER_BY_DESC];  //如果有多条重复数据，取最新。
    
    NSString *content = @"";
    if(array.count >0 ){
        for (NSDictionary *dic in array){
            content = [dic objectForKey:columnName];
            break;
        }
    }
    return content;
    
}

-(NSArray *)getCacheWithparamsSortDic:(NSString *)tableName
                             inputParameters:(NSDictionary*)inputParameters
                                 filterDic:(NSDictionary*)filterDic
                                  cacheTag:(BOOL)cacheTag{
    
    NSMutableArray *columnsArrray =  [[NSMutableArray alloc] init];
    [columnsArrray addObject:@"MODEL_CONTENT"]; //Model 所在列字段名称为 COLUMN_model_content
//    [columnsArrray addObject:@"MD5"]; //Model 所在列字段名称为 COLUMN_model_content
    
    NSMutableString *whereClause = [[NSMutableString alloc] init];
    
    for(NSString *key in filterDic){
        [whereClause appendString:[NSString stringWithFormat:@" COLUMN_FILTER_%@ = '%@' AND ",key,[filterDic valueForKey:key]]];
    }
    for(NSString *key in inputParameters){
        [whereClause appendString:[NSString stringWithFormat:@" COLUMN_INPUT_%@ = '%@' AND ",key,[inputParameters valueForKey:key]]];
    }
    
    [whereClause appendString:[NSString stringWithFormat:@" CACHE_TAG = '%@' ",cacheTag?@"1":@"0"]];
    
    
    
    NSArray *array = [self querySql:tableName
                 withColumnsInArray:columnsArrray
                   withWhereClauses:[NSString stringWithFormat:@" %@ AND 1=1 ",whereClause]
                        withOrderBy:@"rowid"
                       withOderType:ORDER_BY_ASC];  //如果有多条重复数据，取最新。
    return array;
}


-(void)saveInterFaceCache:(NSString*)content tableName:(NSString *)tableName columnName:(NSString*)columnName md5Str:(NSString*)md5Str{
    
    NSString *md5Value = [md5Str MD5];
    
    content = [self sqliteEscape:content];
    
    if([self isTableOK:tableName] == NO){ //如果不不存在创建，如果存在，更新数据。
        NSMutableString *createTableStr = [[NSMutableString alloc] init];
        [createTableStr appendString:[NSString stringWithFormat:@"CREATE TABLE %@",tableName]];
        [createTableStr appendString:@"("];
        [createTableStr appendString:[NSString stringWithFormat:@"MD5 TEXT DEFAULT NULL,"]];
        [createTableStr appendString:[NSString stringWithFormat:@"MD5_STR TEXT DEFAULT NULL,"]];
        [createTableStr appendString:[NSString stringWithFormat:@"COLUMN_%@ TEXT DEFAULT NULL",columnName]];
        [createTableStr appendString:@")"];
        BOOL creat = [[TSStorageManager sharedStorageManager] executeSQLUpdate:createTableStr];
        if (creat == NO) {
            return;
        }
    }
    
    NSArray *array = [self querySql:tableName
                 withColumnsInArray:[NSArray arrayWithObjects:@"rowid", nil]
                   withWhereClauses:[NSString stringWithFormat:@"MD5 = '%@'",md5Value]
                        withOrderBy:@"rowid"
                       withOderType:ORDER_BY_DESC];
    
    
    
    int rowid = 0;
    if(array.count >0 ){
        for (NSDictionary *dic in array){
            rowid = [[dic objectForKey:@"rowid"] intValue];
            break;
        }
    }
    
    NSString *sql = @"";
    if(rowid >0){ //更新
        sql = [NSString stringWithFormat:@"UPDATE %@ SET COLUMN_%@ = '%@',MD5_STR = '%@' WHERE rowid = '%d' AND MD5 = '%@' ;",tableName,columnName,content,md5Str,rowid,md5Value];
    }
    else{ //添加
        sql = [NSString stringWithFormat:@"INSERT INTO  %@ (COLUMN_%@,MD5,MD5_STR) VALUES ('%@','%@','%@') ",tableName,columnName,content,md5Value,md5Str];
    }
    [[TSStorageManager sharedStorageManager] executeSQLUpdate:sql];
    
}

-(void)saveInterFaceCache:(NSString*)content
                tableName:(NSString *)tableName
               columnName:(NSString*)columnName
                   md5Str:(NSString*)md5Str
                filterDic:(NSDictionary*)filterDic {
    
    NSString *md5Value = [md5Str MD5];
    content = [self sqliteEscape:content];
    
    if([self isTableOK:tableName] == NO){ //如果不不存在创建，如果存在，更新数据。
        NSMutableString *createTableStr = [[NSMutableString alloc] init];
        [createTableStr appendString:[NSString stringWithFormat:@"CREATE TABLE %@",tableName]];
        [createTableStr appendString:@"("];
        [createTableStr appendString:[NSString stringWithFormat:@"MD5 TEXT DEFAULT NULL,"]];
        [createTableStr appendString:[NSString stringWithFormat:@"MD5_STR TEXT DEFAULT NULL,"]];
        [createTableStr appendString:[NSString stringWithFormat:@"COLUMN_%@ TEXT DEFAULT NULL",columnName]];
        [createTableStr appendString:@")"];
        BOOL creat = [[TSStorageManager sharedStorageManager] executeSQLUpdate:createTableStr];
        if (creat == NO) {
            return;
        }
    }
    
    
    for(NSString *key in filterDic.allKeys){
        [self addColumnFilterToTable:tableName columName:key type:@"NSString"];
    }
    
    
    
    NSArray *array = [self querySql:tableName
                 withColumnsInArray:[NSArray arrayWithObjects:@"rowid", nil]
                   withWhereClauses:[NSString stringWithFormat:@"MD5 = '%@'",md5Value]
                        withOrderBy:@"rowid"
                       withOderType:ORDER_BY_DESC];
    
    
    
    int rowid = 0;
    if(array.count >0 ){
        for (NSDictionary *dic in array){
            rowid = [[dic objectForKey:@"rowid"] intValue];
            break;
        }
    }
    
    NSString *sql = @"";
    if(rowid >0){ //更新
        sql = [NSString stringWithFormat:@"UPDATE %@ SET COLUMN_%@ = '%@',MD5_STR = '%@' WHERE rowid = '%d' AND MD5 = '%@' ;",tableName,columnName,content,md5Str,rowid,md5Value];
    }
    else{ //添加
        
        NSMutableString *columens =  [[NSMutableString alloc] init];
        NSMutableString *values =  [[NSMutableString alloc] init];
        
        
        for(NSString *key in filterDic.allKeys){
            [columens appendString:[NSString stringWithFormat:@"COLUMN_FILTER_%@,",key]];
            [values appendString:[NSString stringWithFormat:@"'%@',",[filterDic objectForKey:key]]];
        }
        [columens appendString:[NSString stringWithFormat:@"COLUMN_%@,",columnName]];
        [columens appendString:@"MD5,"];
        [columens appendString:@"MD5_STR"];
        [values appendString:[NSString stringWithFormat:@"'%@',",content]];
        [values appendString:[NSString stringWithFormat:@"'%@',",md5Value]];
        [values appendString:[NSString stringWithFormat:@"'%@'",md5Str]];
        
        sql = [NSString stringWithFormat:@"INSERT INTO  %@ (%@) VALUES (%@) ",tableName,columens,values];
    }
    [[TSStorageManager sharedStorageManager] executeSQLUpdate:sql];
}

#pragma -mark ---------- CustomMethod -------------

/*
 *sql 脚本特殊字符转意
 */

-(NSString *)sqliteEscape:(NSString *)sql{
    NSString *sqlStr = [sql stringByReplacingOccurrencesOfString:@"'" withString:@""];
    return sqlStr;
}

- (BOOL) isTableOK:(NSString *)tableName{
    
    NSString *sql = [NSString stringWithFormat:@"select count(*) as 'count' from sqlite_master where type ='table' and name = '%@'",tableName];
    
    __block BOOL isExit = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        FMResultSet *rs =[db executeQuery:sql];
        while ([rs next]){
            NSInteger count = [rs intForColumn:@"count"];
            if (0 == count){
                isExit = NO;
            }
            else{
                isExit = YES;
            }
        }
        
        [db close];
    }];
    return isExit;
}
- (BOOL) isColumOK:(NSString *)tableName columName:(NSString*)columName{
    
    //columName = [NSString stringWithFormat:@"COLUMN_%@",columName];
    /*
     *1.修改人：宋磊磊
     *2.时间：时间20170823
     *3.原因：page pageSize 出现地段匹配不准确。
     *4.修改内容：'%%%@%%'" 修改为 '%%%@%'"
     */
//    NSString *sql = [NSString stringWithFormat:@"select count(*) as count from sqlite_master where name = '%@' and sql like '%%%@%%'",tableName,columName];

    
    NSString *sql = [NSString stringWithFormat:@"select count(*) as count from sqlite_master where name = '%@' and sql like '%%%@%'",tableName,columName];
    
    __block BOOL isExit = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        FMResultSet *rs =[db executeQuery:sql];
        while ([rs next]){
            NSInteger count = [rs intForColumn:@"count"];
            if (0 == count){
                isExit = NO;
            }
            else{
                isExit = YES;
            }
        }
        
        [db close];
    }];
    return isExit;
}

- (BOOL) isDataRecordOK:(NSString *)tableName primaryKey:(NSString*)primaryKey primaryKeyValue:(NSString*)primaryKeyValue{
    
    NSString *sql = [NSString stringWithFormat:@"select count(*) as 'count' from '%@' where %@ ='%@' ",tableName,primaryKey,primaryKeyValue];
    
    __block BOOL isExit = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        
        FMResultSet *rs =[db executeQuery:sql];
        while ([rs next]){
            NSInteger count = [rs intForColumn:@"count"];
            if (0 == count){
                isExit = NO;
            }
            else{
                isExit = YES;
            }
        }
        
        [db close];
    }];
    return isExit;
}

- (void) addTableToDataBase:(NSString*)tableName{
    
    if([self isTableOK:tableName] == NO){ //如果不不存在创建，如果存在，更新数据。
        NSMutableString *createTableStr = [[NSMutableString alloc] init];
        [createTableStr appendString:[NSString stringWithFormat:@"CREATE TABLE %@",tableName]];
        [createTableStr appendString:@"("];
        [createTableStr appendString:[NSString stringWithFormat:@"MD5_STR TEXT DEFAULT NULL,"]];
        [createTableStr appendString:[NSString stringWithFormat:@"MD5 TEXT DEFAULT NULL,"]];
        [createTableStr appendString:[NSString stringWithFormat:@"MODEL_CONTENT TEXT DEFAULT NULL,"]];
        [createTableStr appendString:[NSString stringWithFormat:@"CACHE_TAG TEXT DEFAULT NULL"]];
        [createTableStr appendString:@")"];
        BOOL creat = [[TSStorageManager sharedStorageManager] executeSQLUpdate:createTableStr];
        if (creat == NO) {
            return;
        }
    }
}
- (BOOL) addColumnToTable:(NSString *)tableName columName:(NSString*)columName type:(NSString*)type{
    
    if([type isEqualToString:@"NSNumber"]){
        type = @"REAL";
    }
    else{
        type = @"TEXT";
    }
    
    columName = [NSString stringWithFormat:@"COLUMN_%@",columName];
    
    if(![self isColumOK:tableName columName:columName]){
        
        /*
         ALTER TABLE table-name ADD COLUMN column-name column-type
         例如在student表中添加一列名为name，类型为varchar:
         alter table student add column name varchar;
         */
        
        NSString *sql = [NSString stringWithFormat:@"alter table %@ add column %@ %@;",tableName,columName,type];
        return [[TSStorageManager sharedStorageManager] executeSQLUpdate:sql];
    }
    else{
        return YES;
    }
}

- (BOOL) addColumnInputToTable:(NSString *)tableName columName:(NSString*)columName type:(NSString*)type{
    
    if([type isEqualToString:@"NSNumber"]){
        type = @"REAL";
    }
    else{
        type = @"TEXT";
    }
    
    columName = [NSString stringWithFormat:@"COLUMN_INPUT_%@",columName];
    
    if(![self isColumOK:tableName columName:columName]){
        
        /*
         ALTER TABLE table-name ADD COLUMN column-name column-type
         例如在student表中添加一列名为name，类型为varchar:
         alter table student add column name varchar;
         */
        
        NSString *sql = [NSString stringWithFormat:@"alter table %@ add column %@ %@;",tableName,columName,type];
        return [[TSStorageManager sharedStorageManager] executeSQLUpdate:sql];
    }
    else{
        return YES;
    }
}

- (BOOL) addColumnFilterToTable:(NSString *)tableName columName:(NSString*)columName type:(NSString*)type{
    
    if([type isEqualToString:@"NSNumber"]){
        type = @"REAL";
    }
    else{
        type = @"TEXT";
    }
    
    columName = [NSString stringWithFormat:@"COLUMN_FILTER_%@",columName];
    
    if(![self isColumOK:tableName columName:columName]){
        
        /*
         ALTER TABLE table-name ADD COLUMN column-name column-type
         例如在student表中添加一列名为name，类型为varchar:
         alter table student add column name varchar;
         */
        
        NSString *sql = [NSString stringWithFormat:@"alter table %@ add column %@ %@;",tableName,columName,type];
        return [[TSStorageManager sharedStorageManager] executeSQLUpdate:sql];
    }
    else{
        return YES;
    }
}

- (void)updateDataToTable:(NSString *)tableName
                     dataModel:(id)dataModel
                    primaryKey:(NSString*)primaryKey
               inputParameters:(NSDictionary *)inputParameters
                     filterDic:(NSDictionary*)filterDic
                      cacheTag:(BOOL)cacheTag{
    
    [self addDataToTableWithModel:tableName
                        dataModel:dataModel
                       primaryKey:primaryKey
                  inputParameters:inputParameters
                        filterDic:filterDic
                         cacheTag:cacheTag];
}


-(void) addDataToTable:(NSString *)tableName
                 primaryKey:(NSString *)primaryKey
                  arrayData:(NSArray *)arrayData
            inputParameters:(NSDictionary *)inputParameters
                  filterDic:(NSDictionary*)filterDic
                   cacheTag:(BOOL)cacheTag{
    
    for(id dataModel in arrayData){
        
        [self addDataToTableWithModel:tableName
                            dataModel:dataModel
                           primaryKey:primaryKey
                      inputParameters:inputParameters
                            filterDic:filterDic
                             cacheTag:cacheTag];
        
    }
    
}

-(void)addDataToTableWithModel:(NSString *)tableName
                     dataModel:(id)dataModel
                    primaryKey:(NSString *)primaryKey
               inputParameters:(NSDictionary *)inputParameters
                     filterDic:(NSDictionary*)filterDic
                      cacheTag:(BOOL)cacheTag{
    /*
     * 1.根据主键查找存不存在该条记录
     * 2.存在该条记录更新
     * 3.不存在该条记录插入
     * 4.存放Model的字段为 model_content
     */
    NSString *primaryKeyValue = [dataModel valueForKey:primaryKey];
    NSString *modelContent = [dataModel generateJsonStringForProperties];
    
    NSString *md5Str = @"";
    NSString *md5Value = @"";
    if(inputParameters.allKeys.count > 0){
        md5Str = [NSString stringWithFormat:@"%@_%@",primaryKeyValue,[SL_Utils strWithDic:inputParameters]];
    }
    else{
        md5Str = primaryKeyValue;
    }
    
    /*
     *MD5Str 添加过滤缓存字段
     */
    for(NSString *key in filterDic.allKeys){
        md5Str = [NSString stringWithFormat:@"%@_cache_filter_%@",md5Str,[filterDic objectForKey:key]];
    }
    
    
    md5Value = [md5Str MD5];
    
    BOOL isExitRecord = [self isDataRecordOK:tableName primaryKey:[NSString stringWithFormat:@"COLUMN_%@",primaryKey] primaryKeyValue:primaryKeyValue];
    if(isExitRecord){//更新
        
        NSMutableString *setUpdateStr = [[NSMutableString alloc]init];
        
        for(int i = 0;i<inputParameters.allKeys.count;i++){
            NSString *key = [inputParameters.allKeys objectAtIndex:i];
            [setUpdateStr appendString:[NSString stringWithFormat:@"COLUMN_INPUT_%@ = '%@',",key,[inputParameters valueForKey:key]]];
        }
        [setUpdateStr appendFormat:[NSString stringWithFormat:@"MODEL_CONTENT = '%@',", modelContent]];
        [setUpdateStr appendFormat:[NSString stringWithFormat:@"MD5_STR = '%@',", md5Str]];
        [setUpdateStr appendFormat:[NSString stringWithFormat:@"CACHE_TAG = '%@',", cacheTag?@"1":@"0"]];
        [setUpdateStr appendFormat:[NSString stringWithFormat:@"COLUMN_%@ = '%@'",primaryKey, primaryKeyValue]];
        
        NSString *sql = [NSString stringWithFormat:@"update %@ set %@ where COLUMN_%@ ='%@';",tableName,setUpdateStr,primaryKey,primaryKeyValue];
        [self executeSQLUpdate:sql];
    }
    else{ //插入
        NSMutableString *columns = [[NSMutableString alloc]init];
        NSMutableString *values = [[NSMutableString alloc]init];
        
        for(int i = 0;i<inputParameters.allKeys.count;i++){
            NSString *key = [inputParameters.allKeys objectAtIndex:i];
            [columns appendString:[NSString stringWithFormat:@"COLUMN_INPUT_%@,",key]];
            [values appendString:[NSString stringWithFormat:@"'%@',",[inputParameters valueForKey:key]]];
        }
        
        for(NSString *key in filterDic.allKeys){//全局过滤参数列
            [columns appendString:[NSString stringWithFormat:@"COLUMN_FILTER_%@,",key]];
            [values appendString:[NSString stringWithFormat:@"'%@',",[filterDic objectForKey:key]]];
        }
        
        //Model内容
        [columns appendString:[NSString stringWithFormat:@"MODEL_CONTENT,"]];
        [values appendString:[NSString stringWithFormat:@"'%@',",modelContent]];
        
        //生成MD5的Str
        [columns appendString:[NSString stringWithFormat:@"MD5_STR,"]];
        [values appendString:[NSString stringWithFormat:@"'%@',",md5Str]];
        
        //主键
        [columns appendString:[NSString stringWithFormat:@"COLUMN_%@,",primaryKey]];
        [values appendString:[NSString stringWithFormat:@"'%@',",primaryKeyValue]];
        
        //在线还是离线标记
        [columns appendString:[NSString stringWithFormat:@"CACHE_TAG,"]];
        [values appendString:[NSString stringWithFormat:@"'%@',",cacheTag?@"1":@"0"]];
        
        //MD5 MD5是由 主键和输入参数组成的用于唯一更新，主键和生成MD5_STR，用于辅助查看MD5
        [columns appendString:[NSString stringWithFormat:@"MD5"]];
        [values appendString:[NSString stringWithFormat:@"'%@'",md5Value]];
        
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO  %@ (%@) VALUES (%@);",tableName,columns,values];
        [self executeSQLUpdate:sql];
    }
}


-(void)removeDataWithInputParameters:(NSString *)tableName
                     inputParameters:(NSDictionary*)inputParameters
                           filterDic:(NSDictionary*)filterDic
                            cacheTag:(BOOL)cacheTag
                            MD5Value:(NSString*)MD5Value{
    
    //DELETE FROM Person WHERE LastName = 'Wilson'
    NSMutableString *deleteStr = [[NSMutableString alloc]init];
    if(cacheTag){ //删除离线数据
        
        for(int i = 0;i<inputParameters.allKeys.count;i++){
            NSString *key = [inputParameters.allKeys objectAtIndex:i];
            [deleteStr appendString:[NSString stringWithFormat:@"COLUMN_INPUT_%@ = '%@' AND ",key,[inputParameters valueForKey:key]]];
        }
        
        for(NSString *key in filterDic){
            [deleteStr appendString:[NSString stringWithFormat:@"COLUMN_FILTER_%@ = '%@' AND ",key,[filterDic valueForKey:key]]];
        }
        
        if(MD5Value.length > 0){
            [deleteStr appendString:[NSString stringWithFormat:@"MD5 = '%@' AND ",MD5Value]];
        }
        
        [deleteStr appendString:[NSString stringWithFormat:@"CACHE_TAG = '1' "]];
    }
    else{ //删除所有缓存数据
        
        for(int i = 0;i<inputParameters.allKeys.count;i++){
            NSString *key = [inputParameters.allKeys objectAtIndex:i];
            [deleteStr appendString:[NSString stringWithFormat:@"COLUMN_INPUT_%@ = '%@' AND ",key,[inputParameters valueForKey:key]]];
        }
        for(int i = 0;i<filterDic.allKeys.count;i++){
            NSString *key = [filterDic.allKeys objectAtIndex:i];
            if(i== filterDic.count - 1){//最后一个
                [deleteStr appendString:[NSString stringWithFormat:@"COLUMN_FILTER_%@ = '%@' ",key,[filterDic valueForKey:key]]];
            }
            else{
                [deleteStr appendString:[NSString stringWithFormat:@"COLUMN_FILTER_%@ = '%@' AND ",key,[filterDic valueForKey:key]]];
            }
        }
    }
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM  %@ WHERE (%@);",tableName,deleteStr];
    [self executeSQLUpdate:sql];
}


-(void)removeDataWithInputParameters:(NSString *)tableName
                     primaryKey:(NSString*)primaryKey
                     primaryKeyValue:(NSString*)primaryKeyValue
                           filterDic:(NSDictionary*)filterDic{
    
    //DELETE FROM Person WHERE LastName = 'Wilson'
    NSMutableString *deleteStr = [[NSMutableString alloc]init];
    
    for(int i = 0;i<filterDic.allKeys.count;i++){
        NSString *key = [filterDic.allKeys objectAtIndex:i];
        [deleteStr appendString:[NSString stringWithFormat:@"COLUMN_FILTER_%@ = '%@' AND ",key,[filterDic valueForKey:key]]];
    }
    
    [deleteStr appendString:[NSString stringWithFormat:@"COLUMN_%@ = '%@' ",primaryKey,primaryKeyValue]];

    NSString *sql = [NSString stringWithFormat:@"DELETE FROM  %@ WHERE (%@);",tableName,deleteStr];
    [self executeSQLUpdate:sql];
}

-(NSString *) combineNamesArray:(NSArray *) namesInArray{
    
    NSMutableString *clause = [[[NSMutableString alloc] init] autorelease];
    int placeHolderNum = (int)[namesInArray count];
    for (int i = 0; i < placeHolderNum; ++i) {
        [clause appendFormat:@" %@", [namesInArray objectAtIndex:i]];
        if (i < placeHolderNum - 1) {
            [clause appendString:@","];
        }
    }
    return clause;
    
}

- (void)checkError{
    
    if ([self.db hadError]) {
        NSLog(@"!!!Database Error!!! %d: %@", [self.db lastErrorCode], [self.db lastErrorMessage]);
    }
}



@end
