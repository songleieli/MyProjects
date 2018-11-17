//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_pingpp_searchRoom.h"


@implementation ZjPingppSearchRoomModel


@end


@implementation ZjPingppSearchRoomTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"house_list" : @"house_list"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"house_list" : @"ZjPingppSearchRoomModel"};
}

@end


@implementation ZjPingppSearchRoomRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjPingppSearchRoomTempModel"};
}

@end

@implementation NetWork_ZJ_pingpp_searchRoom

-(Class)responseType{
    return [ZjPingppSearchRoomRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/pingpp/searchRoom";
}

@end
