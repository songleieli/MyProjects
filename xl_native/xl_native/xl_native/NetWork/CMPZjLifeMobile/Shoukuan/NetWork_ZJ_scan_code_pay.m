//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_scan_code_pay.h"


@implementation ZjScanCoderModel



@end


@implementation ZjScanCodePayRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjScanCoderModel"};
}

@end

@implementation NetWork_ZJ_scan_code_pay

-(Class)responseType{
    return [ZjScanCodePayRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/scan_code_pay/get_pingpp_qr_code";
}

///*
// *临时测试使用
// */
//
//-(NSString*)responeTempBaseUrl{
//    return @"http://10.16.65.176:3000";
//}


@end
