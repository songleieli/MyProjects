//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_wm_materials_create_application.h"


@implementation ZjCreateApplicationModel


@end

@implementation ZjCreateApplicationTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"material" : @"material"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"material" : @"ZjCreateApplicationModel"};
}

@end


@implementation ZjCreateApplicationRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjCreateApplicationTempModel"};
}

@end

@implementation NetWork_ZJ_wm_materials_create_application

-(Class)responseType{
    return [ZjCreateApplicationRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/wm_materials/create_application";
}

@end
