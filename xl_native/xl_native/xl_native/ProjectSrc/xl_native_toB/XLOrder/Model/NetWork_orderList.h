//
//  NetWork_orderList.h
//  xl_native_toB
//
//  Created by MAC on 2018/10/24.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderListGoodModel : IObjcJsonBase

@property (copy, nonatomic) NSString *goodImage;
@property (copy, nonatomic) NSString *goodName;
@property (copy, nonatomic) NSString *goodSku;
@property (assign, nonatomic) NSInteger price;
@property (copy, nonatomic) NSString *unit;

@end

@interface OrderListModel : IObjcJsonBase

@property (copy, nonatomic) NSString *appUserId;
@property (copy, nonatomic) NSString *communityId;
@property (copy, nonatomic) NSString *communityName;
@property (copy, nonatomic) NSString *creationDate;
@property (copy, nonatomic) NSString *description;
@property (assign, nonatomic) NSInteger discountAmount;
@property (strong, nonatomic) OrderListGoodModel *good;
@property (copy, nonatomic) NSString *goodId;
@property (copy, nonatomic) NSString *goodName;
@property (assign, nonatomic) NSInteger goodNum;
@property (assign, nonatomic) NSInteger id;
@property (assign, nonatomic) NSInteger integralAmount;
@property (copy, nonatomic) NSString *mgtUserId;
@property (copy, nonatomic) NSString *mobile;
@property (assign, nonatomic) NSInteger orderAmount;
@property (copy, nonatomic) NSString *orderNumber;
@property (copy, nonatomic) NSString *orderStatus;
@property (copy, nonatomic) NSString *orderStatusName;
@property (assign, nonatomic) NSInteger payableAmount;
@property (copy, nonatomic) NSString *receiverName;
@property (copy, nonatomic) NSString *timeReceived;
@property (copy, nonatomic) NSString *timeReceivedGood;
@property (copy, nonatomic) NSString *userIcon;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *voiceContent;
@property (copy, nonatomic) NSString *voiceUrl;

@end

@interface OrderListRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSArray *data;
//@property (assign, nonatomic) NSInteger totall;

@end

@interface NetWork_orderList : WCServiceBase

@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *condition;
@property (copy, nonatomic) NSNumber *page;
@property (copy, nonatomic) NSNumber *pagesize;

@end

NS_ASSUME_NONNULL_END
