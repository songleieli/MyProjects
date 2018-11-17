//
//  NetWork_findAllTagList.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/6/3.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

@interface FindAllTagDataModel: IObjcJsonBase

@property(nonatomic,copy) NSString * id;
@property(nonatomic,copy) NSString * tagName;
@property(nonatomic,copy) NSString * belongModel;
@property(nonatomic,assign) BOOL isSelected; //是否选中

@end



@interface FindAllTagListResponse : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSArray * data;


@end



@interface NetWork_findAllTagList : WCServiceBase


@property(nonatomic,copy) NSString * model;//NEIGHBOR_INTERACTION  互动  NEIGHBOR_ACTIVITY  活动
@property(nonatomic,copy) NSString * communityId;


@end
