//
//  NetWork_findCommunityByLikeCommunityName.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/20.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase_Ljh.h"


@interface FindCommunityByLikeCommunityNameModel : IObjcJsonBase

@property(nonatomic,copy) NSString * communityId;
@property(nonatomic,copy) NSString * communityName;
@property(nonatomic,copy) NSString * communityAddress;
@property(nonatomic,copy) NSString * cityName;
@property(nonatomic,copy) NSString * attentionStatus;
/** 当前小区的的物管id */
@property(nonatomic,copy) NSString * sourceSystemCommunityId;
@property(nonatomic,copy) NSString * serverUrl;


@end


@interface FindCommunityByLikeCommunityNameRespone : IObjcJsonBase

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSArray *data;


@end

@interface NetWork_findCommunityByLikeCommunityName : WCServiceBase_Ljh
/** 小区名称 */
@property(nonatomic,copy) NSString * communityName;
@property(nonatomic,copy) NSString * token;

@end
