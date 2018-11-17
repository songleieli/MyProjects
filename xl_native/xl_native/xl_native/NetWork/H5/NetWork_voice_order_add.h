//
//  NetWork_topicPraise.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"


/*
{
    "status": "1",
    "message": "下单成功!",
    "totall": null,
    "data": {
        "creationDate": null,
        "fastdfsImageServer": "http://221.122.75.84/",
        "id": 4,
        "appUserId": "628207eaf28b409590a88774ea3aeabc",
        "orderNumber": "15374453470093465075",
        "orderAmount": 0,
        "discountAmount": 0,
        "integralAmount": 0,
        "payableAmount": 0,
        "paidAmount": null,
        "timeExpire": "2018-09-22 20:09:07",
        "timePaid": null,
        "timeSend": null,
        "timeSettle": null,
        "goodId": null,
        "goodName": null,
        "goodNum": null,
        "clientIp": "43.243.136.70",
        "payStatus": "N",
        "orderStatus": "to_sending",
        "orderType": "other",
        "description": null,
        "voiceUrl": "http://221.122.75.84/G01/M00/00/03/rBqAAVujj2WABQEWAAEeGmhA1ss830.mp3",
        "voiceContent": "五包方便面",
        "good": null,
        "mobile": null,
        "userName": null
    }
}
*/



@interface VoiceOrderResponse : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSObject * data;

@end

@interface NetWork_voice_order_add : WCServiceBase

@property (nonatomic,strong) NSString * token;
@property (nonatomic,strong) NSString * voiceContent;
@property (nonatomic,strong) NSString * voiceUrl;

@end
