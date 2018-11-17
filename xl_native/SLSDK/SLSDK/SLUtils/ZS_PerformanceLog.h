//
//  ZS_PerformanceLog.h
//  JRD
//
//  Created by liuhui on 15/5/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZS_PerformanceLog : NSObject
{
    NSMutableArray *_logDataArray;
}

@property (nonatomic , strong)NSMutableDictionary *logDataDic;

+ (instancetype)shareInstance;


-(long)logStartWithKey:(NSString*)matchKey module:(NSString*)module testType:(NSString*)testType interface:(NSString*)interface;
-(long)logWriteWithKey:(NSString*)matchKey svrStartTime:(double)svrStartTime svrEndTime:(double)svrEndTime;
-(long)logWriteWithKey:(NSString*)matchKey responseHeaders:(NSDictionary *)headers;

#ifdef _PerformanceLog_Open_
//#ifndef __OPTIMIZE__
#define ZS_LogStart(matchKeyStr,moduleStr,testTypeStr,interfaceStr)     {[[ZS_PerformanceLog shareInstance] logStartWithKey:matchKeyStr module:moduleStr testType:testTypeStr interface:interfaceStr];}

#define ZS_LogWrite(matchKey,resHeaders)     {[[ZS_PerformanceLog shareInstance] logWriteWithKey:matchKey responseHeaders:resHeaders];}

#else

#define ZS_LogStart(matchKey,module,testType,interface)
#define ZS_LogWrite(matchKey,responseHeaders)

#endif

@end


@interface ZS_PerformBaseData : NSObject
{
    
}

@property (nonatomic , strong)NSString *phoneModel; //机型(iPod Touch/iPhone5/6)
@property (nonatomic , strong)NSString *osType;     //(ios/Android)
@property (nonatomic , strong)NSString *osVersion;  //系统版本(ios8.2)
@property (nonatomic , strong)NSString *appVersion; //程序版本号5.0

@end

@interface ZS_PerformLogData : ZS_PerformBaseData
{
//    long    _currtime;    //当前时间
//    NSString *_module;   //模块名称 （首页，详情页等）
//    NSString *_testType; //测试类别(Startup/UI/Network/DB)
//    NSString *_matchKey; //匹配key,配对计算时间用
//    NSString *_networkType; //2G/3G/4G/WIFI/断网
//    NSString *_interface;  //接口名称
//    long _startTime;       //发起请求时间
//    long _endTime;         //请求返回时间
//    long _netDiffTime;     //netDiffTime= endTime- startTime 网络请求时间
//    long _serverStartTime; //服务器开始时间（老谭在header返回）
//    long _serverEndTime;   //服务器结束时间（老谭在header返回）
//    long _serverDiffTime;  //serverDiffTime= serverEndTime- serverStartTime 服务器处理需要时间
}

@property (nonatomic , assign)double  currtime;
@property (nonatomic , strong)NSString *module;
@property (nonatomic , strong)NSString *testType;
@property (nonatomic , strong)NSString *matchKey;
@property (nonatomic , strong)NSString *networkType;
@property (nonatomic , strong)NSString *interface;
@property (nonatomic , assign)double startTime;
@property (nonatomic , assign)double endTime;
@property (nonatomic , assign)double netDiffTime;
@property (nonatomic , assign)double serverStartTime;
@property (nonatomic , assign)double serverEndTime;
@property (nonatomic , assign)double serverDiffTime;

@end




