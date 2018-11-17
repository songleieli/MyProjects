//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZjPingppSearchRoomModel : IObjcJsonBase

@property(nonatomic,copy) NSString *house_id;
@property(nonatomic,copy) NSString *house_name;
@property(nonatomic,copy) NSString *owner;
@property(nonatomic,copy) NSString *mobile;
@property(nonatomic,copy) NSString *identity_card;
//全选全部选使用
@property(nonatomic,assign) BOOL is_select_checkbox;

@end


@interface ZjPingppSearchRoomTempModel : IObjcJsonBase

@property(nonatomic,strong) NSArray *house_list;

@end



@interface ZjPingppSearchRoomRespone : IObjcJsonBase

@property(nonatomic,strong) ZjPingppSearchRoomTempModel *result;
@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_pingpp_searchRoom : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *keyword;


@end
