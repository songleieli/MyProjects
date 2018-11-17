//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_wm_materials_sign.h"


@implementation ZjMaterialsSignModel


@end

@implementation ZjMaterialsSignTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"material" : @"material"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"material" : @"ZjMaterialsSignModel"};
}

@end


@implementation ZjMaterialsSignRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjMaterialsSignTempModel"};
}

@end

@implementation NetWork_ZJ_wm_materials_sign

-(Class)responseType{
    return [ZjMaterialsSignRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/wm_materials/sign";
}

@end
