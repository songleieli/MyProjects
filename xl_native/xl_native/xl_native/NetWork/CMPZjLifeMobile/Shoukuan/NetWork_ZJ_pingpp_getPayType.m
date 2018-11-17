//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_pingpp_getPayType.h"


@implementation ZjPingppGetPayTypeModel


@end


@implementation ZjPingppGetPayTypeRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"result" : @"result"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjPingppGetPayTypeModel"};
}

@end

@implementation NetWork_ZJ_pingpp_getPayType

-(Class)responseType{
    return [ZjPingppGetPayTypeRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/pingpp/getPayType";
}

@end
