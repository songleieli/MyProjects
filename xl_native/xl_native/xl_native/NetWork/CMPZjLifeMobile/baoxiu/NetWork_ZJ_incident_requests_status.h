//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZjIncidentRequestsStatusRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;

@end

@interface NetWork_ZJ_incident_requests_status : WCServiceBase_Zjsh

/*
 *
 RECEIVE	接单
 REPAIR	维修
 */

@property(nonatomic,copy) NSString *request_number;
@property(nonatomic,copy) NSString *status_action;



@end
