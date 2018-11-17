//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_complete_record.h"

@implementation ZjCompleteRecordInputParameterModel


@end

@implementation ZjCompleteRecordModel


@end


@implementation ZjCompleteRecordRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"result" : @"result"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjCompleteRecordModel"};
}

@end

@implementation NetWork_ZJ_complete_record

-(Class)responseType{
    return [ZjCompleteRecordRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/patrol_comprehensive/complete_record";
}

@end
