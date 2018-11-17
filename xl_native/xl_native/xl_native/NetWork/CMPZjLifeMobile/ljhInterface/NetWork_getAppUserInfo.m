//
//  NetWork_getAppUserInfo.m
//  CMPLjhMobile
//
//  Created by sl on 16/5/23.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_getAppUserInfo.h"

@implementation AccountInfoModel



@end

@implementation GetAppUserInfoRespone

-(NSDictionary *)classNameForItemInArray{
    
    return @{@"data":@"AccountInfoModel"};
}
@end

@implementation NetWork_getAppUserInfo

- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}

-(Class)responseType{
    return [GetAppUserInfoRespone class];
}

-(NSString*)responseCategory{
    return @"/user/st/appuser/getAppUserInfo";
}

@end
