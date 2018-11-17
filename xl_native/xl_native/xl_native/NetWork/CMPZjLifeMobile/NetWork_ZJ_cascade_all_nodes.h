//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 @property(nonatomic,copy) NSString * id;
 @property(nonatomic,copy) NSString * structure_name;
 @property(nonatomic,copy) NSString * property_number;
 @property(nonatomic,copy) NSString * parent_id;
 
 @property(nonatomic,assign) BOOL  isSelected;
 */


@interface ZjCategorieAllModel : IObjcJsonBase

@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *structure_name;
@property(nonatomic,copy) NSString *property_number;
@property(nonatomic,copy) NSArray * child;

@property(nonatomic,copy) NSString * parent_id;
@property(nonatomic,copy) NSArray * parent;

@property(nonatomic,assign) BOOL  isSelected;

@end

@interface ZjCategorieAllNodeTempModel : IObjcJsonBase

//@property(nonatomic,copy) NSString *id;
//@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSArray * cascade_nodes;

@end

@interface ZjCategorieAllNodeRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjCategorieAllNodeTempModel * result;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_cascade_all_nodes : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *project_id;



@end
