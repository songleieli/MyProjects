//
//  NetWork_userList.h
//  xl_native_toB
//
//  Created by MAC on 2018/10/26.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserListModel : IObjcJsonBase

@property (copy, nonatomic) NSString *communityName;
@property (assign, nonatomic) NSInteger familyId;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *masterGender;
@property (copy, nonatomic) NSString *masterName;

@end

@interface UserListRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * code;
@property(nonatomic,copy) NSString * msg;
@property(nonatomic,strong) NSArray *data;

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;

@end

@interface NetWork_userList : WCServiceBase

@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *condition;
@property (copy, nonatomic) NSNumber *page;
@property (copy, nonatomic) NSNumber *pagesize;

@end

NS_ASSUME_NONNULL_END
