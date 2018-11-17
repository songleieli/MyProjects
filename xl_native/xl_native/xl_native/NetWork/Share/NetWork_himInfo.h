//
//  NetWork_himInfo.h
//  xl_native
//
//  Created by MAC on 2018/10/12.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface HimInfoModel : IObjcJsonBase

@property (copy, nonatomic) NSString *attentionCommunityName;
@property (copy, nonatomic) NSString *followedCount;
@property (copy, nonatomic) NSString *followerCount;
@property (copy, nonatomic) NSString *gender;
@property (assign, nonatomic) BOOL isAttention;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *profession;
@property (copy, nonatomic) NSString *selfIntroduction;
@property (copy, nonatomic) NSString *topicCount;
@property (copy, nonatomic) NSString *userIcon;
@property (copy, nonatomic) NSString *userId;

@end

@interface HimInfoRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) HimInfoModel * data;

@end

@interface NetWork_himInfo : WCServiceBase

@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *userId;

@end

NS_ASSUME_NONNULL_END
