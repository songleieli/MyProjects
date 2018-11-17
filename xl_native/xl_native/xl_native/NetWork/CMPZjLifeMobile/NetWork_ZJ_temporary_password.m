//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_temporary_password.h"


@implementation ZjTemporaryPasswordModel


@end


@implementation ZjTemporaryPasswordRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"fees" : @"fees"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"dev_list" : @"ZjTemporaryPasswordModel"};
}

@end

@implementation NetWork_ZJ_temporary_password

-(Class)responseType{
    return [ZjTemporaryPasswordRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/locker_relations/temporary_password";
}

@end
