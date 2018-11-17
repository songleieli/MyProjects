//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 "fee_id": "002y00011Abk93KBiqvilM",
 "fee_name": "服务费",
 "price": "20.0",
 "quantity": 1
 */


@interface ZjGetUntimeFeeTypeModel : IObjcJsonBase

@property(nonatomic,copy) NSString *fee_id;
@property(nonatomic,copy) NSString *fee_name;
@property(nonatomic,copy) NSNumber *price;
@property(nonatomic,strong) NSNumber *quantity;

@end




@interface ZjGetUntimeFeeTypeRespone : IObjcJsonBase

@property(nonatomic,strong) NSArray*result;
@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_pingpp_getUntimeFeeType : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *house_id;


@end
