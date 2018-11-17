//
//  NetWork_myFansList.h
//  xl_native
//
//  Created by MAC on 2018/10/15.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface MyFansListModel : IObjcJsonBase

@property (copy, nonatomic) NSString *communityName;
@property (copy, nonatomic) NSString *USER_ICON;
@property (copy, nonatomic) NSString *USER_NAME;
@property (copy, nonatomic) NSString *id;

@end

@interface MyFansListRespone : IObjcJsonBase

//@property (assign, nonatomic) NSInteger totall;
@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSObject * data;

@end

@interface NetWork_myFansList : WCServiceBase

@property (copy, nonatomic) NSNumber *page;
@property (copy, nonatomic) NSNumber *pageSize;
@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *uid;

@end

NS_ASSUME_NONNULL_END
