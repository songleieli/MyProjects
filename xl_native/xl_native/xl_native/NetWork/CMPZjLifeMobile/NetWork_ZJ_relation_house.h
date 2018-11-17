//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//



//@interface RelationHouseModel : IObjcJsonBase
//
//@property(nonatomic,copy) NSString * material_name;
//
//@end

@interface ZjRelationHouseRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) NSArray * data;
@property(nonatomic,copy) NSString *errmsg;

@end

@interface NetWork_ZJ_relation_house : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *open_id;
@property(nonatomic,copy) NSString *person_mobile;


@end
