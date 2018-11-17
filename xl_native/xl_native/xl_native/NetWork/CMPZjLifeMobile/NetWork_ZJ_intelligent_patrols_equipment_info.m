//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_intelligent_patrols_equipment_info.h"


@implementation ZjEquipmentInfoModel


@end


@implementation ZjEquipmentInfoRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjEquipmentInfoModel"};
}

@end

@implementation NetWork_ZJ_intelligent_patrols_equipment_info

-(Class)responseType{
    return [ZjEquipmentInfoRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/intelligent_patrols/equipment_info";
}

@end
