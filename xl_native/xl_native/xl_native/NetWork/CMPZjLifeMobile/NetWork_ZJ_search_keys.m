//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_search_keys.h"

@implementation ScanDevModel


@end

@implementation BlueDoorTempPassword


@end

@implementation ZjSearchKeysModel


@end


//@implementation ZjFeesItemsTempModel
//
//
//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"fees" : @"fees"};
//}
//
//- (NSDictionary *)classNameForItemInArray {
//    return @{@"fees" : @"ZjFeesItemsModel"};
//}
//
//@end



@implementation ZjSearchKeysRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"fees" : @"fees"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"dev_list" : @"ZjSearchKeysModel"};
}

@end

@implementation NetWork_ZJ_search_keys

-(Class)responseType{
    return [ZjSearchKeysRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/locker_relations/search_keys";
}

@end
