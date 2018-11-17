//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_get_umeter_by_node.h"

/*
 {
 "equipment_number": "KHDB0000000004",
 "equipment_type": "客户电表",
 "property_number": "A01-01-02-03-01",
 "property_name": "广兰路50弄1幢2号3层301室",
 "customer_name": "火龙果",
 "customer_pnumber": "13900009999",
 "flag": "new",
 "meter_date": "2016-12-20 16:05:09",
 "last_read": [
 {
 "last_read": 0
 }
 ]
 },
 */

//@interface ZjGetLastMeterLogLastReadModel : IObjcJsonBase
//
//@property(nonatomic,copy) NSString * last_read;
//@property(nonatomic,copy) NSString * current_read;
//
//@end
//
//
//@interface ZjGetLastMeterLogModel : IObjcJsonBase
//
//@property(nonatomic,copy) NSString * equipment_number;
//@property(nonatomic,copy) NSString * equipment_type;
//@property(nonatomic,copy) NSString * property_number;
//@property(nonatomic,copy) NSString * property_name;
//@property(nonatomic,copy) NSString * customer_name;
//@property(nonatomic,copy) NSString * customer_pnumber;
//@property(nonatomic,copy) NSString * meter_date;
//@property(nonatomic,strong) NSArray * last_read;
//@property(nonatomic,copy) NSString * flag;
//
//@end



@interface ZjGetLastMeterLogRespone : IObjcJsonBase

@property(nonatomic,strong) ZjGetUmeterByNodeModel *result;
@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_get_last_meter_log : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *equipment_number;

@end
