//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_pingpp_periodGenerateOrder.h"


@implementation ZjPingppPeriodGenerateOrderModel



@end


@implementation ZjPingppPeriodGenerateOrderRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjPingppPeriodGenerateOrderModel"};
}

@end

@implementation NetWork_ZJ_pingpp_periodGenerateOrder

-(Class)responseType{
    return [ZjPingppPeriodGenerateOrderRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/pingpp/periodGenerateOrder";
}

///*
// *临时测试使用
// */
//
//-(NSString*)responeTempBaseUrl{
//    return @"http://10.16.65.176:3000";
//}


@end
