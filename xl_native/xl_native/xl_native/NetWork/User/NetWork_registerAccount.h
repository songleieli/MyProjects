//
//  NetWork_ deleteTopic.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

@interface RegisterAccountResponse : IObjcJsonBase


@property (nonatomic, copy) NSString *data;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *status;

@end
@interface NetWork_registerAccount : WCServiceBase

@property(nonatomic,copy) NSString * code;
@property(nonatomic,copy) NSString * mobile;
@property(nonatomic,copy) NSString * password;
@property(nonatomic,copy) NSString * userName;

@end
