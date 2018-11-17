//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_wm_request_material_index.h"


@implementation ZjRequestMaterialIndexModel


@end

@implementation ZjRequestMaterialIndexTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"request_materials" : @"request_materials"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"request_materials" : @"ZjRequestMaterialIndexModel"};
}

@end


@implementation ZjRequestMaterialIndexRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjRequestMaterialIndexTempModel"};
}

@end

@implementation NetWork_ZJ_wm_request_material_index

-(Class)responseType{
    return [ZjRequestMaterialIndexRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/wm_materials/request_material_index";
}

@end
