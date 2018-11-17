//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_employee_open_door.h"


@implementation ZjEmployeeOpenDoorModel


@end


@implementation ZjEmployeeOpenDoorRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"dev_list" : @"dev_list"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"dev_list" : @"ZjEmployeeOpenDoorModel"};
}

@end

@implementation NetWork_ZJ_employee_open_door

-(Class)responseType{
    return [ZjEmployeeOpenDoorRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/locker_relations/employee_open_door";
}

@end
