//
// Created by fengshuai on 13-12-3.
// Copyright (c) 2013 winchannel. All rights reserved.


#import <Foundation/Foundation.h>

@class WCPlistHelper;

#define JR_APP_DEVICETOKEN                       @"JR_APP_DEVICETOKEN"
#define JR_ACCOUNT_DEVICEID                      @"JR_ACCOUNT_DEVICEID"
#define JR_ACCOUNT_AUTHORIZATION                 @"JR_ACCOUNT_AUTHORIZATION"
#define JR_ACCOUNT_USERID                        @"JR_ACCOUNT_USERID"

#define JR_ACCOUNT_SIGN                          @"JR_ACCOUNT_SIGN"

@protocol WCNetworkOperationProvider;

@class WCBaseConfiguration;

typedef enum
{
    EASINetworkProvider,
    EMKNetworkProvider,
    EAFNetworkProvider
}ENetworkProviderType;


@interface WCBaseContext : NSObject

+ (WCBaseContext *)sharedInstance;

@property (nonatomic, strong) WCBaseConfiguration *configuration;
@property (nonatomic, strong) WCPlistHelper *plistHelper;


@property (nonatomic, strong, getter=getDeviceToken) NSString *deviceToken;

@property (nonatomic, strong, getter=getAppInterfaceServer) NSString *appInterfaceServer;
@property (nonatomic, strong, getter=getH5Server) NSString *h5Server;
@property (nonatomic, strong, getter=getGameServer) NSString *gameSergver;


//乐家慧 微信微博，AppKey 和回调地址
@property (nonatomic, strong, getter=getSinaAppKey) NSString *sinaAppKey;               //sinaAppKey
@property (nonatomic, strong, getter=getSinaCallBackURl) NSString *sinaCallBackURl;      //sina回调地址
@property (nonatomic, strong, getter=getWxAppKey) NSString *wxAppKey;                      //微信AppKey
//物管App，微信微博，AppKey 和回调地址
@property (nonatomic, strong, getter=getWxWgAppKey) NSString *wxWgAppKey;                      //物管微信AppKey
@property (nonatomic, strong, getter=getSinaWgAppKey) NSString *sinaWgAppKey;                   //sina物管AppKey
@property (nonatomic, strong, getter=getSinaWgCallBackURl) NSString *sinaWgCallBackURl;      //sina物管App回调地址



@property (strong, nonatomic,getter=getLatitude,setter=setLatitude:) NSString *latitude;   //当前用户经度
@property (strong, nonatomic,getter=getLongitude,setter=setLongitude:) NSString *longitude; //当前用户纬度

/*
 *中民物管需要的全局字段
 */
@property (strong, nonatomic,getter=getSourceUrl,setter=setSourceUrl:) NSString *sourceUrl; //物管Url
@property (strong, nonatomic,getter=getSourceToken,setter=setSourceToken:) NSString *sourceToken; //物管Token
@property (strong, nonatomic,getter=getProject_id,setter=setProject_id:) NSString *project_id; //物管当前切换小区的 project_id
@property (strong, nonatomic,getter=getProject_id_owmer,setter=setProject_id_owner:) NSString *project_id_owner; //乐家慧当前切换小区的 project_id_owner
@property (strong, nonatomic,getter=getUser_phone,setter=setUser_phone:) NSString *user_phone; //物管当前登录用户名(手机号)
@property(nonatomic, strong, readonly) id <WCNetworkOperationProvider> connectionProvider;

+ (double)randomDoubleStart:(double)a end:(double)b;

-(NSString *) cacheRootFolder;
-(NSString *) resourceFolder;
-(NSString *) multimediaFolder;
-(NSString *) webPageFolder;
-(NSString *) downloadFolder;

- (NSString *)databasePath;

#pragma mark Startup
-(void)startupWithConfiguration:(WCBaseConfiguration *)configuration;

-(void)saveConfiguration;

@end
