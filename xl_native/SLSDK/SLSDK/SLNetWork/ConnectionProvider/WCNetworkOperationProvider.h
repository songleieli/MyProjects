//
// Created by fengshuai on 13-12-3.
// Copyright (c) 2013 winchannel. All rights reserved.


#import <Foundation/Foundation.h>

#define kTempDownloadSuffix @"download.tmp"

@protocol WCNetworkOperation <NSObject>

-(void)cancel;

@optional

-(void)pause;

@end

@protocol WCNetworkOperationProvider <NSObject>
@required
-(id<WCNetworkOperation>)createGetRequest:(NSString *)url
                       interfaceClassName:(NSString *)interfaceClassName
                             interfaceDic:(NSMutableDictionary *)interfaceDic
                            progressBlock:(void(^)(float progress))progressBlock
                             successBlock:(void(^)(NSData *responseData))completeBlock
                              failedBlock:(void(^)(NSError *error))failedBlock
                              cancelBlock:(void(^)())cancelBlock
                                  timeout:(NSUInteger)timeout;

-(id<WCNetworkOperation>)createPostRequest:(NSString *)url
                        interfaceClassName:(NSString *)interfaceClassName
                              interfaceDic:(NSMutableDictionary *)interfaceDic
                            uploadFilesDic:(NSMutableDictionary*)uploadFilesDic
                             progressBlock:(void(^)(float progress))progressBlock
                              successBlock:(void(^)(NSData *responseData))completeBlock
                               failedBlock:(void(^)(NSError *error))failedBlock
                               cancelBlock:(void(^)())cancelBlock
                                   timeout:(NSUInteger)timeout;

@end
