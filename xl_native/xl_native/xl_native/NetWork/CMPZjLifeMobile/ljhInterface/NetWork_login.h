//
//  NetWork_login.h
//  JrLoanMobile
//
//  Created by song leilei on 15/11/17.
//  Copyright © 2015年 Junrongdai. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LoginModel : IObjcJsonBase

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *tgt;
@property (nonatomic, copy) NSString *st;
@property (nonatomic, copy) NSString *userId; //userid,判断邻里的回复是不是当前用户使用

@property (nonatomic, copy) NSString *sourceSystemCommunityId; //物管云系统小区Id
@property (nonatomic, copy) NSString *sourceSystem;   //源系统代码部署物业公司
@property (nonatomic, copy) NSString *serverUrl;               //物管云配置地址
@property (nonatomic, copy) NSString *coreUserId;              //核心用户Id
@property (nonatomic, copy) NSString *openid;                  //物管云openId，查找关联房产对应的



@property (nonatomic, copy) NSString *attentionCommunityId;
@property (nonatomic, copy) NSString *attentionCommunityName;

@property (nonatomic, copy) NSString *relevanceCommunityId;
@property (nonatomic, copy) NSString *relevanceCommunityName;
@property (nonatomic, copy) NSString *relevanceCommunityPhoneNumber;

@property (nonatomic, copy) NSString *userPwd;

@end


@interface LoignRespone : IObjcJsonBase


@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) LoginModel *data;


@end

@interface NetWork_login : WCServiceBase_Ljh
/*
 mobile             用户名
 password           密码
 */
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *password;

@end
