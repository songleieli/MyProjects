//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//



@interface ZjNotifyRecordsDeleteRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status;
@property(nonatomic,copy) NSString *message;


@end

@interface NetWork_ZJ_notifyRecords_delete : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *token;
@property(nonatomic,copy) NSString *id;

@end
