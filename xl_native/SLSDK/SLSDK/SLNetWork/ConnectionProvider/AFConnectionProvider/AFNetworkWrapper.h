//
// Created by fengshuai on 13-12-13.
// Copyright (c) 2013 winchannel. All rights reserved.


#import <Foundation/Foundation.h>

@protocol WCNetworkOperation;
@class AFHTTPRequestOperation;

@interface AFNetworkWrapper : NSObject <WCNetworkOperation>
@property(nonatomic, strong) AFHTTPRequestOperation *operation;
@property(nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property(nonatomic, copy) NSString *downloadTempPath;

@end