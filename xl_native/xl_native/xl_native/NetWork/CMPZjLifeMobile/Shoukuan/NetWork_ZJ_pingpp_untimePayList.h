//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//
#import "NetWork_ZJ_pingpp_periodPayList.h"

//@interface ZjPingppUntimePayItemModel : IObjcJsonBase

/*
 "fee_id": "002y00011AZcGxchcpQl5U",
 "fee_type_name": "材料费",
 "total": 20.0
 */

//@property(nonatomic,copy) NSString *fee_id;
//@property(nonatomic,copy) NSString *fee_type_name;
//@property(nonatomic,copy) NSString *total;
//
//@end
//
//@interface ZjPingppUntimePayListModel : IObjcJsonBase
//
//@property(nonatomic,copy) NSString *house_id;
//@property(nonatomic,copy) NSString *house_name;
//@property(nonatomic,strong) NSArray *items;
//
//@end


@interface ZjPingppUntimePayListTempModel : IObjcJsonBase

@property(nonatomic,strong) NSArray *fee_lists;

@end



@interface ZjPingppUntimePayListRoomRespone : IObjcJsonBase

@property(nonatomic,strong) ZjPingppUntimePayListTempModel *result;
@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_pingpp_untimePayList : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *house_list;


@end
