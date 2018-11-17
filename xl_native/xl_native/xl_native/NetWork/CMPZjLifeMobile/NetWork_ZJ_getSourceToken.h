//
//  NetWork_ activityCommentList.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//


#import "WCServiceBase_Zjsh.h"


@interface ZjSourceTokenModel : IObjcJsonBase

@property(nonatomic,strong) NSString * sourceToken;

@end

@interface ZjGetSourceTokenRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) ZjSourceTokenModel * data;

@end

@interface NetWork_ZJ_getSourceToken : WCServiceBase_Zjsh

@property(nonatomic,copy) NSString *communityId;
@property(nonatomic,copy) NSString *token;

@end
