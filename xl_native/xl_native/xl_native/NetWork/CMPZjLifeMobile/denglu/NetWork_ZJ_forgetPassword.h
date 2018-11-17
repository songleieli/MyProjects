//
//  NetWork_forgetPassword.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/17.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase_Ljh.h"


@interface ZJForgetPasswordRespone:IObjcJsonBase

@property (nonatomic, copy) NSString *status;

/** 状态信息 */
@property(nonatomic,strong) NSString * message;

/** 返回信息 */
@property(nonatomic,strong) NSString * data;

@end

@interface NetWork_ZJ_forgetPassword : WCServiceBase_Zjsh
/** 手机号 */
@property(nonatomic,copy) NSString * mobile;

/** 新密码 */
@property(nonatomic,copy) NSString * password;

@property(nonatomic,copy) NSString * updatePasswordToken;

@end
