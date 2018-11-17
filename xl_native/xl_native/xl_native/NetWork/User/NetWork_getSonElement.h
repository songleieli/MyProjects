//
//  Network_allTopicListLogin.h
//  CMPLjhMobile
//
//  Created by sl on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//


@interface SonElementModel : IObjcJsonBase

@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * children;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * type;
@property(nonatomic,copy)NSString * code;

@end






@interface  SonElementRespone : IObjcJsonBase

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSNumber *totall;

@end

@interface NetWork_getSonElement : WCServiceBase

@property(nonatomic,copy) NSString *id;

@end
