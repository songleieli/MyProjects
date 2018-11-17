//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

@interface ZjPingppPeriodPayListDetailModel : IObjcJsonBase

/*
 "property_name": "广兰路50弄1幢2号3层302室",
 "fee_name": "物业管理费",
 "period_list": "2017:12,2018:01,02,03,05,06,07,08,09,10,11,12",
 "quantity": "1.0",
 "price": "0.02",
 "total_amount": 0.24,
 "discount_amount": 0
 */

@property(nonatomic,copy) NSString *property_name;
@property(nonatomic,copy) NSString *fee_name;
@property(nonatomic,copy) NSString *period_list;
@property(nonatomic,copy) NSString *quantity;
@property(nonatomic,copy) NSNumber *price;
@property(nonatomic,copy) NSNumber *total_amount;
@property(nonatomic,copy) NSNumber *discount_amount;

@end



@interface ZjPingppPeriodPayListDetailRespone : IObjcJsonBase

@property(nonatomic,strong) NSArray *result;
@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_pingpp_periodPayListDetail : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *property_number;
@property(nonatomic,copy) NSString *fee_type_list;
@property(nonatomic,copy) NSString *start_time;
@property(nonatomic,copy) NSString *end_time;

@end
