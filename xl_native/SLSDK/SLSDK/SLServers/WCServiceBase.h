//
//  WCServiceBase.h
//  SLSDK
//
//  Created by songlei on 15/5/15.
//  Copyright (c) 2015年 songlei. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "IObjcJsonBase.h"
#import "JSONKit.h"

#define kServiceErrorCode (999)//断网

@class WCServiceBase;
@class WCDataPacker;

typedef enum
{
    ERequestTypeGet_JrLoan = 0,
    ERequestTypePost_JrLoan
} ERequstType_JrLoan;


typedef enum
{
    ApiType_Cspt_Search = 0,
    ApiType_Cspt_Hap = 1,
    ApiType_Cspt_Shop = 2,
    ApiType_Cspt_Other = 3

} ApiType_Cspt;


@protocol WCServiceJrLoanDelegate <NSObject>

@optional

- (void)startWithCursor:(NSString*)msg interfaceName:(NSString*)interfaceName;
- (void)stopWatiCursor:(NSString*)interfaceName;

- (void)handleTokenOverdue:(NSString *)msg;

- (void)service:(WCServiceBase *)service successed:(id)result;
- (void)service:(WCServiceBase *)service error:(NSError *)error;

@end


@interface Property : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, strong) id value;

@end


@interface WCServiceBase : IObjcJsonBase

@property (nonatomic, assign) BOOL isCacheToDB;
@property (nonatomic, assign) NSUInteger timeout;

@property(nonatomic, copy) NSString *grp;
@property(nonatomic, copy) NSString *src;
@property(nonatomic, copy) NSString *lang;
@property(nonatomic, copy) NSString *waitMsg;
@property(nonatomic, copy) NSString *interfaceName;
@property(nonatomic, copy) NSString *apiBaseUrl;
@property(nonatomic, copy) NSString *apiUploadUrl;
@property(nonatomic, strong) NSMutableDictionary *paramsPDic;
@property(nonatomic, strong) NSMutableDictionary *headersPDic;               //请求Header
@property(nonatomic, strong) NSMutableDictionary *uploadFilesDic;
@property(nonatomic, weak) id <WCServiceJrLoanDelegate> delegate;

/*
 为每个接口请求添加
 
 appId                 appNameOwner 业主   appNameProperty物业）
 platform               平台类型（ios -1,Android -2 wap -3）
 devmanufacturer        终端厂商
 devIP                  终端ip地址
 deviceId               设备id
 devosversion           终端系统版本号
 devmac                 Mac地址
 devid                  IMEI(国际移动设备标示)
 devnet                 网络类型
 devoperators           运营商
 devmodel               设备型号
 appVersion             app版本号
 
 */


//@property(nonatomic, copy) NSString *appId;
@property(nonatomic, copy) NSString *platform;
@property(nonatomic, copy) NSString *devmanufacturer;
@property(nonatomic, copy) NSString *devIP;
@property(nonatomic, copy) NSString *devosversion;
@property(nonatomic, copy) NSString *devmac;
@property(nonatomic, copy) NSString *devid;
@property(nonatomic, copy) NSString *devsite;
@property(nonatomic, copy) NSString *devnet;
@property(nonatomic, copy) NSString *devoperators;
@property(nonatomic, copy) NSString *devmodel;
@property(nonatomic, copy) NSString *appVersion;





- (void)showWaitMsg:(NSString*)msg handle:(id)handle;


/*
 *Get请求
 */

- (void)startGetRequest;

- (void)startGetWithBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock;

- (void)startGetWithBlock:(void (^)(id result, NSString *msg))cacheBlock
               finishBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock;

- (void)startGetWithBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock
            progressBlock:(void (^)(float progress))progressBlock;

/*
 *Post请求
 */

- (void)startPostRequest;

- (void)startPostWithBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock;

- (void)startPostWithBlock:(void (^)(id result, NSString *msg))cacheBlock
               finishBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock;

- (void)startPostWithBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock
             progressBlock:(void (^)(float progress))progressBlock;

- (void)stop;

- (Class)responseType;

//- (ApiType_Cspt)responeApiType;

- (NSString*)responseCategory;

- (NSMutableDictionary *)composeParams;

- (id)composeResult:(NSDictionary *)dictionary attachedFile:(id)file;

@end
