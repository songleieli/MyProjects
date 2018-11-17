//
//  WCConfiguration.h
//  winCRM
//
//  Created by Songlei Lei on 5/23/13.
//  Copyright (c) 2013 com.cailei. All rights reserved.
//

#import "IObjcJsonBase.h"

@interface WCBaseConfiguration : IObjcJsonBase

@property (nonatomic, copy) NSString *buildType;
@property (nonatomic, copy) NSString *interfaceVersion;
@property (nonatomic, copy) NSString *app_name;
@property (nonatomic, copy) NSString *group_name;
@property (nonatomic, copy) NSString *platform_name;
@property (nonatomic, copy) NSString *src_name;
@property (nonatomic, strong) NSDictionary *encryptionDic;
@property (nonatomic, strong) NSArray *h5_whitelist;

//adressType
@property (nonatomic, strong) NSString *adressType;

//@property (nonatomic, strong) NSDictionary *ljhH5url;

@property (nonatomic, strong) NSString *baseBusinessH5;
@property (nonatomic, strong) NSString *baseNoticeUrl;
@property (nonatomic, strong) NSString *dealForUser;
//@property (nonatomic, strong) NSString *baseCommunityIntroduceUrl;





//@property (nonatomic, copy) NSString *naviURL;
//@property (nonatomic, copy) NSString *naviURLTest;
//@property (nonatomic, copy) NSString *jrdAppKey;
//@property (nonatomic, copy) NSString *jrdAppKeyTest;
//@property (nonatomic, copy) NSString *rsaPublicKey;
//@property (nonatomic, copy) NSString *rsaPublicKeyTest;

@end
