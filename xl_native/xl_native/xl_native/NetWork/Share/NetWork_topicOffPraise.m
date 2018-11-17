//
//  NetWork_topicOffPraise.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/6/2.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_topicOffPraise.h"

@implementation TopicOffPraiseResponse



@end

@implementation NetWork_topicOffPraise

-(Class)responseType{
    return [TopicOffPraiseResponse class];
}

-(NSString*)responseCategory{
    return @"/user/st/neighborhood/topicOffPraise";
}


@end
