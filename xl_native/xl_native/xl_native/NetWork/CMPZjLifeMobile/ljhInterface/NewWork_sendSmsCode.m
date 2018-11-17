//
//  NewWork_sendSmsCode.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/4/21.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NewWork_sendSmsCode.h"

@implementation SendSmsCodeModel



@end

@implementation SendSmsCodeResponse


- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"SendSmsCodeModel"};
}

@end

@implementation NewWork_sendSmsCode
- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}

-(Class)responseType{
    return [SendSmsCodeResponse class];
}

-(NSString*)responseCategory{
    return @"/user/sendSmsCode";
}

@end
