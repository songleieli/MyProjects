//
//  NetWork_findAllTagList.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/6/3.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

#import "NetWork_queryFollowed.h"

@interface NetWork_queryFollower : WCServiceBase


@property(nonatomic,strong) NSNumber * page;
@property(nonatomic,strong) NSNumber * pageSize;
@property(nonatomic,copy) NSString * token;
@property(nonatomic,copy) NSString * uid;


@end
