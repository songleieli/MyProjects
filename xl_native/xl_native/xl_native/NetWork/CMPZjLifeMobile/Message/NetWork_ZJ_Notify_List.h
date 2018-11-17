//
//  NetWork_ZJ_get_message_list.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "articleId": "16ce584681fc4037a1cdcf8336a386c6",
 "informationNumber": 150788037395151,
 "title": "八成功能是“鸡肋”，物业APP难道只能“一键开门”？",
 "hits": 0,
 "categoryName": "物业端公告",
 "parentCategoryName": "顶级栏目",
 "parentCategoryId": "1",
 "categoryId": "5bc07254b9e849d7b9dcf9a6e0552918",
 "contentType": "MGT_COMMUNITY_NOTICE",
 "contentTypeDesc": "物业端公告",
 "weight": 0,
 "weightDate": "",
 "publishedDate": "2017-10-13"
 */



@interface ZjNotifyListModel : IObjcJsonBase

@property(nonatomic,copy) NSString *articleId;
@property(nonatomic,copy) NSString *informationNumber;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *hits;
@property(nonatomic,copy) NSString *categoryName;
@property(nonatomic,copy) NSString *parentCategoryName;
@property(nonatomic,copy) NSString *parentCategoryId;
@property(nonatomic,copy) NSString *categoryId;
@property(nonatomic,copy) NSString *contentType;
@property(nonatomic,copy) NSString *contentTypeDesc;
@property(nonatomic,copy) NSString *weight;
@property(nonatomic,copy) NSString *weightDate;
@property(nonatomic,copy) NSString *publishedDate;


@end


@interface ZjNotifyListRespone : IObjcJsonBase

@property(nonatomic,copy) NSString *status;
@property(nonatomic,strong) NSArray *data;
@property(nonatomic,copy) NSString *message;


@end

@interface NetWork_ZJ_Notify_List : WCServiceBase_Zjsh


@property(nonatomic,copy) NSString *contentTypeStr;
@property(nonatomic,copy) NSString *communityId;
@property(nonatomic,copy) NSNumber *page;
@property(nonatomic,copy) NSNumber *pageSize;


@end
