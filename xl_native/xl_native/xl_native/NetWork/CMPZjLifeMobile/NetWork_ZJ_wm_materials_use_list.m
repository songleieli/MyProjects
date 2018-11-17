//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_wm_materials_use_list.h"


@implementation ZjMaterialsUseListModel


@end

@implementation ZjMaterialsUseListTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"request_use_list" : @"request_use_list"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"request_use_list" : @"ZjMaterialsUseListModel"};
}

@end


@implementation ZjMaterialsUseListRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjMaterialsUseListTempModel"};
}

@end

@implementation NetWork_ZJ_wm_materials_use_list

-(Class)responseType{
    return [ZjMaterialsUseListRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/wm_materials/use_list";
}

@end
