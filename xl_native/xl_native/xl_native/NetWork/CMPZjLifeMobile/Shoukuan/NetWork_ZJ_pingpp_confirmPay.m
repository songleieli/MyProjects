//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_pingpp_confirmPay.h"

@implementation ZjPingppConfirmPayRespone


@end

@implementation NetWork_ZJ_pingpp_confirmPay

-(Class)responseType{
    return [ZjPingppConfirmPayRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/pingpp/confirmPay";
}

@end
