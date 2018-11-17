//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZjPingppFeeListItemModel : IObjcJsonBase


@property(nonatomic,copy) NSString *fee_type_name;
@property(nonatomic,copy) NSString *fee_id;
@property(nonatomic,strong) NSNumber *total;

@end


@interface ZjPingppFeeTypeListModel : IObjcJsonBase


@property(nonatomic,copy) NSString *fee_id;
@property(nonatomic,copy) NSString *fee_name;
@property(nonatomic,copy) NSString *fee_max_period;
@property(nonatomic,copy) NSString *fee_min_period;

@end

@interface ZjPingppFeeListModel : IObjcJsonBase


@property(nonatomic,copy) NSString *house_id;
@property(nonatomic,copy) NSString *house_name;
@property(nonatomic,strong) NSArray *items;

//获取订单使用
@property(nonatomic,assign) CGFloat cellHeight;
@property(nonatomic,assign) BOOL is_user_feetype;
@property(nonatomic,copy) NSString *remark;
@property(nonatomic,strong) NSNumber *price;
@property(nonatomic,copy) NSString *quantity;
@property(nonatomic,copy) NSString *total_amount;

//添加个人费项后，是否选中使用
@property(nonatomic,assign) BOOL is_select_checkbox;


@end


@interface ZjPingppPeriodPayListTempModel : IObjcJsonBase

@property(nonatomic,strong) NSArray *fee_type_list;
@property(nonatomic,strong) NSArray *fee_lists;
@property(nonatomic,copy) NSString *start_period;
@property(nonatomic,copy) NSString *end_period;

@end



@interface ZjPingppPeriodPayListRoomRespone : IObjcJsonBase

@property(nonatomic,strong) ZjPingppPeriodPayListTempModel *result;
@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_pingpp_periodPayList : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *house_list;
@property(nonatomic,copy) NSString *fee_type_list;
@property(nonatomic,copy) NSString *start_time;
@property(nonatomic,copy) NSString *end_time;


@end
