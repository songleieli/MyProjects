//
//  NetWork_checkSmsValidationCode.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/17.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_checkSmsValidationCode.h"


@implementation ZJCheckSmsValidationCodeData



@end


@implementation ZJCheckSmsValidationCodeRespone




- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"ZJCheckSmsValidationCodeData"};
}



@end


@implementation NetWork_ZJ_checkSmsValidationCode

- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}

-(Class)responseType{
    return [ZJCheckSmsValidationCodeRespone class];
}

-(NSString*)responseCategory{
    return @"/mgt/user/checkSmsValidationCode";
}


@end
