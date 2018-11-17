//
//  NetWork_topicComment.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/30.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

#import "Network_publishTopic.h"





@interface TopicCommentResponse : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong)publishTopicModel * data;

@end

@interface NetWork_topicComment : WCServiceBase

@property(nonatomic,copy) NSString * topicId;
@property(nonatomic,copy) NSString * token;
@property(nonatomic,copy) NSString * content;
@property(nonatomic,copy) NSString * replyId;


@end
