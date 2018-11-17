//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>




//@interface ZjFindEquipmentByProjectModel : IObjcJsonBase
//
//
//@property(nonatomic,copy) NSString *MD5;
//
//
//@end

@interface ZjFindEquipmentByTempProjectModel : IObjcJsonBase


@property(nonatomic,strong) NSArray * date;


@end



@interface ZjFindEquipmentByProjectRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjFindEquipmentByTempProjectModel * result;
@property(nonatomic,copy) NSString *errmsg;



@end

@interface NetWork_ZJ_find_equipment_by_project : WCServiceBase_Zjsh



@end
