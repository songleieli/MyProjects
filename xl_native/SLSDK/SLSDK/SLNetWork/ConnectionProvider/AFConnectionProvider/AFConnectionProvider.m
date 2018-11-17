//
// Created by fengshuai on 13-12-13.
// Copyright (c) 2013 winchannel. All rights reserved.


#import <sys/proc.h>
#import "AFConnectionProvider.h"
#import "AFNetworkWrapper.h"
#import "AFURLSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperationManager+Download.h"

#define kDownloadTimeOut (60)

@interface AFConnectionProvider()
@property(nonatomic, strong) NSMutableDictionary *resumeDataCache;
@property(nonatomic, strong) AFURLSessionManager *sessionManager;
@property(nonatomic, copy) NSString *downloadSessionIdntifier;
@property(nonatomic, weak) id<WCBackTransferTerminationReportDelegate> delegate;
@end

@implementation AFConnectionProvider

- (id)initWithBackTransferDelegate:(id <WCBackTransferTerminationReportDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        if ([UIDevice getCurrentSystemVersionNumber]>=7)
        {
            self.delegate=delegate;
            self.resumeDataCache= [NSMutableDictionary dictionary];
            self.downloadSessionIdntifier= [NSString stringWithFormat:@"%@.downloadSession",[[[NSBundle mainBundle] infoDictionary]objectForKey:(NSString *)kCFBundleNameKey]];
            self.sessionManager= [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration backgroundSessionConfiguration:self.downloadSessionIdntifier]];

            __weak typeof(self) wself=self;
            [self.sessionManager setDidFinishEventsForBackgroundURLSessionBlock:^(NSURLSession *session)
            {
                if ([WCBaseContext sharedInstance].backgroundSessionCompletionHandler)
                {
                    void (^completionHandler)() = [WCBaseContext sharedInstance].backgroundSessionCompletionHandler;
                    [WCBaseContext sharedInstance].backgroundSessionCompletionHandler = nil;
                    completionHandler();
                }
            }];

            [self.sessionManager setDownloadTaskDidFinishDownloadingBlock:^NSURL *(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, NSURL *location)
            {
                if ([wself.delegate respondsToSelector:@selector(provideFileURLForCompleteTask:)])
                {
                    NSString *path= [wself.delegate provideFileURLForCompleteTask:downloadTask];
                    if ([path length])
                        return [NSURL fileURLWithPath:path];
                }
                return nil;
            }];

            [self.sessionManager setTaskDidCompleteBlock:^(NSURLSession *session, NSURLSessionTask *task, NSError *error)
            {
                if ([wself.delegate respondsToSelector:@selector(reportTaskStatus:error:)])
                    [wself.delegate reportTaskStatus:task error:error];
            }];

            [self.sessionManager start];

            [self performSelector:@selector(reportFinish) withObject:nil afterDelay:2];
        }
    }

    return self;
}

-(void)reportFinish
{
    if ([self.delegate respondsToSelector:@selector(reportCheckFinished)])
    {
        [self.delegate reportCheckFinished];
    }
}

- (id <WCNetworkOperation>)createGetRequest:(NSString *)url
                            progressBlock:(void (^)(float progress))progressBlock
                             successBlock:(void (^)(NSData *responseData))completeBlock
                              failedBlock:(void (^)(NSError *error))failedBlock
                              cancelBlock:(void (^)())cancelBlock timeout:(NSUInteger)timeout
{
    AFHTTPRequestOperation *requestOperation= [[AFHTTPRequestOperationManager manager] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if(completeBlock)
            completeBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failedBlock)
            failedBlock(error);
    }];
    [requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long int totalBytesRead, long long int totalBytesExpectedToRead)
    {
        if(progressBlock)
            progressBlock(totalBytesRead/totalBytesExpectedToRead);
    }];

    AFNetworkWrapper *wrapper= [[AFNetworkWrapper alloc] init];
    wrapper.operation=requestOperation;

    return wrapper;

}

- (id <WCNetworkOperation>)createDownloadRequest:(NSString *)url
                                                targetPath:(NSString *)targetPath
                                             progressBlock:(void (^)(float progress))progressBlock
                                              successBlock:(void (^)(NSData *responseData))completeBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock
                                               cancelBlock:(void (^)())cancelBlock
                                            taskIdentifier:(NSString *)identifier
{
    AFNetworkWrapper *afNetworkWrapper= [[AFNetworkWrapper alloc] init];
    if ([WCBaseContext sharedInstance].configuration.supportBackgroundTransfer&& [identifier length]>0)
    {
        //利用URLSession以支持后台下载

        afNetworkWrapper.downloadTempPath= [targetPath stringByAppendingString:kTempDownloadSuffix];

        NSData *resumeData= [self.resumeDataCache objectForKey:identifier];
        if (!resumeData)//缓存里没有，从文件系统读取
        {
            if ([NSFileManager FileExist:afNetworkWrapper.downloadTempPath])
                resumeData= [NSData dataWithContentsOfFile:afNetworkWrapper.downloadTempPath];
        }
        if (resumeData)//恢复下载
        {
            NSURLSessionDownloadTask *task= [self.sessionManager downloadTaskWithResumeData:resumeData progressBlock:progressBlock destination:^NSURL *(NSURL *targetPath2, NSURLResponse *response)
            {
                if ([NSFileManager FileExist:targetPath])
                    [NSFileManager deleteFileByPath:targetPath];
                return [NSURL fileURLWithPath:targetPath];
            } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error)
            {
                if(!error)
                {
                    if (completeBlock)
                        completeBlock(nil);
                }
                else
                {
                    if (failedBlock)
                        failedBlock(error);
                }
            }];
            afNetworkWrapper.downloadTask=task;
            [self.resumeDataCache removeObjectForKey:identifier];//移除缓存
            [task setTaskDescription:identifier];
            [task resume];
        }
        else//从头开始下载
        {
            NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:kDownloadTimeOut];
            NSURLSessionDownloadTask *task= [self.sessionManager downloadTaskWithRequest:request progressBlock:progressBlock destination:^NSURL *(NSURL *targetPath2, NSURLResponse *response)
            {
                if ([NSFileManager FileExist:targetPath])
                    [NSFileManager deleteFileByPath:targetPath];
                return [NSURL fileURLWithPath:targetPath];
            } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error)
            {
                if(!error)
                {
                    if (completeBlock)
                        completeBlock(nil);
                }
                else
                {
                    if (failedBlock)
                        failedBlock(error);
                }
            }];
            afNetworkWrapper.downloadTask=task;
            [task setTaskDescription:identifier];
            [task resume];
        }

        return afNetworkWrapper;
    }
    else
    {
        AFHTTPRequestOperation *requestOperation= [[AFHTTPRequestOperationManager manager] Download:url targetPath:targetPath
         success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            if (completeBlock)
                completeBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            if (failedBlock)
                failedBlock(error);
        }];
        if (progressBlock)
            [requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long int totalBytesRead, long long int totalBytesExpectedToRead)
            {
                progressBlock(totalBytesRead/totalBytesExpectedToRead);
            }];

        AFNetworkWrapper *networkWrapper= [[AFNetworkWrapper alloc] init];
        networkWrapper.operation=requestOperation;
        return networkWrapper;
    }
}

- (id <WCNetworkOperation>)createPostRequest:(NSString *)url
                                  fileData:(NSData *)fileData
                                  fileName:(NSString *)fileName
                               contentType:(NSString *)contentType
                             progressBlock:(void (^)(float progress))progressBlock
                              successBlock:(void (^)(NSData *responseData))completeBlock
                               failedBlock:(void (^)(NSError *error))failedBlock
                               cancelBlock:(void (^)())cancelBlock
                                    forKey:(NSString *)key
{
    AFHTTPRequestOperation *requestOperation= [[AFHTTPRequestOperationManager manager] POST:url parameters:nil constructingBodyWithBlock:^(id <AFMultipartFormData> formData){
        [formData appendPartWithFileData:fileData name:key fileName:fileName mimeType:contentType];
    } success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if(completeBlock)
            completeBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (failedBlock)
            failedBlock(error);
    }];

    if (progressBlock)
        [requestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long int totalBytesWritten, long long int totalBytesExpectedToWrite)
        {
            progressBlock(totalBytesWritten/totalBytesExpectedToWrite);
        }];

    AFNetworkWrapper *wrapper= [[AFNetworkWrapper alloc] init];
    wrapper.operation=requestOperation;

    return wrapper;

}

@end