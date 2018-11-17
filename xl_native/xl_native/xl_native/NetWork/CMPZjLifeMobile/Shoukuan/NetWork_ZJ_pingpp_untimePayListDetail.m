//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_pingpp_untimePayListDetail.h"


@implementation ZjPingppUntimePayListDetailModel


@end


@implementation ZjPingppUntimePayListDetailRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"result" : @"result"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjPingppUntimePayListDetailModel"};
}

@end

@implementation NetWork_ZJ_pingpp_untimePayListDetail

-(Class)responseType{
    return [ZjPingppUntimePayListDetailRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/pingpp/untimePayListDetail";
}

@end
