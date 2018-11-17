//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 {
 "result": {
 "pay_party": "ALL_SETTLE",
 "pay_party_mean": "公共维修基金结算",
 "settlement": "NO",
 "repair_reason": "Qqqqqqqqqq",
 "add_explain": "",
 "repairpic_path": "http://10.16.199.64:3002//upload/cmi/mdm_repair_exes/1826116090.jpg",
 "repairpicend_path": "",
 "repair_fee": "0.0",
 "part_fee": "484.0"
 },
 "errmsg=": null,
 "status_code=": "200"
 }
 */



@interface ZjGetRepairExModel : IObjcJsonBase

@property(nonatomic,copy) NSString * pay_party;
@property(nonatomic,copy) NSString * pay_party_mean;
@property(nonatomic,copy) NSString * settlement;
@property(nonatomic,copy) NSString * repair_reason;
@property(nonatomic,copy) NSString * add_explain;
@property(nonatomic,copy) NSString * repairpic_path;
@property(nonatomic,copy) NSString * repairpicend_path;
@property(nonatomic,copy) NSString * repair_fee;
@property(nonatomic,copy) NSString * part_fee;


@end



@interface ZjGetRepairExRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjGetRepairExModel * result;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_incident_requests_get_repair_ex : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *request_number;


@end
