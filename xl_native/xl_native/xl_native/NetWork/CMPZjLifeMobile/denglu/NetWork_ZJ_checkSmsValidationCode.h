//
//  NetWork_checkSmsValidationCode.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/17.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase_Ljh.h"


@interface ZJCheckSmsValidationCodeData : IObjcJsonBase

@property(nonatomic,copy) NSString * updatePasswordToken;
@property(nonatomic,copy) NSString * messageWarning;

@end



@interface ZJCheckSmsValidationCodeRespone : IObjcJsonBase

@property (nonatomic, copy) NSString *status;

@property(nonatomic,strong) NSString * message;
@property(nonatomic,strong) ZJCheckSmsValidationCodeData * data;

@end



@interface NetWork_ZJ_checkSmsValidationCode : WCServiceBase_Ljh
/** 短信验证码 */
@property(nonatomic,strong) NSString * smsValidationCode;
/** 手机号 */
@property(nonatomic,strong) NSString * mobile;

@end
