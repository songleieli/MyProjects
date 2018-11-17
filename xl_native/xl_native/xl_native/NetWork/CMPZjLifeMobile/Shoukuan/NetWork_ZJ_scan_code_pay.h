//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//


@interface ZjScanCoderModel : IObjcJsonBase


@property(nonatomic,copy) NSString *code_url;

@end



@interface ZjScanCodePayRespone : IObjcJsonBase

@property(nonatomic,strong) ZjScanCoderModel *result;
@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_scan_code_pay : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *order_id;
@property(nonatomic,copy) NSString *pay_channel;
@property(nonatomic,copy) NSString *mobile_ip;

@end
