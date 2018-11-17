//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_wm_materials_search.h"


@implementation ZjMaterialsSearcModel


@end

@implementation ZjMaterialsSearcTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"material" : @"material"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"material" : @"ZjMaterialsSearcModel"};
}

@end


@implementation ZjMaterialsSearcRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjMaterialsSearcTempModel"};
}

@end

@implementation NetWork_ZJ_wm_materials_search

-(Class)responseType{
    return [ZjMaterialsSearcRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/wm_materials/search";
}

@end
