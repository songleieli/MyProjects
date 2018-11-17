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
 "request_number": "01201612020006",
 "request_time": "2016-12-02 17:02:33",
 "category": "公共区域=>电梯系统=>复查",
 "contact": "qujianchao",
 "contact_phone": "18618347999",
 "incident_status": "NEW",
 "describing": "Wrwerwrwrwerwrwerwrewerwerwerwerwerwer",
 "start_time": null,
 "end_time": null,
 "fee": 0,
 "repair_fee": 0,
 "material_fee": 0,
 "total_fee": 0,
 "repairpic_path": "http://10.16.199.64:3002//upload/cmi/mdm_repair_exes/1702331648.jpg",
 "repairpicend_path": "",
 "node_name": "广兰路50弄1幢7号3层302室",
 "handing_suggestion": null,
 "note": null
 },
 "status_code": "200"
 }
 */

@interface ZjIncidentRequestsShowModel : IObjcJsonBase

@property(nonatomic,copy) NSString * request_number;
@property(nonatomic,copy) NSString * request_time;
@property(nonatomic,copy) NSString * category;
@property(nonatomic,copy) NSString * contact;
@property(nonatomic,copy) NSString * contact_phone;
@property(nonatomic,copy) NSString * incident_status;
@property(nonatomic,copy) NSString * describing;
@property(nonatomic,copy) NSString * start_time;
@property(nonatomic,copy) NSString * end_time;
@property(nonatomic,copy) NSString * fee;
@property(nonatomic,copy) NSString * repair_fee;
@property(nonatomic,copy) NSString * material_fee;
@property(nonatomic,copy) NSString * total_fee;
@property(nonatomic,copy) NSString * repairpic_path;
@property(nonatomic,copy) NSString * repairpicend_path;
@property(nonatomic,copy) NSString * node_name;
@property(nonatomic,copy) NSString * handing_suggestion;
@property(nonatomic,copy) NSString * note;

@end



@interface ZjIncidentRequestsShowRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjIncidentRequestsShowModel * result;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_incident_requests_show : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *request_number;



@end
