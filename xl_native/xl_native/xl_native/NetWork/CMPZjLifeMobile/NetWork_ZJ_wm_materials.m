//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_wm_materials.h"


@implementation ZjWmMaterialsModel


@end

@implementation ZjWmMaterialsTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"material" : @"material"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"material" : @"ZjWmMaterialsModel"};
}

@end


@implementation ZjWmMaterialsRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjWmMaterialsTempModel"};
}

@end

@implementation NetWork_ZJ_wm_materials

-(Class)responseType{
    return [ZjWmMaterialsRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/wm_materials";
}

@end
