//
//  NetWork_ deleteTopic.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NetWork_delFollow.h"

@implementation DelFollowResponse


@end

@implementation NetWork_delFollow

-(Class)responseType{
    return [DelFollowResponse class];
}

-(NSString*)responseCategory{
    return @"/user/st/villager/follow/delFollow";
}

@end
