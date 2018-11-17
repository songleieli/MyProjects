//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

@interface ZjTemporaryPasswordModel : IObjcJsonBase

@property(nonatomic,copy) NSString * pwd;
@property(nonatomic,copy) NSString * sn;
@property(nonatomic,copy) NSString * name;


@end

@interface ZjTemporaryPasswordRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,copy) NSString *status;

@property(nonatomic,strong) NSArray * dev_list;




@end

@interface NetWork_ZJ_temporary_password : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *mobile;
@property(nonatomic,copy) NSString *rec_mobile;
@property(nonatomic,copy) NSString *sn_list;
@property(nonatomic,copy) NSString *project_id;




@end
