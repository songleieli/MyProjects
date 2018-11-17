//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZjDeleteAppMessageRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
//@property(nonatomic,strong) NSArray * result;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_delete_app_message : WCServiceBase_Zjsh


@property(nonatomic,copy) NSString *message_id;


@end
