//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZjIncidentRequestsCreateModel : IObjcJsonBase

//@property(nonatomic,copy) NSString *MD5;

@property(nonatomic,copy) NSString * create_repair_id;

@property(nonatomic,copy) NSString * property_number;
@property(nonatomic,copy) NSString * property_name;

@property(nonatomic,copy) NSString * category_one;
@property(nonatomic,copy) NSString * category_two;
@property(nonatomic,copy) NSString * category_three;
@property(nonatomic,copy) NSString * category_name;

@property(nonatomic,copy) NSString * contact_person;
@property(nonatomic,copy) NSString * contact_mobile;

@property(nonatomic,copy) NSString * describing;
@property(nonatomic,copy) NSString * appoint_time;
@property(nonatomic,copy) NSString * repairpic_path;

@end


@interface ZjIncidentRequestsCreateTempModel : IObjcJsonBase

@property(nonatomic,strong) NSArray * result;


@end


@interface ZjIncidentRequestsCreateRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjIncidentRequestsCreateTempModel * result;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_incident_requests_create : WCServiceBase_Zjsh


@property(nonatomic,copy) NSString *property_number;
@property(nonatomic,copy) NSString *property_name;
@property(nonatomic,copy) NSString *category_one;
@property(nonatomic,copy) NSString *category_two;
@property(nonatomic,copy) NSString *category_three;
@property(nonatomic,copy) NSString *appoint_time;
@property(nonatomic,copy) NSString *describing;
@property(nonatomic,copy) NSString *repairpic_path;


@end
