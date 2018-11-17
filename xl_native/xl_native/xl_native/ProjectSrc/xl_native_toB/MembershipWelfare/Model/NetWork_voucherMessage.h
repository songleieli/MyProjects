//
//  NetWork_voucherMessage.h
//  xl_native_toB
//
//  Created by MAC on 2018/11/1.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface VoucherMessageModel : IObjcJsonBase

@property (copy, nonatomic) NSString *appUserName;
@property (copy, nonatomic) NSString *communityName;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *count;
@property (copy, nonatomic) NSString *userIcon;

@end

@interface VoucherMessageRespone : IObjcJsonBase

@property(assign,nonatomic) NSInteger status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) VoucherMessageModel * data;

@end

@interface NetWork_voucherMessage : WCServiceBase

@property (copy, nonatomic) NSString *voucher_ReceiveId;
@property (copy, nonatomic) NSString *token;

@end

NS_ASSUME_NONNULL_END
