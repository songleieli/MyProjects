//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_pingpp_getUntimeFeeType.h"


@implementation ZjGetUntimeFeeTypeModel


@end



@implementation ZjGetUntimeFeeTypeRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"result" : @"result"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjGetUntimeFeeTypeModel"};
}

@end

@implementation NetWork_ZJ_pingpp_getUntimeFeeType

-(Class)responseType{
    return [ZjGetUntimeFeeTypeRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/pingpp/getUntimeFeeType";
}

@end
