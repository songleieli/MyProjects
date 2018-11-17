//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_pingpp_periodPayListDetail.h"


@implementation ZjPingppPeriodPayListDetailModel


@end


@implementation ZjPingppPeriodPayListDetailRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"result" : @"result"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjPingppPeriodPayListDetailModel"};
}

@end

@implementation NetWork_ZJ_pingpp_periodPayListDetail

-(Class)responseType{
    return [ZjPingppPeriodPayListDetailRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/pingpp/periodPayListDetail";
}

@end
