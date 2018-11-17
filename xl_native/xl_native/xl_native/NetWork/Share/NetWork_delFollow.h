//
//  NetWork_ deleteTopic.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

@interface DelFollowResponse : IObjcJsonBase


@property (nonatomic, copy) NSString *data;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *status;

@end
@interface NetWork_delFollow : WCServiceBase

@property(nonatomic,copy) NSString * token;
@property(nonatomic,copy) NSString * followedId;

@end
