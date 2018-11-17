//
//  NetWork_ activityCommentList.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase_Zjsh.h"


@interface ZjAdminLoginBaseEmployeeModel : IObjcJsonBase

@property(nonatomic,copy) NSString * idcard;
@property(nonatomic,copy) NSString * age;
@property(nonatomic,copy) NSString * birthTime;
@property(nonatomic,copy) NSString * post;
@property(nonatomic,copy) NSString * employeeType;

@end



@interface ZjAdminLoginDataListModel : IObjcJsonBase

@property(nonatomic,copy) NSString * id;
@property(nonatomic,copy) NSString * communityname;
@property(nonatomic,copy) NSString * companyid;
@property(nonatomic,copy) NSString * officeName;
@property(nonatomic,copy) NSString * sourceSystem;
@property(nonatomic,copy) NSString * sourceSystemId;
@property(nonatomic,copy) NSString * serverUrl;


@end

@interface ZjAdminLoginDataModel : IObjcJsonBase

@property(nonatomic,strong) NSString * id;
@property(nonatomic,copy) NSString * createTime;
@property(nonatomic,copy) NSString * token;
@property(nonatomic,strong) NSString * communityGroup;
@property(nonatomic,strong) NSString * loginName;
@property(nonatomic,strong) NSString * no;
@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString * email;
@property(nonatomic,strong) NSString * phone;
@property(nonatomic,strong) NSString * mobile;
@property(nonatomic,strong) NSString * photo;
@property(nonatomic,strong) NSString * companyId;
@property(nonatomic,strong) NSString * sourceSystem;
@property(nonatomic,strong) NSString * sourceSystemId;
@property(nonatomic,strong) NSString * roleNames;

@property(nonatomic,strong) ZjAdminLoginBaseEmployeeModel * baseEmployee;
@property(nonatomic,strong) NSArray *  communityList;

@end

@interface ZjAdminLoginRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,copy) NSString * totall;

@property(nonatomic,strong) ZjAdminLoginDataModel * data;

@end

@interface NetWork_ZJ_adminLogin : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *mobile;
@property(nonatomic,copy) NSString *password;

@end
