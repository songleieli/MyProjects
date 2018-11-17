//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZjIbeaconOperationModel : IObjcJsonBase


@property(nonatomic,copy) NSString * ibeacon_code;
@property(nonatomic,copy) NSString * offline_time;
@property(nonatomic,copy) NSString * uuid;

@property(nonatomic,copy) NSString * upload_time;

@end



@interface ZjIbeaconOperationRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *action_executed;

@property(nonatomic,strong) NSArray *cache_array;


@end

@interface NetWork_ZJ_ibeacon_operation : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *ibeacon_code;
@property(nonatomic,copy) NSString *offline_time;


@end
