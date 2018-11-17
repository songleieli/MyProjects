//
//  TSStorageManager.h
//  Cetetek-Youyou
//
//  Created by song leilei on 12-10-10.
//  Copyright (c) 2012年 cetetek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

#define DATABASE_FOLDER             @"database"
#define DATABASE_NAME               @"CMPMobile.db"

typedef enum {
    ORDER_BY_NONE = 0,
    ORDER_BY_DESC,
    ORDER_BY_ASC
} TS_ORDER_E;

#define IS_VALID_ORDER(e)  ((e) >= ORDER_BY_NONE && (e) <= ORDER_BY_ASC)

@interface TSStorageManager : NSObject
{
    FMDatabase *mDB;
}

@property (atomic, strong) FMDatabase *db;
@property (atomic, strong) FMDatabaseQueue *dbQueue;


+ (TSStorageManager *) sharedStorageManager;


-(FMResultSet*) querySql:(NSString*)sql;


/*
 *非增量更新模式下，使用 唯一值 md5Str 取值所以不用 filterDic
 */
-(NSString *)getInterFaceCache:(NSString *)tableName columnName:(NSString*)columnName md5Str:(NSString*)md5Str;

/*
 *新添加 filterDic 用于过滤数据，比如中民物管过滤不同用户和所对应项目的缓存数据。
 */
-(NSArray *)getCacheWithparamsSortDic:(NSString *)tableName
                             inputParameters:(NSDictionary*)inputParameters
                                 filterDic:(NSDictionary*)filterDic
                                  cacheTag:(BOOL)cacheTag;



- (BOOL) executeSQLUpdate:(NSString *) sqlStatement;

- (BOOL) isTableOK:(NSString *)tableName;

- (void) addTableToDataBase:(NSString*)tableName;

- (BOOL) isColumOK:(NSString *)tableName columName:(NSString*)columName;

/*
 *插入缓存数据的列
 */
- (BOOL) addColumnToTable:(NSString *)tableName columName:(NSString*)columName type:(NSString*)type;
/*
 *插入输入参数的列
 */
- (BOOL) addColumnInputToTable:(NSString *)tableName columName:(NSString*)columName type:(NSString*)type;

/*
 *插入过滤参数列
 */
- (BOOL) addColumnFilterToTable:(NSString *)tableName columName:(NSString*)columName type:(NSString*)type;

/*
 *保存非增量更新数据到数据库
 */
-(void)saveInterFaceCache:(NSString*)content
                tableName:(NSString *)tableName
               columnName:(NSString*)columnName
                   md5Str:(NSString*)md5Str
                filterDic:(NSDictionary*)filterDic;
/*
 *保存增量更新数据到数据库
 */
-(void) addDataToTable:(NSString *)tableName
                 primaryKey:(NSString *)primaryKey
                  arrayData:(NSArray *)arrayData
            inputParameters:(NSDictionary *)inputParameters
                  filterDic:(NSDictionary*)filterDic
                   cacheTag:(BOOL)cacheTag;
/*
 *根据Model主键更新Model到数据库中
 */
- (void)updateDataToTable:(NSString *)tableName
                dataModel:(id)dataModel
               primaryKey:(NSString*)primaryKey
          inputParameters:(NSDictionary *)inputParameters
                filterDic:(NSDictionary*)filterDic
                 cacheTag:(BOOL)cacheTag;

-(void)removeDataWithInputParameters:(NSString *)tableName
                     inputParameters:(NSDictionary*)inputParameters
                           filterDic:(NSDictionary*)filterDic
                            cacheTag:(BOOL)cacheTag
                            MD5Value:(NSString*)MD5Value;

/*
 *根据主键删除某条记录
 */
-(void)removeDataWithInputParameters:(NSString *)tableName
                          primaryKey:(NSString*)primaryKey
                     primaryKeyValue:(NSString*)primaryKeyValue
                           filterDic:(NSDictionary*)filterDic;


/*
 * database will be opened when our browser application did launch, the database
 * will keep opening through application lifecyle, when the application says goodbye,
 * the database will be closed by UIApplication instance
 */
/* CAUTION: only the UIApplication instance can invoke this method */
- (void)open;
/* CAUTION: only the UIApplication instance can invoke this method */
- (void)close;

// check whether we meet the error during database operation
- (void)checkError;

@end
