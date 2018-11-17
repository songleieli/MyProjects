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


@interface ZjMaterialsUseListModel : IObjcJsonBase

@property(nonatomic,copy) NSString * material_name;
@property(nonatomic,copy) NSString * material_number;
@property(nonatomic,copy) NSString * material_price;

@property(nonatomic,copy) NSString * sh_name;
@property(nonatomic,copy) NSString * sh_number;

@property(nonatomic,copy) NSNumber * replace_number;
@property(nonatomic,copy) NSNumber * replace_number_total;
@property(nonatomic,copy) NSString * created_at;



/*

"material_number": "WL00000001",
"material_name": "羽毛球拍",
"replace_number": 1,
"material_price": "34.0",
"created_at": "2016-12-19 11:05:53",
"replace_number_total": 4
 
 */

@end


@interface ZjMaterialsUseListTempModel : IObjcJsonBase

@property(nonatomic,copy) NSArray * request_use_list;


@end



@interface ZjMaterialsUseListRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjMaterialsUseListTempModel * result;
@property(nonatomic,copy) NSString *errmsg;

@end

@interface NetWork_ZJ_wm_materials_use_list : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *request_number;



@end
