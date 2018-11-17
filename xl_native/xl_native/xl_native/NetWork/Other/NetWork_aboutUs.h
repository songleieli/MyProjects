//
//  NetWork_aboutUs.h
//  xl_native
//
//  Created by MAC on 2018/10/11.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface AboutUsModel : IObjcJsonBase

@property (copy, nonatomic) NSString *content;

@end

@interface AboutUsRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSObject * data;

@end

@interface NetWork_aboutUs : WCServiceBase

@property (copy, nonatomic) NSString *contentType;

@end

NS_ASSUME_NONNULL_END
