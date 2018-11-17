//
//  NetWork_myWelfareTicket.h
//  xl_native
//
//  Created by MAC on 2018/10/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyWelfareTicketModel : IObjcJsonBase



/*
 "objectVersionNumber": null,
 "id": 1,
 "exchangeCode": "jfdh20181102",
 "title": "全网通手机10元充值卡",
 "content": "全网通手机10元充值卡",
 "amount": null,
 "scores": null,
 "voucherType": "3",
 "goodCode": null,
 "image": null,
 "barCode": "{\"voucherReceiveId\":\"MTQ4LE1vbiBOb3YgMTIgMTc6MDU6MjIgQ1NUIDIwMTg=\"}",
 "status": "0",
 "limitDate": "2018-11-15 16:16:45",
 "voucher_ReceiveId": 148,
 "isused": 3,
 "describes": "会员积分",
 "validDays": 7,
 "count": null,
 "cycle": "2",
 "cycleDesc": "不限次",
 "useDesc": "淘宝充值 即时到账",
 "usePlat": "我爱我乡app",
 "startDate": "2018-11-01 11:11:11",
 "useLimit": "新用户领取",
 "useWay": "积分兑换",
 "coverTitle": "积分兑换券",
 "coverDesc": "积分兑换券",
 "twoBarCodesJson": null,
 "stocks": "999999",
 "equalsPrice": "1",
 "units": "积分"
 */





@property (copy, nonatomic) NSString *voucherReceiveId;
@property (copy, nonatomic) NSString *amount;
@property (copy, nonatomic) NSString *barCode;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *count;
@property (copy, nonatomic) NSString *cycleDesc;
@property (copy, nonatomic) NSString *exchangeCode;
@property (copy, nonatomic) NSString *goodCode;
@property (assign, nonatomic) NSInteger id;
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *limitDate;
@property (copy, nonatomic) NSString *startDate;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *useDesc;
@property (copy, nonatomic) NSString *useLimit;
@property (copy, nonatomic) NSString *usePlat;
@property (copy, nonatomic) NSString *useWay;
@property (copy, nonatomic) NSString *describes;
@property (copy, nonatomic) NSString *equalsPrice; //等额价值
@property (copy, nonatomic) NSString *voucherType;
@property (strong, nonatomic) NSNumber *voucher_ReceiveId;
@property (copy, nonatomic) NSString *isused; ///< 0使用过，1未使用过，2过期

@end

@interface MyWelfareTicketRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSArray * data;

@end

@interface NetWork_myWelfareTicket : WCServiceBase

@property (copy, nonatomic) NSString *voucherReceiveId;
@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *isused; ///< 0使用过，1未使用过，2过期

@end

NS_ASSUME_NONNULL_END
