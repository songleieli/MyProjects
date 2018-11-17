//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZjRequestMaterialIndexModel : IObjcJsonBase

@property(nonatomic,copy) NSString * material_name;
@property(nonatomic,copy) NSString * material_number;
@property(nonatomic,copy) NSString * sh_name;
@property(nonatomic,copy) NSString * sh_number;
@property(nonatomic,copy) NSString * spare_part_price;
@property(nonatomic,copy) NSNumber * spare_part_number;
@property(nonatomic,copy) NSString * total_count;


@end


@interface ZjRequestMaterialIndexTempModel : IObjcJsonBase

@property(nonatomic,copy) NSArray * request_materials;


@end



@interface ZjRequestMaterialIndexRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjRequestMaterialIndexTempModel * result;
@property(nonatomic,copy) NSString *errmsg;

@end

@interface NetWork_ZJ_wm_request_material_index : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *request_number;
@property(nonatomic,copy) NSString *operation_type;



@end
