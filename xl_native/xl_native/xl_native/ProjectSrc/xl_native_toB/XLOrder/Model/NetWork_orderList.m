//
//  NetWork_orderList.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/24.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "NetWork_orderList.h"

@implementation OrderListGoodModel

@end

@implementation OrderListModel

@end

@implementation OrderListRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"OrderListModel"};
}

@end

@implementation NetWork_orderList

-(Class)responseType{
    return [OrderListRespone class];
}
-(NSString*)responseCategory{
    return @"/mgt/user/voice/order/list";
}

@end
