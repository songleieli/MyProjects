//
//  NetWork_uploadIcon.h
//  CMPLjhMobile
//
//  Created by sl on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UploadIconRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSArray * data;

@end

@interface NetWork_uploadIcon : WCServiceBase

@property(nonatomic,copy) NSString * token;
@property(nonatomic,copy) NSString * mobile;
@property(nonatomic,copy) NSString * userIcon;

@end
