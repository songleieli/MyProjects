//
//  Network_publishTopic.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/30.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "Network_topicCommentReply.h"



@implementation TopicCommentReplyModel



@end

//@implementation publishTopicModel
//
//- (NSDictionary *)classNameForItemInArray {
//    return @{@"integralResult" : @"publishTopicintegralResultModel"};
//}
//@end



@implementation TopicCommentReplyResponse

- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"TopicCommentReplyModel"};
}

@end


@implementation Network_topicCommentReply

-(Class)responseType{
    
    return [TopicCommentReplyResponse class];
}
-(NSString*)responseCategory{
    return @"/user/st/neighborhood/topicCommentReply";
}



@end
