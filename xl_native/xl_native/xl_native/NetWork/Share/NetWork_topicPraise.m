//
//  NetWork_topicPraise.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_topicPraise.h"

@implementation TopicPraiseResponse



@end


@implementation NetWork_topicPraise

-(Class)responseType{
    return [TopicPraiseResponse class];
}
-(NSString*)responseCategory{
    return @"/user/st/neighborhood/topicPraise";
}


@end
