//
//  NetWork_ deleteTopic.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

@interface DeleteReplyTopicResponse : IObjcJsonBase


@property (nonatomic, copy) NSString *data;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *status;

@end
@interface NetWork_deleteReply : WCServiceBase

@property(nonatomic,copy) NSString * token;
@property(nonatomic,copy) NSString * id;

@end
