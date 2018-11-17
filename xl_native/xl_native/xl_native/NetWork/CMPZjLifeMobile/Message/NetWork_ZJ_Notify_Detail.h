//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZjNotifyDetailModel : IObjcJsonBase


@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *publishedDate;


@end


//@interface ZjGetMessageReadTempModel : IObjcJsonBase
//
//@property(nonatomic,copy) NSArray * attachments;
//@property(nonatomic,copy) NSString * id;
//@property(nonatomic,copy) NSString * title;
//@property(nonatomic,copy) NSString * content;
//@property(nonatomic,copy) NSString * type;
//@property(nonatomic,copy) NSString * readFlag;
//@property(nonatomic,copy) NSString * readDate;
//@property(nonatomic,copy) NSString * createTime;
//@property(nonatomic,copy) NSString * updateTime;
//@property(nonatomic,copy) NSString * times;
//
//
//
//@end

@interface ZjNotifyDetailRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status;
@property(nonatomic,strong) ZjNotifyDetailModel * data;
@property(nonatomic,copy) NSString *message;


@end

@interface NetWork_ZJ_Notify_Detail : WCServiceBase_Zjsh


@property(nonatomic,copy) NSString *articleId;

@end
