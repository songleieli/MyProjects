//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_get_last_meter_log.h"


//@implementation ZjGetLastMeterLogLastReadModel
//
//
//@end
//
//
//@implementation ZjGetLastMeterLogModel
//
//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"last_read" : @"last_read"};
//}
//- (NSDictionary *)classNameForItemInArray {
//    return @{@"last_read" : @"ZjGetLastMeterLogLastReadModel"};
//}
//
//@end


@implementation ZjGetLastMeterLogRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjGetUmeterByNodeModel"};
}

@end

@implementation NetWork_ZJ_get_last_meter_log

-(Class)responseType{
    return [ZjGetLastMeterLogRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/umeter_enter_logs/get_last_meter_log";
}

@end
