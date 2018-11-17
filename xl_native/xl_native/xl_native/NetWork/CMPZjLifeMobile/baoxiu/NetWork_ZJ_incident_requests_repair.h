//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZjIncidentRequestsRepairModel : IObjcJsonBase

@property(nonatomic,copy) NSString * request_number;


@end



@interface ZjIncidentRequestsRepairRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjIncidentRequestsRepairModel * result;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_incident_requests_repair : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *request_number;
@property(nonatomic,copy) NSString *pay_party;
@property(nonatomic,copy) NSString *settlement;
@property(nonatomic,copy) NSString *repair_reason;
@property(nonatomic,copy) NSString *add_explain;
@property(nonatomic,copy) NSString *repairpicend_path;
@property(nonatomic,copy) NSString *repairpic_path;


@end
