//
//  NetWork_membershipWelfare.h
//  xl_native_toB
//
//  Created by MAC on 2018/10/26.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface MembershipWelfareRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;

@end

@interface NetWork_membershipWelfare : WCServiceBase

@property (copy, nonatomic) NSString * image;
@property (copy, nonatomic) NSString * token;
@property (copy, nonatomic) NSString * voucher_ReceiveId;

@end

NS_ASSUME_NONNULL_END
