//
//  NetWork_updatePassword.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/25.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_updatePassword.h"

@implementation updatePasswordRespone


@end

@implementation NetWork_updatePassword

- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}

-(Class)responseType{
    return [updatePasswordRespone class];
}
-(NSString*)responseCategory{
    return @"/user/st/appuser/updatePassword";
}

@end
