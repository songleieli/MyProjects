//
//  NetWork_checkUserToken.h
//  xl_native
//
//  Created by MAC on 2018/10/18.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface CheckUserTokenRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSObject *data;

@end

@interface NetWork_checkUserToken : WCServiceBase

@property (copy, nonatomic) NSString *token;

@end

NS_ASSUME_NONNULL_END
