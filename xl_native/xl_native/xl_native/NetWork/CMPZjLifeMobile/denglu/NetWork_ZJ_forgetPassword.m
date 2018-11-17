//
//  NetWork_forgetPassword.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/17.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_forgetPassword.h"

@implementation ZJForgetPasswordRespone



@end


@implementation NetWork_ZJ_forgetPassword


-(Class)responseType{
    return [ZJForgetPasswordRespone class];
}

-(NSString*)responseCategory{
    return @"/mgt/user/forgetPassword";
}

- (NSString*)responeApiType{
    /*
     overwrite me  appNameProperty：物业APP；appNameOwner：业主APP
     
     调用乐家慧接口需要重写改方法并返回appNameOwner，默认是appNameProperty，调用物管接口
     
     */
    
    return @"appNameOwner";
}

@end
