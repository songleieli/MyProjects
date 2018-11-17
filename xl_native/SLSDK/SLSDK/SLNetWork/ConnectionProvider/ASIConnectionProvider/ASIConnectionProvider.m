//
// Created by fengshuai on 13-12-4.
// Copyright (c) 2013 winchannel. All rights reserved.

#import "ASIConnectionProvider.h"
#import "ASIHTTPRequest.h"
#import "ASIOperationWrapper.h"
#import "ASIFormDataRequest.h"

#pragma mark - 自定义ASI链接供应商 延展(内部)
@interface ASIConnectionProvider ()

- (BOOL)checkIsHttpsRequest:(ASIHTTPRequest *)request; //检查是否https请求

@end

#pragma mark - 自定义ASI链接供应商
@implementation ASIConnectionProvider

#pragma mark - 检查是否https请求
- (BOOL)checkIsHttpsRequest:(ASIHTTPRequest *)request
{
    if([request.url.absoluteString hasPrefix:@"https"] == YES || [request.url.absoluteString hasPrefix:@"HTTPS"] == YES)
        return YES;
    
    return NO;
}

- (id <WCNetworkOperation>)createGetRequest:(NSString *)url
                         interfaceClassName:(NSString *)interfaceClassName
                               interfaceDic:(NSMutableDictionary *)interfaceDic
                              progressBlock:(void (^)(float progress))progressBlock
                               successBlock:(void (^)(NSData *responseData))completeBlock
                                failedBlock:(void (^)(NSError *error))failedBlock
                                cancelBlock:(void(^)())cancelBlock
                                    timeout:(NSUInteger)timeout
{
    /*
     处理params和headers
     */
    NSDictionary *headersPDic = [interfaceDic objectForKey:@"headersPDic"];
    NSDictionary *paramsDic = [interfaceDic objectForKey:@"paramsPDic"];
    
    NSMutableString *logStr = [[NSMutableString alloc] init];
    [logStr appendString:[NSString stringWithFormat:@"\r\n\r\n\r\n请求类型 GET\r接口请求类 %@\r请求url = %@\r",interfaceClassName,url]];
    [logStr appendString:@"---------------------requestHeaders----------------------------\r"];
    for(id key in headersPDic.allKeys){
        [logStr appendString:[NSString stringWithFormat:@"%@ = %@\r",key,[headersPDic objectForKey:key]]];
    }
    [logStr appendString:@"---------------------requestparams----------------------------\r"];
    for(id key in paramsDic.allKeys){
        [logStr appendString:[NSString stringWithFormat:@"%@ = %@\r",key,[paramsDic objectForKey:key]]];
    }
    [logStr appendString:@"--------------------------------------------------------------\r"];
    NSLog(logStr);
    
    NSString *paramsDicStr = [SL_Utils strWithDic:paramsDic];
    url = [NSString stringWithFormat:@"%@?%@",url,paramsDicStr];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; //将请求的网址进行url编码
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    for(id key in headersPDic.allKeys){
        [request addRequestHeader:key value:[headersPDic objectForKey:key]];
    }
    
    if (timeout > 0){
        [request setTimeOutSeconds:timeout];
    }
    request.requestMethod = @"GET";
    
    ASIOperationWrapper *operationWrapper = [[ASIOperationWrapper alloc] init];
    operationWrapper.operation = request;
    
    __weak ASIHTTPRequest *wRequest = request;
    [request setCompletionBlock:^{
        if(completeBlock)
            completeBlock([wRequest responseData]);
    }];
    
    [request setFailedBlock:^{
        if(failedBlock)
            failedBlock([wRequest error]);
    }];
    
    if (progressBlock)
    {
        __block unsigned long long received = 0;
        [request setBytesReceivedBlock:^(unsigned long long size, unsigned long long total) {
            
            received += size;
            float progress = (float)received / (float)total;
            progressBlock(progress);
        }];
    }
    
    if (cancelBlock)
        [request setCancelBlock:cancelBlock];
    
    if([self checkIsHttpsRequest:request] == YES){
        [request setValidatesSecureCertificate:NO];
    }
    
    [request startAsynchronous];
    
    return operationWrapper;
}

- (id <WCNetworkOperation>)createPostRequest:(NSString *)url
                          interfaceClassName:(NSString *)interfaceClassName
                                interfaceDic:(NSMutableDictionary *)interfaceDic
                              uploadFilesDic:(NSMutableDictionary*)uploadFilesDic
                               progressBlock:(void (^)(float progress))progressBlock
                                successBlock:(void (^)(NSData *responseData))completeBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock
                                 cancelBlock:(void(^)())cancelBlock
                                     timeout:(NSUInteger)timeout
{
    /*
     处理params和headers
     */
    NSDictionary *headersPDic = [interfaceDic objectForKey:@"headersPDic"];
    NSDictionary *paramsDic = [interfaceDic objectForKey:@"paramsPDic"];
    
    NSLog(@"-------------");
    
    
    
    NSMutableString *logStr = [[NSMutableString alloc] init];
    [logStr appendString:[NSString stringWithFormat:@"\r\n\r\n\r\n请求类型 POST\r接口请求类 %@\r请求url = %@\r",interfaceClassName,url]];
    [logStr appendString:@"---------------------requestHeaders----------------------------\r"];
    for(id key in headersPDic.allKeys){
        [logStr appendString:[NSString stringWithFormat:@"%@ = %@\r",key,[headersPDic objectForKey:key]]];
    }
    [logStr appendString:@"---------------------requestparams----------------------------\r"];
    for(id key in paramsDic.allKeys){
        [logStr appendString:[NSString stringWithFormat:@"%@ = %@\r",key,[paramsDic objectForKey:key]]];
    }
    [logStr appendString:@"--------------------------------------------------------------\r"];
    NSLog(logStr);
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; //将请求的网址进行url编码
//    if(uploadFilesDic.count>0){ //上传图片的Url 地址不一样，支持上传多张图片
//        url = [interfaceDic objectForKey:@"apiUploadUrl"];
//        url = url.trim;
//    }
    
    ASIFormDataRequest *request= [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    if (timeout > 0){
        [request setTimeOutSeconds:timeout];
    }
    request.requestMethod = @"POST";
    
    for(id key in headersPDic.allKeys){
        [request addRequestHeader:key value:[headersPDic objectForKey:key]];
    }
    
    for(id key in paramsDic.allKeys){
        [request setPostValue:[paramsDic objectForKey:key] forKey:key];
    }
    
    if(uploadFilesDic.count>0){ //上传多张图片
        //上传图片的顺序和显示图片的顺序需要排布一致
        NSArray *sortArray = [uploadFilesDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
        for(NSInteger i=0;i<sortArray.count;i++){
            NSString *key = [sortArray objectAtIndex:i];
            NSString *fileName = key;//[NSString stringWithFormat:@"%@.png",key];
            NSData *imgData = [uploadFilesDic objectForKey:key];
            [request addData:imgData withFileName:fileName andContentType:@"image/png" forKey:fileName];
        }
    }
    
    ASIOperationWrapper *operationWrapper= [[ASIOperationWrapper alloc] init];
    operationWrapper.operation=request;
    
    __weak ASIHTTPRequest *wRequest=request;
    [request setCompletionBlock:^{
        if(completeBlock)
            completeBlock([wRequest responseData]);
    }];
    
    [request setFailedBlock:^{
        if(failedBlock)
            failedBlock([wRequest error]);
    }];
    
    if (progressBlock)
    {
        __block unsigned long long received = 0;
        [request setBytesSentBlock:^(unsigned long long size, unsigned long long total){
            received += size;
            float progress = (float)received / (float)total;
            progressBlock(progress);
        }];
    }
    
    if (cancelBlock)
        [request setCancelBlock:cancelBlock];
    
    if([self checkIsHttpsRequest:request] == YES){
        [request setValidatesSecureCertificate:NO];
    }
    [request startAsynchronous];
    return operationWrapper;
}

@end
