//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

@interface ZjPingppUntimePayListDetailModel : IObjcJsonBase

/*
 {
 "result": [
 {
 "house_id": "Y1000010A2-12-1-01",
 "property_name": "联排别墅12幢101",
 "fee_name": "户内消防改造防水费",
 "period": "2017-07",
 "quantity": 1.0,
 "price": "200.0",
 "total_amount": 200.0,
 "discount_amount": 0.0
 */

@property(nonatomic,copy) NSString *house_id;
@property(nonatomic,copy) NSString *property_name;
@property(nonatomic,copy) NSString *fee_name;
@property(nonatomic,copy) NSString *period;
@property(nonatomic,copy) NSNumber *quantity;
@property(nonatomic,copy) NSNumber *price;
@property(nonatomic,copy) NSNumber *total_amount;
@property(nonatomic,copy) NSNumber *discount_amount;

@end



@interface ZjPingppUntimePayListDetailRespone : IObjcJsonBase

@property(nonatomic,strong) NSArray *result;
@property(nonatomic,copy) NSString *status_code;
@property(nonatomic,copy) NSString *errmsg;


@end

@interface NetWork_ZJ_pingpp_untimePayListDetail : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *house_id;

@end
