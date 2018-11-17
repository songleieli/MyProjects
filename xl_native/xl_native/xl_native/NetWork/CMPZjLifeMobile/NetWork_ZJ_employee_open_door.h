//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 
 
 
 "name": "员工门禁测试1幢2号楼",
 "mac": "CC:21:57:3D:8C:2E",
 "sn": "1463651374",
 "key": "479802c1c17264984174d2bceea1c5cc000000000000000000000000000000001000"

 */


@interface ZjEmployeeOpenDoorModel : IObjcJsonBase

@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * mac;
@property(nonatomic,copy) NSString * sn;
@property(nonatomic,copy) NSString * key;


@end



@interface ZjEmployeeOpenDoorRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) NSArray * dev_list;
@property(nonatomic,copy) NSString *errmsg;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,copy) NSString *status;


@end

@interface NetWork_ZJ_employee_open_door : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *mobile;


@end
