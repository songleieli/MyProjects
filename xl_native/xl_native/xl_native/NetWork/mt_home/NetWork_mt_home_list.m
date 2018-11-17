//
//  NetWork_topicPraise.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_mt_home_list.h"


@implementation HomeListModel

@end

@implementation HomeListResponse

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"obj" : @"obj"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"obj" : @"HomeListModel"};
}

@end


@implementation NetWork_mt_home_list

-(Class)responseType{
    return [HomeListResponse class];
}
-(NSString*)responseCategory{
    return @"/miantiao/getVideoLimit";
}


@end
