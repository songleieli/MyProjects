//
//  NetWork_ activityCommentList.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

@interface AppUserOauthRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,copy) NSString * totall;

@property(nonatomic,strong) NSObject *data;

@end

@interface NetWork_appuser_oauth : WCServiceBase

@property(nonatomic,copy) NSString *token;
@property(nonatomic,copy) NSString *idcard;
@property(nonatomic,copy) NSString *userName;

@end
