//
//  NetWork_updateUser.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/25.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "WCServiceBase.h"

@interface updateUserRespone : IObjcJsonBase
@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,copy) NSString * data;
@end


@interface NetWork_updateUser : WCServiceBase
@property(nonatomic,copy) NSString * mobile;
@property(nonatomic,copy) NSString * nickName;
@property(nonatomic,copy) NSString * token;
@end
