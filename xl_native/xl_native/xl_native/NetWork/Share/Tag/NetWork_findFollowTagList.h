//
//  NetWork_findAllTagList.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/6/3.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

#import "NetWork_findAllTagList.h"


@interface FindFollowTagTagListResponse : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSArray * data;


@end



@interface NetWork_findFollowTagList : WCServiceBase

@property(nonatomic,copy) NSString * token;

@end
