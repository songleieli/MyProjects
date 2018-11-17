//
//  NetWork_keywordFunctionList.h
//  xl_native
//
//  Created by MAC on 2018/9/26.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

@interface keywordFunctionListRespone : IObjcJsonBase

@property(nonatomic,copy) NSString * status;
@property(nonatomic,copy) NSString * message;
@property(nonatomic,strong) NSObject * data;

@end

@interface NetWork_keywordFunctionList : WCServiceBase

@property(nonatomic,copy) NSString *keyword;

@end

