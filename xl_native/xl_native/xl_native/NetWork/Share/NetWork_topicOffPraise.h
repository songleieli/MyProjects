//
//  NetWork_topicOffPraise.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/6/2.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"


@interface TopicOffPraiseResponse : IObjcJsonBase

@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * message;
@property (nonatomic,copy) NSString * data;

@end

@interface NetWork_topicOffPraise : WCServiceBase

@property (nonatomic,copy) NSString * topicId;
@property (nonatomic,copy) NSString * token;

@end
