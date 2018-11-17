//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//


@interface GetDueAmountModel : IObjcJsonBase

@property(nonatomic,copy) NSString * amount;

@end

@interface ZjGetDueAmountRespone : IObjcJsonBase


@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,strong) GetDueAmountModel *data;


@end

@interface NetWork_ZJ_getDueAmount : WCServiceBase_Zjsh


@property(nonatomic,copy) NSString *openid;
@property(nonatomic,copy) NSString *communityId;


@end
