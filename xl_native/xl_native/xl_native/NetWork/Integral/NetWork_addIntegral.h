//
//  NetWork_addIntegral.h
//  xl_native
//
//  Created by MAC on 2018/9/21.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

@interface AddIntegralRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSObject * data;

@end

@interface NetWork_addIntegral : WCServiceBase

@property(nonatomic,copy) NSString * code;
@property(nonatomic,copy) NSString * token;

@end
