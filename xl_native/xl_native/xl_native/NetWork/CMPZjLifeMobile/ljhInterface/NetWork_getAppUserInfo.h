//
//  NetWork_getAppUserInfo.h
//  CMPLjhMobile
//
//  Created by sl on 16/5/23.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//


@interface AccountInfoModel : IObjcJsonBase


@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *isNewRecord;
@property (nonatomic, copy) NSString *remarks;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSString *relationFlag;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *retTime;
@property (nonatomic, copy) NSString *lastTime;
@property (nonatomic, copy) NSString *lastIp;
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *userIcon;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *twoCode;
@property (nonatomic, copy) NSString *homeAttribute;
@property (nonatomic, copy) NSString *keyWord;
@property (nonatomic, copy) NSString *selectFlag;
//@property (nonatomic, copy) NSString *assetsName;
//@property (nonatomic, copy) NSString *parkingName;
@property (nonatomic, copy) NSString *associatedMobile1;
@property (nonatomic, copy) NSString *associatedMobile2;
@property (nonatomic, copy) NSString *associatedMobile3;
@property (nonatomic, copy) NSString *signCollectionAgreementFlag;
@property (nonatomic, copy) NSString *registrationInvitationCode;
@property (nonatomic, copy) NSString *integralBalance;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *nativeCreateTime;
// relevanceCommunityName
@property (nonatomic, copy) NSString *relevanceCommunityName;

@end


@interface GetAppUserInfoRespone : IObjcJsonBase


@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) AccountInfoModel *data;


@end

@interface NetWork_getAppUserInfo : WCServiceBase_Ljh


@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *mobile;


@end
