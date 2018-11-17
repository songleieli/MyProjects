//
//  Network_allTopicListLogin.h
//  CMPLjhMobile
//
//  Created by sl on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Network_hotTopicList.h"


@interface ClassifyVideoListModelTemp : IObjcJsonBase

@property(nonatomic,strong)NSArray * list;

@end



@interface  ClassifyVideoRespone : IObjcJsonBase

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) ClassifyVideoListModelTemp *data;

@end

@interface NetWork_classifyVideo_list : WCServiceBase

@property(nonatomic,copy) NSString *token;
@property(nonatomic,copy) NSString *typeId;   //话题的类型id，不传默认全部类型
@property(nonatomic,strong)NSNumber * pageSize;
@property(nonatomic,strong)NSNumber * pageNo;

@end
