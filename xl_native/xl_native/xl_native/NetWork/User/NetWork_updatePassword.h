//
//  NetWork_updatePassword.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/25.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"
@interface updatePasswordRespone : IObjcJsonBase
@property(nonatomic,copy) NSString * message;
@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * data;
@end

@interface NetWork_updatePassword : WCServiceBase
@property(nonatomic,copy) NSString * mobile;
@property(nonatomic,copy) NSString * password;
@property(nonatomic,copy) NSString * oldPassword;
@property(nonatomic,copy) NSString * token;

@end
