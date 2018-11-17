//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_open_records.h"


@implementation ZjOpenRecordsModel


@end


@implementation ZjOpenRecordsRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjOpenRecordsModel"};
}

@end

@implementation NetWork_ZJ_open_records

-(Class)responseType{
    return [ZjOpenRecordsRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/locker_relations/open_records";
}

@end
