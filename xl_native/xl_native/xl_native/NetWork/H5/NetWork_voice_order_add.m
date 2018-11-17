//
//  NetWork_topicPraise.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_voice_order_add.h"

@implementation VoiceOrderResponse



@end


@implementation NetWork_voice_order_add

-(Class)responseType{
    return [VoiceOrderResponse class];
}
-(NSString*)responseCategory{
    return @"/user/st/voice/order/add";
}


@end
