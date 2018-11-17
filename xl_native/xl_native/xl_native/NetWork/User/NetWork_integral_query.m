//
//  NetWork_deduIntegralfind.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/19.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NetWork_integral_query.h"

@implementation NetWork_deduIntegralfindModel



@end
@implementation Integral_queryResponse
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"NetWork_deduIntegralfindModel"};
}



@end

@implementation NetWork_integral_query

-(Class)responseType{
    return [Integral_queryResponse class];
}
-(NSString*)responseCategory{
    return @"/user/st/villager/integral/query";
}
@end
