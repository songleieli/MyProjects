//
//  NetWork_MyPublishActivityList.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/13.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

@interface NetWork_MyPublishActivityList : WCServiceBase

@property(nonatomic,strong)NSNumber * pageSize;
@property(nonatomic,strong)NSNumber * pageNo;
@property(nonatomic,strong)NSString * token;

@end
