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


@interface ZjCascadeNodesModel : IObjcJsonBase

@property(nonatomic,copy) NSString * id;
@property(nonatomic,copy) NSString * structure_name;
@property(nonatomic,copy) NSString * property_number;
@property(nonatomic,copy) NSString * parent_id;

@property(nonatomic,assign) BOOL  isSelected;

@end

@interface ZjCascadeNodesTempModel : IObjcJsonBase


@property(nonatomic,copy) NSArray * cascade_nodes;

@end

@interface ZjCascadeNodesRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) ZjCascadeNodesTempModel * result;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_cascade_nodes : WCServiceBase_Zjsh


@property(nonatomic,copy) NSString *parent_id;


@end
