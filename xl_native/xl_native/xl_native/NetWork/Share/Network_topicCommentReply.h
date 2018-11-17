//
//  Network_publishTopic.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/30.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"



@interface TopicCommentReplyModel : IObjcJsonBase

@property(nonatomic,copy)NSString * returnCode;
@property(nonatomic,copy)NSString * message;
@property(nonatomic,copy)NSString * balance;
@property(nonatomic,copy)NSString * credits;

@end


//@interface publishTopicModel : IObjcJsonBase
//
//@property(nonatomic,strong)publishTopicintegralResultModel * integralResult;
//
//@end

@interface TopicCommentReplyResponse : IObjcJsonBase

@property(nonatomic,copy)NSString * status;
@property(nonatomic,copy)NSString * message;
@property(nonatomic,strong)TopicCommentReplyModel * data;
@end


@interface Network_topicCommentReply : WCServiceBase

@property(nonatomic,copy)NSString * replyId; //【Y】，回复评论时，就是评论id,回复回复时就是回复id
@property(nonatomic,copy)NSString * token;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * commentId;


@end
