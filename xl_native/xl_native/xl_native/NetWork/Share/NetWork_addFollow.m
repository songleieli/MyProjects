//
//  NetWork_ deleteTopic.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NetWork_addFollow.h"

@implementation AddFollowResponse


@end

@implementation NetWork_addFollow

-(Class)responseType{
    return [AddFollowResponse class];
}

-(NSString*)responseCategory{
    return @"/user/st/villager/follow/addFollow";
}

@end
