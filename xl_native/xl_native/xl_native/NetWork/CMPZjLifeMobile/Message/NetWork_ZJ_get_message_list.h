//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZjGetMessageListModel : IObjcJsonBase


@property(nonatomic,strong) NSNumber * id;
@property(nonatomic,copy) NSString * createTime;
@property(nonatomic,copy) NSString * updateTime;
@property(nonatomic,copy) NSString * content;
@property(nonatomic,copy) NSString * contentExt;
@property(nonatomic,copy) NSString * type;
@property(nonatomic,copy) NSString * readFlag;
@property(nonatomic,copy) NSString * readDate;
@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * nativeCreateTime;
@property(nonatomic,strong) NSNumber * times;


@end


@interface ZjGetMessageListTempModel : IObjcJsonBase

@property(nonatomic,strong) NSArray * notifyList;
@property(nonatomic,copy) NSString * noReadCount;


@end

@interface ZjGetMessageListRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status;
@property(nonatomic,strong) ZjGetMessageListTempModel * data;
@property(nonatomic,copy) NSString *message;


@end

@interface NetWork_ZJ_get_message_list : WCServiceBase_Zjsh


@property(nonatomic,copy) NSString *token;
@property(nonatomic,copy) NSString *communityId;
@property(nonatomic,copy) NSNumber *page;
@property(nonatomic,copy) NSNumber *pageSize;
@property(nonatomic,copy) NSString *type;


@end
