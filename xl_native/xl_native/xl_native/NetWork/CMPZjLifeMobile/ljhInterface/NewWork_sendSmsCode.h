//
//  NewWork_sendSmsCode.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/4/21.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase_Ljh.h"


@interface SendSmsCodeModel : IObjcJsonBase
@property(nonatomic,copy) NSString * mobile;
@property(nonatomic,copy) NSString * code;
@end

@interface SendSmsCodeResponse : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) SendSmsCodeModel * data;

@end


@interface NewWork_sendSmsCode : WCServiceBase_Ljh
@property(nonatomic,copy) NSString * mobile;
@property (nonatomic,copy)NSString * type;
@property (nonatomic,copy)NSString * validateCode;

@end
