//
// Created by fengshuai on 13-12-13.
// Copyright (c) 2013 winchannel. All rights reserved.


#import "AFNetworkWrapper.h"
#import "AFHTTPRequestOperation.h"


@implementation AFNetworkWrapper
- (void)cancel
{
    [self.operation cancel];
    [self.downloadTask cancel];
}

- (void)pause
{
    [self.operation cancel];
    [self.downloadTask cancelByProducingResumeData:^(NSData *resumeData)
    {
        if ([NSFileManager FileExist:self.downloadTempPath])
            [NSFileManager deleteFileByPath:self.downloadTempPath];
        [resumeData writeToFile:self.downloadTempPath atomically:NO];
    }];
}


@end