//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZjOpenRecordsModel : IObjcJsonBase

@property(nonatomic,copy) NSString * id;
@property(nonatomic,copy) NSString * organization;
@property(nonatomic,copy) NSString * equipment_significance;
@property(nonatomic,copy) NSString * supplier;
@property(nonatomic,copy) NSString * equipment_model;
@property(nonatomic,copy) NSString * maintenance_type;
@property(nonatomic,copy) NSString * install_date;
@property(nonatomic,copy) NSString * guarantee_date;
@property(nonatomic,copy) NSNumber * durable_year;
@property(nonatomic,copy) NSString * technical_parameter;
@property(nonatomic,copy) NSString * if_yibiao;
@property(nonatomic,copy) NSString * user_id;

@end



@interface ZjOpenRecordsRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjOpenRecordsModel * result;
@property(nonatomic,copy) NSString *errmsg;

@end

@interface NetWork_ZJ_open_records : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *mobile;
@property(nonatomic,copy) NSString *sn;
@property(nonatomic,copy) NSString *result;
@property(nonatomic,copy) NSString *timestamp;


@end
