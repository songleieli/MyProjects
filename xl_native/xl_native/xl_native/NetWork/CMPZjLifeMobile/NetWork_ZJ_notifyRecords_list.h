//
//  NetWork_ activityCommentList.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase_Zjsh.h"


@interface ZjNotifyRecordsListTempModel : IObjcJsonBase

@property(nonatomic,copy) NSString * idcard;
@property(nonatomic,copy) NSString * age;
@property(nonatomic,copy) NSString * birthTime;
@property(nonatomic,copy) NSString * post;
@property(nonatomic,copy) NSString * employeeType;

@end



@interface ZjNotifyRecordsListRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) ZjNotifyRecordsListTempModel * data;

@end

@interface NetWork_ZJ_notifyRecords_list : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *mobile;
@property(nonatomic,copy) NSString *pwd;

@end
