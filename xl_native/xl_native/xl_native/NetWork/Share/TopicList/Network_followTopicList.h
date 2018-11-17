//
//  NetWork_allTopicList.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "Network_hotTopicList.h"


@interface Network_followTopicList : WCServiceBase

@property(nonatomic,strong)NSNumber * longitude;
@property(nonatomic,strong)NSNumber * latitude;

@property(nonatomic,strong)NSNumber * pageSize;
@property(nonatomic,strong)NSNumber * pageNo;
@property(nonatomic,strong)NSString * token;

@end
