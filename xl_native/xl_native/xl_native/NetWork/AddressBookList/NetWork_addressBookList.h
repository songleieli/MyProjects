//
//  NetWork_addressBookList.h
//  xl_native
//
//  Created by MAC on 2018/10/10.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//


@interface AaddressBookModel : IObjcJsonBase

@property (copy, nonatomic) NSString *communityName; 
@property (copy, nonatomic) NSString *communityId;
@property (assign, nonatomic) NSInteger everEntryStatus; ///< 该联系人是否登录过平台 1代表：登录过。2代表：没登录过 1：不显示邀请 0：显示邀请
@property (copy, nonatomic) NSString *societyNickName;
@property (copy, nonatomic) NSString *societyUserIcon;
@property (copy, nonatomic) NSString *societyUserId;
@property (copy, nonatomic) NSString *societyUserName;

@end

@interface AddressBookRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSArray * data;

@end

@interface NetWork_addressBookList : WCServiceBase

@property (copy, nonatomic) NSNumber *page;
@property (copy, nonatomic) NSNumber *pageSize;
@property (copy, nonatomic) NSString *token;

@end


