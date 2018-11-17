//
//  NetWork_addIntegral.m
//  xl_native
//
//  Created by MAC on 2018/9/21.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "NetWork_addIntegral.h"

@implementation AddIntegralRespone

@end

@implementation NetWork_addIntegral

-(Class)responseType{
    return [AddIntegralRespone class];
}
-(NSString*)responseCategory{
    return @"/user/st/villager/integral/add";
}

@end
