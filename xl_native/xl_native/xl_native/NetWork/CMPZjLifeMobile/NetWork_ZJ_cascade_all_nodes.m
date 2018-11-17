//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_cascade_all_nodes.h"

@implementation ZjCategorieAllModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"child" : @"child"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"child" : @"ZjCategorieAllModel"};
}

@end

@implementation ZjCategorieAllNodeTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"cascade_nodes" : @"cascade_nodes"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"cascade_nodes" : @"ZjCategorieAllModel"};
}

@end


@implementation ZjCategorieAllNodeRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjCategorieAllNodeTempModel"};
}

@end

@implementation NetWork_ZJ_cascade_all_nodes


/*
 *如果需要缓存的话，需要给缓存的字段赋值
 */
-(id)init{
    self = [super init];
    if(self){
        self.cache_saveCacheModel = SaveCacheModelAll; //整个返回json的模式。默认不缓存
    }
    return self;
}

-(NSInteger)getTimeOut{
    return 100;
}

-(Class)responseType{
    return [ZjCategorieAllNodeRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/structures/cascade_all_nodes";
}

@end
