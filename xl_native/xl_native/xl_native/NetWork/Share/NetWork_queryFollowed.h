//
//  NetWork_findAllTagList.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/6/3.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

@interface QueryFollowedModel: IObjcJsonBase

@property(nonatomic,copy) NSString * USER_ICON;
@property(nonatomic,copy) NSString * USER_NAME;
@property(nonatomic,copy) NSString * id;

@end

@interface QueryFollowedTempModel: IObjcJsonBase

@property(nonatomic,strong) NSNumber * followCount;
@property(nonatomic,strong) NSArray * followList;


@end



@interface QueryFollowedResponse : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSNumber * totall;
@property(nonatomic,strong) QueryFollowedTempModel * data;


@end



@interface NetWork_queryFollowed : WCServiceBase


@property(nonatomic,strong) NSNumber * page;
@property(nonatomic,strong) NSNumber * pageSize;
@property(nonatomic,copy) NSString * token;
@property(nonatomic,copy) NSString * uid;


@end
