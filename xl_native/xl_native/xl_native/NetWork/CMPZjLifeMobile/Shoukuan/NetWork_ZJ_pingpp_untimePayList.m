//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_pingpp_untimePayList.h"


//@implementation ZjPingppUntimePayItemModel
//
//
//@end
//
//
//@implementation ZjPingppUntimePayListModel
//
//
//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"items" : @"items"};
//}
//
//- (NSDictionary *)classNameForItemInArray {
//    return @{@"items" : @"ZjPingppUntimePayItemModel"};
//}
//
//
//@end



@implementation ZjPingppUntimePayListTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"fee_lists" : @"fee_lists"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"fee_lists" : @"ZjPingppFeeListModel"};
}

@end


@implementation ZjPingppUntimePayListRoomRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjPingppUntimePayListTempModel"};
}

@end

@implementation NetWork_ZJ_pingpp_untimePayList

-(Class)responseType{
    return [ZjPingppUntimePayListRoomRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/pingpp/untimePayList";
}

@end
