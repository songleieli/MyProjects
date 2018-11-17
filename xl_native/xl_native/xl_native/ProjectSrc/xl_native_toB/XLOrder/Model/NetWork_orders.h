//
//  NetWork_orders.h
//  xl_native_toB
//
//  Created by MAC on 2018/10/25.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrdersRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSObject *data;

@end

@interface NetWork_orders : WCServiceBase

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *token;
@property (assign, nonatomic) NSInteger type; ///< 1：接单  2：关闭订单

@end

NS_ASSUME_NONNULL_END
