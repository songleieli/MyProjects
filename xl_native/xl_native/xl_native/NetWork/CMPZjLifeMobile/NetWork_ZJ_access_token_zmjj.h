//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//


@interface ZjAccessTokenRespone : IObjcJsonBase


@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,copy) NSString *msg_detail;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,copy) NSString *token;



@end

@interface NetWork_ZJ_access_token_zmjj : WCServiceBase_Zjsh


@property(nonatomic,copy) NSString *open_id;
@property(nonatomic,copy) NSString *mobile;


@end
