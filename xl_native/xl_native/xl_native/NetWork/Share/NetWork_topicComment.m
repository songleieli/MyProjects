//
//  NetWork_topicComment.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/30.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_topicComment.h"


@implementation TopicCommentResponse

- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"publishTopicModel"};
}

@end

@implementation NetWork_topicComment

-(Class)responseType{
    return [TopicCommentResponse class];
}
-(NSString*)responseCategory{
    return @"/user/st/neighborhood/topicComment";
}
@end
