//
//  NetWork_login.m
//  JrLoanMobile
//
//  Created by song leilei on 15/11/17.
//  Copyright © 2015年 Junrongdai. All rights reserved.
//

#import "NetWork_login.h"

@implementation LoginModel



@end

@implementation LoignRespone


- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"LoginModel"};
}

@end

@implementation NetWork_login

- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}

-(Class)responseType{
    return [LoignRespone class];
}

-(NSString*)responseCategory{
    return @"/user/appuser/login";
}

@end
