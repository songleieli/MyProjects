//
//  NetWork_myWelfareTicket.h
//  xl_native
//
//  Created by MAC on 2018/10/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "NetWork_myWelfareTicket.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConsumeRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSArray * data;

@end

@interface NetWork_consume_list : WCServiceBase

@property (copy, nonatomic) NSString *voucherReceiveId;
@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *isused; ///< 0使用过，1未使用过，2过期

@end

NS_ASSUME_NONNULL_END
