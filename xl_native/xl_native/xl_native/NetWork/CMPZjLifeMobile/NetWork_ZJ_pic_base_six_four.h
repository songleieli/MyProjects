//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZjPicBases64Respone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,strong) NSString * repairpic_path;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_pic_base_six_four : WCServiceBase_Zjsh


@property(nonatomic,copy) NSString *repairpic_path;



@end
