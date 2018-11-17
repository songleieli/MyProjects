//
//  NetWork_orders.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/25.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "NetWork_orders.h"

@implementation OrdersRespone

@end

@implementation NetWork_orders

-(Class)responseType{
    return [OrdersRespone class];
}
-(NSString*)responseCategory{
    if (self.type == 1) {
        return @"/mgt/user/voice/order/received";
    } else if (self.type == 2) {
        return @"/mgt/user/voice/order/refuse";
    }
    return @"";
}

@end
