//
//  NetWork_inviteNewUser.h
//  xl_native
//
//  Created by MAC on 2018/10/10.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//


@interface InviteNewUserRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSObject * data;

@end

@interface NetWork_inviteNewUser : WCServiceBase

@property (copy, nonatomic) NSString * userId;
@property (copy, nonatomic) NSString *token;

@end


