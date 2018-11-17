//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZjCompleteRecordInputParameterModel : IObjcJsonBase

@property(nonatomic,copy) NSString * record_id;
@property(nonatomic,copy) NSString * complete_time;
@property(nonatomic,copy) NSString * no_man_flag;
@property(nonatomic,copy) NSString * patrol_class;

@end



@interface ZjCompleteRecordModel : IObjcJsonBase

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



@interface ZjCompleteRecordRespone : IObjcJsonBase

@property(nonatomic,strong) NSNumber *status_code;
@property(nonatomic,strong) ZjCompleteRecordModel * result;
@property(nonatomic,copy) NSString *errmsg;

@end

@interface NetWork_ZJ_complete_record : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *records_list;



@end
