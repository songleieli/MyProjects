//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//


@interface ZjPingppConfirmPayRespone : IObjcJsonBase

@property(nonatomic,strong) NSNumber *status_code;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_pingpp_confirmPay : WCServiceBase_Zjsh

/*
 order_id	业务订单号	123346776544333333
 payer	支付人	张三
 phone	支付人电话	15345454678
 pay_type_id	支付方式	wefgrgrt2233213
 remark	备注	备注信息
 */
@property(nonatomic,copy) NSString *order_id;
@property(nonatomic,copy) NSString *payer;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *pay_type_id;
@property(nonatomic,copy) NSString *remark;

@end
