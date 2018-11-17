//
//  NetWork_checkUserToken.h
//  CMPLjhMobile
//
//  Created by sl on 16/6/21.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckUserTokenRepsone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSObject * data;

@end

@interface NetWork_checkUserToken : WCServiceBase_Ljh

@property (nonatomic,strong) NSString * token;

@end
