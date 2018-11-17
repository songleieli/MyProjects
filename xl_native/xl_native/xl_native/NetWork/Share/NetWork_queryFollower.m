//
//  NetWork_findAllTagList.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/6/3.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_queryFollower.h"


@implementation NetWork_queryFollower

-(Class)responseType{
    return [QueryFollowedResponse class];
}
-(NSString*)responseCategory{
    return @"/user/st/villager/follow/queryFollower";
}


@end
