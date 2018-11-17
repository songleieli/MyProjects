//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 {

 "id": "006z00044wJPEoinx5Ot6W",    //设备id
 "organization": "人事行政部(嘉)",   //所属部门
 "equipment_significance": "A",     //重要性
 "supplier": "TEST",                //供应商
 "equipment_model": "",            //规格型号
 "maintenance_type": "",           //保养类型
 "install_date": "2016-08-08",     //安装日期
 "guarantee_date": "2016-08-08",   //报修到期日期
 "durable_year": 210,              //使用年限
 "technical_parameter": "测测测测测测恶臭", //设备参数
 "if_yibiao": "N",               //是否是仪表，‘Y’表示是，‘N’表示不是
 "user_id": ""                   //户号，if_yibiao的值为‘Y’时才显示

 */


@interface ZjEquipmentInfoModel : IObjcJsonBase

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



@interface ZjEquipmentInfoRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjEquipmentInfoModel * result;
@property(nonatomic,copy) NSString *errmsg;

@end

@interface NetWork_ZJ_intelligent_patrols_equipment_info : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *equipment_num;


@end
