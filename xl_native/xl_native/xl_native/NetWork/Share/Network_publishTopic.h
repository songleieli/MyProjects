//
//  Network_publishTopic.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/30.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//


@interface publishTopicintegralResultModel : IObjcJsonBase

@property(nonatomic,copy)NSString * returnCode;
@property(nonatomic,copy)NSString * message;
@property(nonatomic,copy)NSString * balance;
@property(nonatomic,copy)NSString * credits;

@end


@interface publishTopicModel : IObjcJsonBase

@property(nonatomic,strong)publishTopicintegralResultModel * integralResult;

@end

@interface publishTopicResponse : IObjcJsonBase

@property(nonatomic,copy)NSString * status;
@property(nonatomic,copy)NSString * message;
@property(nonatomic,strong)publishTopicModel * data;
@end


@interface Network_publishTopic : WCServiceBase

@property(nonatomic,strong)NSString * token;
@property(nonatomic,copy)NSString * topicContent;
@property(nonatomic,copy)NSString * urls;
@property(nonatomic,copy)NSString * typeId;
@property(nonatomic,copy)NSString * communityId;
@property(nonatomic,strong)NSNumber * longitude;
@property(nonatomic,strong)NSNumber * latitude;
@property(nonatomic,copy)NSString * topicType;


@end
