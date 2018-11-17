//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_fees_save.h"


@implementation ZjFeesSaveModel


@end

@implementation ZjFeesSaveTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"material" : @"material"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"material" : @"ZjFeesSaveModel"};
}

@end


@implementation ZjFeesSaveRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjFeesSaveTempModel"};
}

@end

@implementation NetWork_ZJ_fees_save

-(Class)responseType{
    return [ZjFeesSaveRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/fees";
}

@end
