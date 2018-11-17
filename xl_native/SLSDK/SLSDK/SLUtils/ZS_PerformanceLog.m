//
//  ZS_PerformanceLog.m
//  JRD
//
//  Created by liuhui on 15/5/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ZS_PerformanceLog.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "SL_Utils.h"

@implementation ZS_PerformBaseData

-(id)init
{
    if(self = [super init])
    {
        self.phoneModel = [UIDevice currentDevice].model;
        self.osType = [UIDevice currentDevice].systemName; //@"ios"
        self.osVersion = [[UIDevice currentDevice] systemVersion];
        self.appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];

    }
    return self;
}


@end

@implementation ZS_PerformLogData

-(id)init
{
   if(self = [super init])
   {
       
   }
   return self;
}

@end

@implementation ZS_PerformanceLog

static FMDatabaseQueue *dbQueue = nil;
static ZS_PerformanceLog *performanceLog = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        performanceLog = [[ZS_PerformanceLog alloc] init];
    });
    return performanceLog;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *mainPath = [path stringByAppendingPathComponent:@"PerformanceLog"];
        [self createDirectoryWithName:mainPath];
        NSString *dbPath = [mainPath stringByAppendingPathComponent:@"PerformanceLogDB.sqlite"];
        dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        [self createTable];
        self.logDataDic = [[NSMutableDictionary alloc]initWithCapacity:5];
        
    }
    return self;
}

- (void)closeDatabase {
    if (dbQueue) {
        [dbQueue close];
        dbQueue = nil;
    }
}

- (void)createDirectoryWithName:(NSString *)name {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileDirectoryExists = [fileManager fileExistsAtPath:name];
    if (!fileDirectoryExists) {
        [fileManager createDirectoryAtPath:name withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

- (void)createTable {
    [dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists performanceLogTable(id integer primary key autoincrement , module text, netDiffTime double ,serverDiffTime double ,matchKey text,interface text, testType text, networkType text, phoneModel text, osType text,osVersion text, appVersion text,currTime double, startTime double, endTime double ,serverStartTime double,serverEndTime double)"];
        [db executeUpdate:sqlStr];
    }];
}


- (BOOL)save:(ZS_PerformLogData *)logdata {
    
    __block long _id = 0;
    __block BOOL bRet = NO;
    [dbQueue inDatabase:^(FMDatabase *db)
     {
         NSString *sqlStr = [NSString stringWithFormat:@"insert into performanceLogTable (module,netDiffTime,serverDiffTime,matchKey,interface,testType,networkType,phoneModel,osType,osVersion,appVersion,currTime,startTime,endTime,serverStartTime,serverEndTime) values (?,%lf,%lf,?,?,?,?,?,?,?,?,%lf,%lf,%lf,%lf,%lf)",logdata.netDiffTime , logdata.serverDiffTime, logdata.currtime , logdata.startTime , logdata.endTime, logdata.serverStartTime , logdata.serverEndTime  ];
         
         
         bRet = [db executeUpdate:sqlStr,logdata.module,logdata.matchKey,logdata.interface,logdata.testType,logdata.networkType,logdata.phoneModel,logdata.osType, logdata.osVersion,logdata.appVersion ];
         
         _id = [db lastInsertRowId];
         
     }];
    
    return bRet;
}


-(long)logStartWithKey:(NSString*)matchKey module:(NSString*)module testType:(NSString*)testType interface:(NSString*)interface
{
    ZS_PerformLogData *logdata = [[ZS_PerformLogData alloc]init];
    logdata.currtime = CFAbsoluteTimeGetCurrent();
    logdata.startTime = logdata.currtime;
    logdata.matchKey = matchKey;
    logdata.networkType =  [SL_Utils getNetWorkType];
    logdata.module = module;
    logdata.testType = testType;
    logdata.interface = interface;

    [self.logDataDic setObject:logdata forKey:matchKey];
    
    return 0;
}


-(long)logWriteWithKey:(NSString*)matchKey responseHeaders:(NSDictionary *)headers {
    double beginTime = 0;
    double endTime = 0;
    if(headers)
    {
        beginTime = [[headers objectForKey:@"BgnTime"] doubleValue];
        endTime = [[headers objectForKey:@"EndTime"] doubleValue];
    }
    return [self logWriteWithKey:matchKey svrStartTime:beginTime svrEndTime:endTime];
}

-(long)logWriteWithKey:(NSString*)matchKey svrStartTime:(double)svrStartTime svrEndTime:(double)svrEndTime
{
    ZS_PerformLogData *logdata = nil;
    
    if(matchKey == nil)
        return 0;
    logdata = [self.logDataDic objectForKey:matchKey];
    
    if (logdata == nil)
        return 0;
    
    logdata.endTime = CFAbsoluteTimeGetCurrent();
    logdata.netDiffTime = logdata.endTime-logdata.startTime;
    logdata.serverStartTime = svrStartTime;
    logdata.serverEndTime = svrEndTime;
    logdata.serverDiffTime = logdata.serverEndTime-logdata.serverStartTime;
    
    long logid = [self save:logdata];
    
    [self.logDataDic removeObjectForKey:matchKey];
    
    return logid;
}



- (void)dealloc {
    [self closeDatabase];
}

@end
