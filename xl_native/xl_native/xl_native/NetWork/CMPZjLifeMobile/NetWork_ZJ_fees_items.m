//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_fees_items.h"


@implementation ZjFeesItemsModel


@end


@implementation ZjFeesItemsTempModel


- (NSDictionary *)propertyMappingObjcJson {
    return @{@"fees" : @"fees"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"fees" : @"ZjFeesItemsModel"};
}

@end



@implementation ZjFeesItemsRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"fees" : @"fees"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjFeesItemsTempModel"};
}

@end

@implementation NetWork_ZJ_fees_items

-(Class)responseType{
    return [ZjFeesItemsRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/fees/items";
}

@end
