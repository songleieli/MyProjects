//
//  NetWork_ deleteTopic.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NetWork_deleteTopic.h"

@implementation deleteTopicResponse


@end
@implementation NetWork_deleteTopic
- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}

-(Class)responseType{
    return [deleteTopicResponse class];
}

-(NSString*)responseCategory{
    return @"/user/st/neighborhood/deleteTopic";
}

@end
