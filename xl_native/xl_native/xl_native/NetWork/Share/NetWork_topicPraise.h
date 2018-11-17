//
//  NetWork_topicPraise.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

@interface TopicPraiseResponse : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,copy) NSString * data;

@end

@interface NetWork_topicPraise : WCServiceBase

@property (nonatomic,strong) NSString * topicId;
@property (nonatomic,strong) NSString * token;


@end
