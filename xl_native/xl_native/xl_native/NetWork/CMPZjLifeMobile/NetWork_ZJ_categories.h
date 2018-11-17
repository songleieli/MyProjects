//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "result": {
 "cascade_nodes": [
 {
 "id": "002U00014OmdtcIH7jTpxI",
 "structure_name": "汤臣豪庭",
 "property_number": null
 }
 ]
 },
 "status_code": 200
 }
 */


@interface ZjCategoriesModel : IObjcJsonBase

@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSArray * children;


@end

@interface ZjCategoriesTempModel : IObjcJsonBase

@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSArray * children;

@end

@interface ZjCategoriesRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjCategoriesTempModel * result;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_categories : WCServiceBase_Zjsh




@end
