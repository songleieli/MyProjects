//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZjIncidentRequestsPayPartsModel : IObjcJsonBase

@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * code;

@end

@interface ZjIncidentRequestsPayPartsTempModel : IObjcJsonBase

@property(nonatomic,strong) NSArray *pay_parts;


@end



@interface ZjIncidentRequestsPayPartsRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjIncidentRequestsPayPartsTempModel * result;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_incident_requests_pay_parts : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *request_number;



@end
