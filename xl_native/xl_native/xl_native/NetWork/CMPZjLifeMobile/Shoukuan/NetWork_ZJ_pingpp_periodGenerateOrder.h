//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//


@interface ZjPingppPeriodGenerateOrderModel : IObjcJsonBase

/*
 "order_id": "d3de25654dc6841495866200",
 "total": 336.94
 */

@property(nonatomic,copy) NSString *order_id;
@property(nonatomic,copy) NSString *total;

@end



@interface ZjPingppPeriodGenerateOrderRespone : IObjcJsonBase

@property(nonatomic,strong) ZjPingppPeriodGenerateOrderModel *result;
@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_pingpp_periodGenerateOrder : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *house_list;
@property(nonatomic,copy) NSString *fee_type_list;
@property(nonatomic,copy) NSString *start_time;
@property(nonatomic,copy) NSString *end_time;
@property(nonatomic,copy) NSString *fee_list;

@end
