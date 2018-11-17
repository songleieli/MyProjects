//
//  NetWork_ deleteTopic.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NetWork_deleteReply.h"

@implementation DeleteReplyTopicResponse


@end

@implementation NetWork_deleteReply
- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}

-(Class)responseType{
    return [DeleteReplyTopicResponse class];
}

-(NSString*)responseCategory{
    return @"/user/st/neighborhood/deleteReply";
}

@end
