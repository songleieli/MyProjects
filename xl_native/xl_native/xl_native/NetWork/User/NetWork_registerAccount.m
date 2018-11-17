//
//  NetWork_ deleteTopic.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NetWork_registerAccount.h"

@implementation RegisterAccountResponse


@end

@implementation NetWork_registerAccount

-(Class)responseType{
    return [RegisterAccountResponse class];
}

-(NSString*)responseCategory{
    return @"/user/appuser/registerAccount";
}

@end
