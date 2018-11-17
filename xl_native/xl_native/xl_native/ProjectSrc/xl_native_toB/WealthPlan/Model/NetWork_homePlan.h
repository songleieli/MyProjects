//
//  NetWork_homePlan.h
//  xl_native_toB
//
//  Created by MAC on 2018/10/24.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomePlanModel : IObjcJsonBase

@property (copy, nonatomic) NSString *classify;
@property (copy, nonatomic) NSString *date;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *item;
@property (copy, nonatomic) NSString *name;

@end

@interface HomePlanRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSDictionary *data;
@property (assign, nonatomic) NSInteger totall;

@end

@interface NetWork_homePlan : WCServiceBase

@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *keywords;
@property (copy, nonatomic) NSNumber *page;
@property (copy, nonatomic) NSNumber *pagesize;
@property (assign, nonatomic) NSInteger type; ///< 1：种植计划 2：养殖计划 3：创业计划

@end

NS_ASSUME_NONNULL_END
