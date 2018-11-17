//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//


@interface ScanDevModel : IObjcJsonBase

@property(nonatomic,copy) NSString * devSn;
@property(nonatomic,copy) NSString * rssi;

@end

@interface BlueDoorTempPassword : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sn;
@property (nonatomic, copy) NSString *pwd;

@end

@interface ZjSearchKeysModel : IObjcJsonBase

@property(nonatomic,copy) NSString * key;
@property(nonatomic,copy) NSString * mac;
@property(nonatomic,copy) NSString * number;
@property(nonatomic,copy) NSString * sn;
@property(nonatomic,copy) NSString * name;

/*
 * Add by songlei use for select checkbox.
 */
@property(nonatomic,assign) BOOL is_select_checkbox;



@end


@interface ZjSearchKeysRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,strong) NSArray * dev_list;

@end

@interface NetWork_ZJ_search_keys : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *mobile;
@property(nonatomic,copy) NSString *house_list;




@end
