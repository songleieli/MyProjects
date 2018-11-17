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
 "result": {
 "material": [
 {
 "material_name": "水管",
 "material_number": "WL00000004",
 "sh_name": "汤臣1库",
 "sh_number": "TC001",
 "material_price": 22,
 "material_count": 10
 }
 ]
 },
 "status_code": 200
 }
 */


@interface ZjMaterialsSignModel : IObjcJsonBase

@property(nonatomic,copy) NSString * material_name;
@property(nonatomic,copy) NSString * material_number;
@property(nonatomic,copy) NSString * sh_name;
@property(nonatomic,copy) NSString * sh_number;
@property(nonatomic,copy) NSString * material_price;
@property(nonatomic,copy) NSNumber * material_count;

@end


@interface ZjMaterialsSignTempModel : IObjcJsonBase

@property(nonatomic,copy) NSArray * material;


@end



@interface ZjMaterialsSignRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjMaterialsSignTempModel * result;
@property(nonatomic,copy) NSString *errmsg;

@end

@interface NetWork_ZJ_wm_materials_sign : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *request_number;
@property(nonatomic,copy) NSString *sign_form;



@end
