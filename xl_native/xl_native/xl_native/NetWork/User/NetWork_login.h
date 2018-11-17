//
//  NetWork_ activityCommentList.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//


@interface LoginDataModel : IObjcJsonBase

@property(nonatomic,strong) NSString * attentionCommunityId; //村落id
@property(nonatomic,copy) NSString * attentionCommunityName; //村落名称
@property(nonatomic,copy) NSString * integralBalance;        //剩余积分
@property(nonatomic,copy) NSString * email;                  //email
@property(nonatomic,copy) NSString * lastIp;                 //最后登录ip
@property(nonatomic,copy) NSString * lastTime;               //最后登录时间
@property(nonatomic,copy) NSString * mobile;                 //手机号
@property(nonatomic,copy) NSString * nickName;               //昵称
@property(nonatomic,copy) NSString * relationFlag;           //是否已实名认证
@property(nonatomic,copy) NSString * retTime;                //注册时间
@property(nonatomic,copy) NSString * selfIntroduction;       //自我介绍
@property(nonatomic,copy) NSString * token;                  //token
@property(nonatomic,copy) NSString * twoCode;                //二维码
@property(nonatomic,copy) NSString * userIcon;               //头像
@property(nonatomic,copy) NSString * userId;                 //userid
@property(nonatomic,copy) NSString * userName;               //用户昵称
@property(nonatomic,copy) NSString * userType;               //用户类型

@property (copy, nonatomic) NSString *topicCount;
@property (copy, nonatomic) NSString *followedCount;
@property (copy, nonatomic) NSString *followerCount;

@end

@interface ZjLoginRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,copy) NSString * totall;

@property(nonatomic,strong) LoginDataModel * data;

@end

@interface NetWork_login : WCServiceBase

@property(nonatomic,copy) NSString *mobile;
@property(nonatomic,copy) NSString *password;

@end
