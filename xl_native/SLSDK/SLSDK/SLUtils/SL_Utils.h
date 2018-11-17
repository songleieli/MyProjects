//
//  SL_Utils.h
//  SLSDK
//
//  Created by 刘辉 on 16/1/4.
//  Copyright © 2016年 songlei. All rights reserved.
//

#import <Foundation/Foundation.h>


#define IOS5_OR_LATER ( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS6_OR_LATER ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS9_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )


#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)


enum DeviceType {
    Device_iPhone = 0,
    Device_iTouch,
    Device_iPad,
};



@interface SL_Utils : NSObject

+ (NSNumber *)screenHeight;
+ (NSNumber *)screenWidth;
+ (NSString *)appName;
+ (NSString *)bundleId;
//获取app Short 版本
+ (NSString *)appShortVersion;

//获取app版本
+ (NSString *)appVersion;
//获取手机版本号
+ (NSString *)appDeviceVersion;
//获取设备类型
+ (NSInteger)getDeviceType;
//设备型号
+(NSString*)getModelName;
/*手机型号*/
+ (NSString *)deviceTypeVersion;
/*手机类型*/
+ (NSString *)devicePhoneModel;
//获取网络类型
+(NSString *)getNetWorkType;
//获取运营商类型
+ (NSString *)networkOperator;

//获取运营商信息
+ (NSString*)getCarrier;

//判断ios系统的通知开关是否开启
+ (BOOL)isAllowedNotification;

+ (float)getFreeDiskspace;

//IOS系统版本
+ (float)getIOSVersion;
//获得设备Mac地址
+ (NSString *)getMacAddress;

//获取设备IP
+(NSString*)getIPAddress;

+ (NSString *)strWithDic:(NSDictionary *)dic;
//设置UserAgent
+ (void) setUserAgentWithKey:(NSString*)key value:(NSString*)value;

//获取channelID
+ (NSString *)channelID;
//获取平台类型
+ (NSString *)platformType;
//获取设备idfa
+(NSString *)getIDFA;

//获得设备imei
+(NSString*)getIMEI;

//从钥匙串中获取idfa
+ (NSString *)getKeychainIDFA;

//将idfa存储到钥匙串中
+ (BOOL)saveKeychainIDFA:(NSString*)idfa;

//判断网络是否可用
+(BOOL)isNetAvilable;

@end
