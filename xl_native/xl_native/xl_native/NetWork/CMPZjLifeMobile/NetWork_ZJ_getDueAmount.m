//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_getDueAmount.h"


@implementation GetDueAmountModel

@end

@implementation ZjGetDueAmountRespone



- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"GetDueAmountModel"};
}

@end

@implementation NetWork_ZJ_getDueAmount

-(Class)responseType{
    return [ZjGetDueAmountRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/pingpp/getDueAmount";
}

//- (NSString*)responeApiType{
//    /*
//     overwrite me  appNameProperty：物业APP；appNameOwner：业主APP
//     
//     调用乐家慧接口需要重写改方法并返回appNameOwner，默认是appNameProperty，调用物管接口
//     
//     */
//    
//    return @"appNameOwner";
//}

@end
