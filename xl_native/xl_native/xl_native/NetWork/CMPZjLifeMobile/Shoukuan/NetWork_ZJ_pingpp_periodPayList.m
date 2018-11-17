//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_pingpp_periodPayList.h"


@implementation ZjPingppFeeListItemModel


@end

@implementation ZjPingppFeeTypeListModel


@end

@implementation ZjPingppFeeListModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"items" : @"items"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"items" : @"ZjPingppFeeListItemModel"};
}

@end


@implementation ZjPingppPeriodPayListTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"fee_type_list" : @"fee_type_list",@"fee_lists":@"fee_lists"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"fee_type_list" : @"ZjPingppFeeTypeListModel",@"fee_lists":@"ZjPingppFeeListModel"};
}

@end


@implementation ZjPingppPeriodPayListRoomRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjPingppPeriodPayListTempModel"};
}

@end

@implementation NetWork_ZJ_pingpp_periodPayList

-(Class)responseType{
    return [ZjPingppPeriodPayListRoomRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/pingpp/periodPayList";
}

@end
