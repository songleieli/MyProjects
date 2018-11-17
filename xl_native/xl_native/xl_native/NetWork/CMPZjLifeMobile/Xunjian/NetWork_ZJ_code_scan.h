//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

@interface ZjCodeScanCacheModel : IObjcJsonBase

//@property(nonatomic,copy) NSString *MD5;



@property(nonatomic,copy) NSString *primaryKeyTime; //时间带毫秒 作为主键，
;

@property(nonatomic,copy) NSString *code_type;
@property(nonatomic,copy) NSString *code_value;
@property(nonatomic,copy) NSString *code_name;
@property(nonatomic,copy) NSString *if_plan;
@property(nonatomic,copy) NSString *scan_time;


@end


@interface ZjCodeScanModel : IObjcJsonBase


@property(nonatomic,copy) NSString * record_id;
@property(nonatomic,copy) NSString * patrol_point_equipment;
@property(nonatomic,copy) NSString * patrol_type;
@property(nonatomic,copy) NSString * no_man_flag;
@property(nonatomic,copy) NSString * patrol_person;
@property(nonatomic,copy) NSString * patrol_location;
@property(nonatomic,copy) NSString * patrol_location_id;
@property(nonatomic,copy) NSString * equipment_name;
@property(nonatomic,copy) NSString * equipment_num;
@property(nonatomic,copy) NSString * complete_time;
@property(nonatomic,copy) NSString * property_number;
@property(nonatomic,copy) NSString * type_code;
@property(nonatomic,copy) NSString * if_plan;


//缓存扫码记录
@property(nonatomic,copy) NSString *code_type;
@property(nonatomic,copy) NSString *code_value;
@property(nonatomic,strong) NSArray *cache_array;


@end



@interface ZjCodeScanRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjCodeScanModel *result;
@property(nonatomic,copy) NSString *errmsg;

@end

@interface NetWork_ZJ_code_scan : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *code_type;
@property(nonatomic,copy) NSString *code_value;
@property(nonatomic,copy) NSString *if_plan;



@end
