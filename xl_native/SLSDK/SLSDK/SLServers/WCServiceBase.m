///
//  WCServiceBase.m
//  SLSDK
//
//  Created by songlei on 15/5/15.
//  Copyright (c) 2015年 songlei. All rights reserved.
//


#import "WCServiceBase.h"
#import "Reachability.h"
#import "TSStorageManager.h"
#import <objc/runtime.h>

@implementation Property

@end

@interface WCServiceBase()

@property(nonatomic, strong) id <WCNetworkOperation> operation;

@end

@implementation WCServiceBase

-(NSMutableDictionary*)headersPDic{
    if(_headersPDic == nil){
        _headersPDic =  [[NSMutableDictionary alloc] init];
    }
    return _headersPDic;
}


- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.grp = [WCBaseContext sharedInstance].configuration.group_name;
        self.lang = [[NSLocale preferredLanguages] objectAtIndex:0]; //语言
        self.interfaceName = [self getInterfaceName];
        self.timeout = 15;
        self.apiBaseUrl = [WCBaseContext sharedInstance].appInterfaceServer;
        
        [self.headersPDic removeAllObjects];
        [self.headersPDic setObject:@"appNameOwner" forKey:@"appId"];
        [self.headersPDic setObject:@"Apple Inc" forKey:@"devmanufacturer"];
        [self.headersPDic setObject:@"1" forKey:@"platform"];
        [self.headersPDic setObject:@"0.0.0.0" forKey:@"devIP"];
        [self.headersPDic setObject:@"iosVer" forKey:@"devosversion"];
        [self.headersPDic setObject:[SL_Utils getMacAddress] forKey:@"devmac"];
        [self.headersPDic setObject:[SL_Utils getIMEI] forKey:@"devid"];
        [self.headersPDic setObject:[SL_Utils getCarrier] forKey:@"devoperators"];
        [self.headersPDic setObject:[SL_Utils getModelName] forKey:@"devmodel"];
        [self.headersPDic setObject:[SL_Utils appShortVersion] forKey:@"appVersion"];
    }
    return self;
}


#pragma -mark ------------- 接口属性相关处理 ---------------

- (NSString *)getInterfaceName{
    NSArray *aArray = [NSStringFromClass([self class]) componentsSeparatedByString:@"_"];
    return [aArray objectAtIndex:1];
}

- (NSString *)prepareRequestUrl:(ERequstType_JrLoan)requstType{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.apiBaseUrl,[self responseCategory]];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    if(self.paramsPDic == nil){
        self.paramsPDic = [[NSMutableDictionary alloc] init];
    }
    [self.paramsPDic removeAllObjects];
    
    if(requstType == ERequestTypePost_JrLoan){
        for(int i = 0; i < count; i++){
            objc_property_t property = properties[i];
            NSString *propertName = @"";
            NSString *propType = @"";
            id v = [self getPropertyValueWithObject:self property:property propertName:&propertName propType:&propType];
            
            if(v != nil){ //判断空值和空字符串
                if([propType isEqualToString:@"NSString"]){
                    NSString *strValue = [NSString stringWithFormat:@"%@",v];
                    if(![strValue.trim isEqualToString:@""]){
                        [self.paramsPDic setValue:strValue forKey:propertName];
                    }
                }
                else{
                    [self.paramsPDic setValue:v forKey:propertName];
                }
            }
        }
    }
    else{
        for(int i = 0; i < count; i++){
            objc_property_t property = properties[i];
            NSString *propertName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            id v = [self valueForKey:propertName];
            
            NSLog(@"name:%@",propertName);
            NSLog(@"v:%@",v);
            
            [self.paramsPDic setValue:v forKey:propertName];
        }
    }
    return urlStr;
}

- (NSMutableDictionary *)composeParams{
    return [self generateJsonDict];
}

- (void)showWaitMsg:(NSString*)msg handle:(id)handle{
    self.waitMsg = msg;
    self.delegate = handle;
}

-(NSArray*)getIdPropertys:(id)model{
    NSMutableArray *propertys =  [[NSMutableArray alloc] init];
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([model class], &count);
    for(int i = 0; i < count; i++){
        objc_property_t property = properties[i];
        
        NSString *propertName = @"";
        NSString *propType = @"";
        id v = [self getPropertyValueWithObject:model property:property propertName:&propertName propType:&propType];
        
        NSLog(@"name:%@",propertName);   //属性名称
        NSLog(@"propType:%@",propType);  //属性类型
        NSLog(@"v:%@",v);                //属性值
        
        Property *propertyModel = [[Property alloc]init];
        propertyModel.name = propertName;
        propertyModel.type = propType;
        propertyModel.value = v;
        
        [propertys addObject:propertyModel];
    }
    
    return propertys;
}

-(id)getPropertyValueWithObject:(id)object property:(objc_property_t)property propertName:(NSString**)propertName propType:(NSString**)propType{
    
    const char * attributes = property_getAttributes(property);
    NSString *propertyString = [NSString stringWithUTF8String:attributes];
    NSString *startingString = @"T@\"";
    NSString *endingString = @"\",";
    NSInteger startingIndex = [propertyString rangeOfString:startingString].location +startingString.length;
    if (startingIndex < 0)  //非NSObject类型
        return nil;
    
    
    NSString *propTypeTemp = [propertyString substringFromIndex:startingIndex];
    NSInteger endingIndex = [propTypeTemp rangeOfString:endingString].location;
    NSString *propertNameTemp = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
    
    *propertName = propertNameTemp;
    *propType = [propTypeTemp substringToIndex:endingIndex];
    id v = [object valueForKey:propertNameTemp];
    
    return v;
}

#pragma -mark  --------虚拟方法需要接口的子类实现--------------


- (Class)responseType{
    //override me!!!
    return [IObjcJsonBase class];
}

/*
 *拼接接口的路径
 */

- (NSString*)responseCategory{
    
    /*
     overwrite me
     */
    
    return @"";
}



#pragma -mark  --------数据库缓存--------------

/*
 *保存非增量更新类型的结果到本地数据库中
 */
-(void)saveCacheTypeAllToDBWithResult:(id)result{
    
    /*
     *缓存数据的时候过滤经度和纬度，因为他们变化的很快
     */
    NSMutableDictionary *paramsFilterDic = [[NSMutableDictionary alloc]init];
    for(NSString *key in self.paramsPDic.allKeys){
        if([key isEqualToString:@"longitude"] || [key isEqualToString:@"latitude"]){
            continue;
        }
        [paramsFilterDic setObject:[self.paramsPDic objectForKey:key] forKey:key];
    }
    
    NSString *propertiesStr = [SL_Utils strWithDic:paramsFilterDic]; //排序后生成的字符串，保证唯一性。
    if(propertiesStr == nil){
        propertiesStr = @"";
    }
    
    
    /*
     *增加根据 user_phone 和 project_id_owner 过滤缓存数据的 dic
     */
    NSMutableDictionary *filterDic = [[NSMutableDictionary alloc] init];
    NSString *project_id_owner = [WCBaseContext sharedInstance].project_id_owner;
    if(project_id_owner.trim.length > 0){
        [filterDic setObject:project_id_owner forKey:@"project_id"];
    }
    NSString *user_phone = [WCBaseContext sharedInstance].user_phone;
    if(user_phone.length > 0){
        [filterDic setObject:user_phone forKey:@"user_phone"];
    }
    
    NSString *tableName = [NSString stringWithFormat:@"%@_%@",self.interfaceName,NSStringFromClass([self responseType])];
    NSString *columName = NSStringFromClass([self responseType]);
    NSString *md5Str = [NSString stringWithFormat:@"%@_%@_%@",tableName,columName,propertiesStr];
    
    /*
     *MD5Str 添加过滤缓存字段
     */
    for(NSString *key in filterDic.allKeys){
        md5Str = [NSString stringWithFormat:@"%@_cache_filter_%@",md5Str,[filterDic objectForKey:key]];
    }
    
    [[TSStorageManager sharedStorageManager] saveInterFaceCache:[result generateJsonStringForProperties]
                                                      tableName:tableName
                                                     columnName:columName
                                                         md5Str:md5Str
                                                      filterDic:filterDic];
}


/*
 *非增量更新获得本地数据库缓存
 */
-(id)getLocalCacheDataTypeAllFromDB :(NSDictionary*)exInPutDic{
    
    
    /*
     *处理参数，比如user_phone, project_id_owner 为每个参数请求的必须参数，所以需要处理一下。
     */
    //[self prepareParamsAndCacheInputDic];
    
    /*
     *缓存数据的时候过滤经度和纬度，因为他们变化的很快
     */
    if(exInPutDic.allKeys.count > 0){
        for(NSString *key in exInPutDic.allKeys){
            [self.paramsPDic setObject:[exInPutDic objectForKey:key] forKey:key]; //exInPutDic 过滤缓存数据
        }
    }
    
    NSMutableDictionary *paramsFilterDic = [[NSMutableDictionary alloc]init];
    for(NSString *key in self.paramsPDic.allKeys){
        if([key isEqualToString:@"longitude"] || [key isEqualToString:@"latitude"]){
            continue;
        }
        [paramsFilterDic setObject:[self.paramsPDic objectForKey:key] forKey:key];
    }
    
    NSString *propertiesStr = [SL_Utils strWithDic:paramsFilterDic]; //排序后生成的字符串，保证唯一性。
    if(propertiesStr == nil){
        propertiesStr = @"";
    }
    
    
    /*
     *增加根据 user_phone 和 project_id 过滤缓存数据的 dic
     */
    NSMutableDictionary *filterDic = [[NSMutableDictionary alloc] init];
    NSString *project_id_owner = [WCBaseContext sharedInstance].project_id_owner;
    if(project_id_owner.trim.length > 0){
        [filterDic setObject:project_id_owner forKey:@"project_id"];
    }
    NSString *user_phone = [WCBaseContext sharedInstance].user_phone;
    if(user_phone.length > 0){
        [filterDic setObject:user_phone forKey:@"user_phone"];
    }
    
    
    NSString *tableName = [NSString stringWithFormat:@"%@_%@",self.interfaceName,NSStringFromClass([self responseType])];
    NSString *columName = NSStringFromClass([self responseType]);
    NSString *md5Str = [NSString stringWithFormat:@"%@_%@_%@",tableName,columName,propertiesStr];
    /*
     *MD5Str 添加过滤缓存字段
     */
    for(NSString *key in filterDic.allKeys){
        md5Str = [NSString stringWithFormat:@"%@_cache_filter_%@",md5Str,[filterDic objectForKey:key]];
    }
    
    
    /*
     *非增量更新模式下，使用 唯一值 md5Str 取值所以不用 filterDic
     */
    NSString *content = [[TSStorageManager sharedStorageManager] getInterFaceCache:tableName columnName:columName md5Str:md5Str];
    if(content.length > 0){
        id result = [self composeResult:[content objectFromJSONString] attachedFile:nil];
        
        return result;
    }
    return nil;
}


#pragma -mark  --------GET请求--------------

- (void)startGetRequest{
    
    [self startGetWithBlock:nil progressBlock:nil];
}

- (void)startGetWithBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock
            progressBlock:(void (^)(float progress))progressBlock{
    
    NSString *requestUrlString = [self prepareRequestUrl:ERequestTypeGet_JrLoan];
    NSMutableDictionary *interfaceDic = [self composeParams];
    
    
    if(![[Reachability reachabilityForInternetConnection] isReachable]){
        
        NSError *error0=[NSError errorWithDomain:@"LJHui" code:kServiceErrorCode userInfo:[NSDictionary dictionaryWithObject:@"没有网络，请先检查网络设置" forKey:NSLocalizedDescriptionKey]];
        if (finishBlock)
            finishBlock(nil,@"没有网络，请先检查网络设置",NO);
        if([self.delegate respondsToSelector:@selector(service:error:)]){
            [self.delegate service:self error:error0];
        }
        return;
    }
    
    id<WCNetworkOperationProvider> connectionProvider= [[WCBaseContext sharedInstance] connectionProvider];
    self.operation=[connectionProvider createGetRequest:requestUrlString
                                     interfaceClassName:NSStringFromClass([self class])
                                           interfaceDic:interfaceDic
                                          progressBlock:^(float progress) {
                                              if (progressBlock)
                                                  progressBlock(progress);
                                          }
                                           successBlock:^(NSData *responseData){
                                               
                                               [self dealSuccessBlock:responseData finishBlock:finishBlock];
                                           }
                                            failedBlock:^(NSError *error0){
                                                
                                                [self dealFailedBlock:error0 finishBlock:finishBlock];
                                            }
                                            cancelBlock:nil
                                                timeout:self.timeout];
}

- (void)startPostWithBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock
             progressBlock:(void (^)(float progress))progressBlock{
    
    NSString *requestUrlString = [self prepareRequestUrl:ERequestTypePost_JrLoan];
    NSMutableDictionary *interfaceDic = [self composeParams];
    
    if(![[Reachability reachabilityForInternetConnection] isReachable])
    {
        NSError *error0=[NSError errorWithDomain:@"LJHui" code:kServiceErrorCode userInfo:[NSDictionary dictionaryWithObject:@"没有网络，请先检查网络设置" forKey:NSLocalizedDescriptionKey]];
        if (finishBlock)
            finishBlock(nil,@"没有网络，请先检查网络设置",NO);
        if([self.delegate respondsToSelector:@selector(service:error:)]){
            [self.delegate service:self error:error0];
        }
        return;
    }
    if([self.delegate respondsToSelector:@selector(startWithCursor:interfaceName:)]){
        [self.delegate startWithCursor:self.waitMsg interfaceName:self.interfaceName];
    }
    
    id<WCNetworkOperationProvider> connectionProvider= [[WCBaseContext sharedInstance] connectionProvider];
    
    self.operation=[connectionProvider createPostRequest:requestUrlString
                                      interfaceClassName:NSStringFromClass([self class])
                                            interfaceDic:interfaceDic
                                          uploadFilesDic:self.uploadFilesDic
                                           progressBlock:^(float progress) {
                                               if (progressBlock)
                                                   progressBlock(progress);
                                           }
                                            successBlock:^(NSData *responseData){
                                                
                                                [self dealSuccessBlock:responseData finishBlock:finishBlock];
                                            }
                                             failedBlock:^(NSError *error0){
                                                 
                                                 [self dealFailedBlock:error0 finishBlock:finishBlock];
                                             }
                                             cancelBlock:nil
                                                 timeout:self.timeout];
    
}


#pragma -mark  --------Post 请求--------------


- (void)startPostRequest{
    
    [self startPostWithBlock:nil progressBlock:nil];
}


- (void)startGetWithBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock{
    
    [self startGetWithBlock:finishBlock progressBlock:nil];
}

- (void)startPostWithBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock{
    
    [self startPostWithBlock:finishBlock progressBlock:nil];
}

- (void)startGetWithBlock:(void (^)(id result, NSString *msg))cacheBlock
              finishBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock{
    
    self.isCacheToDB = YES;
    [self prepareRequestUrl:ERequestTypePost_JrLoan]; //处理参数
    
    id result = [self getLocalCacheDataTypeAllFromDB:nil];
    if(result){
        cacheBlock(result,@"");
    }
    
    [self startGetWithBlock:finishBlock];
}

- (void)startPostWithBlock:(void (^)(id result, NSString *msg))cacheBlock
               finishBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock{
    
    self.isCacheToDB = YES;
    
    [self prepareRequestUrl:ERequestTypePost_JrLoan]; //处理参数
    
    
   id result = [self getLocalCacheDataTypeAllFromDB:nil];
    if(result){
        cacheBlock(result,@"");
    }
    
    [self startPostWithBlock:finishBlock];
}


#pragma -mark  -------其他--------------

-(void)dealSuccessBlock:(NSData *)responseData finishBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        id file= nil;
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        if( responseString == nil || ![responseString isKindOfClass:[NSString class]] || [responseString.trim isEqualToString:@""]){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (finishBlock){
                    finishBlock(nil,@"无返回数据。",NO);
                }
                if([self.delegate respondsToSelector:@selector(service:error:)]){
                    [self.delegate service:self error:nil];
                }
                if([self.delegate respondsToSelector:@selector(stopWatiCursor:)]){
                    [self.delegate stopWatiCursor:self.interfaceName];
                }
                self.operation= nil;
            });
            
            return;
        }
        
        NSLog(@"\r\n\r\n接口请求类 %@ \r返回数据 = \r%@ \r\n\r\n",NSStringFromClass([self class]),responseString);
        id result = [self composeResult:[responseString objectFromJSONString] attachedFile:file];
        if(self.isCacheToDB == YES){ //数据库缓存处理
            //添加缓存到数据库
            [self saveCacheTypeAllToDBWithResult:result];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger status = [[result valueForKey:@"status"] integerValue];
            NSString *message = [result valueForKey:@"message"];
            
            if(status == 1){
                finishBlock(result, message,YES);
            }
            else if (status == -1){
                //*如果token过期，则需要重新登录获取新的token
                if([self.delegate respondsToSelector:@selector(handleTokenOverdue:)]){
                    [self.delegate handleTokenOverdue:message];
                }
                finishBlock(result,message ,NO);
                return;
            }
            else{
                finishBlock(result, message,NO);
            }
            
            if([self.delegate respondsToSelector:@selector(service:successed:)]){
                [self.delegate service:self successed:result];
            }
            if([self.delegate respondsToSelector:@selector(stopWatiCursor:)]){
                [self.delegate stopWatiCursor:self.interfaceName];
            }
        });
        self.operation= nil;
    });
    
}

-(void)dealFailedBlock:(NSError *)error0 finishBlock:(void (^)(id result, NSString *msg, BOOL finished))finishBlock{
    
    
    NSLog(@"%@ Service Error. ErrorCode: %i. Error Description:%@", NSStringFromClass([self class]),(int)error0.code, [error0 localizedDescription]);
    if (finishBlock){
        //                                                     finishBlock(nil,@"与服务器连接失败。",NO);
        finishBlock(nil,@"业务量有些大,请稍后再试。",NO);
    }
    if([self.delegate respondsToSelector:@selector(service:error:)]){
        [self.delegate service:self error:error0];
    }
    if([self.delegate respondsToSelector:@selector(stopWatiCursor:)]){
        [self.delegate stopWatiCursor:self.interfaceName];
    }
    self.operation= nil;
    
}


- (id)composeResult:(NSDictionary *)dictionary attachedFile:(id)file{
    
    id result=nil;
    if([[self responseType] isSubclassOfClass:[IObjcJsonBase class]]){
        result= [[[self responseType] alloc] initWithDictionary:dictionary];
        ((IObjcJsonBase *)result).attachedFile=file;
    }
    else
    {
        result=dictionary;
    }
    return result;
}

- (void)stop{
    [self.operation cancel];
}

- (void)dealloc{
    NSLog(@"Finalize Service:%@", [self debugDescription]);
    [self stop];
}

@end
