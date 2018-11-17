//
//  NetWork_deduIntegralfind.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/19.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"


@interface NetWork_deduIntegralfindModel : IObjcJsonBase

@property(nonatomic,copy) NSString * balance;
@property(nonatomic,copy) NSString * freezeAmount;
@property(nonatomic,copy) NSString * usefulBalance;

@end


@interface Integral_queryResponse : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSNumber * totall;
@property(nonatomic,strong) NetWork_deduIntegralfindModel * data;

@end



@interface NetWork_integral_query : WCServiceBase

@property(nonatomic,copy) NSString * month;
@property(nonatomic,copy) NSString * token;

@end
