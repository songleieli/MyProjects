//
//  NetWork_voucherMessage.m
//  xl_native_toB
//
//  Created by MAC on 2018/11/1.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "NetWork_voucherMessage.h"

@implementation VoucherMessageModel

@end

@implementation VoucherMessageRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"VoucherMessageModel"};
}

@end

@implementation NetWork_voucherMessage

-(Class)responseType{
    return [VoucherMessageRespone class];
}
-(NSString*)responseCategory{
    return @"/mgt/user/consume/voucher/getVoucherMessageById";
}

@end
