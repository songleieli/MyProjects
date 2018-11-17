//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_get_umeter_by_node.h"


@implementation ZjLastReadModel


@end


@implementation ZjGetUmeterByNodeModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"last_read" : @"last_read"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"last_read" : @"ZjLastReadModel"};
}

@end


@implementation ZjGetUmeterByNodeRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"result" : @"result"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjGetUmeterByNodeModel"};
}

@end

@implementation NetWork_ZJ_get_umeter_by_node

/*
 *如果需要缓存的话，需要给缓存的字段赋值
 */
-(id)init{
    self = [super init];
    if(self){
        self.cache_saveCacheModel = SaveCacheModelArray; //增量更新缓存模式，默认不缓存
        
        CacheModel *modelOne = [[CacheModel alloc] init];
        modelOne.cache_column = @"result";
        modelOne.cache_primary_key = @"equipment_number";
        modelOne.cache_array_model = [[ZjGetUmeterByNodeModel alloc] init];
        [self.arrayCacheModel addObject:modelOne];
        
        
//        self.cache_column = @"result";
//        self.cache_primary_key = @"equipment_number";
//        self.cache_array_model = [[ZjGetUmeterByNodeModel alloc] init];
    }
    return self;
}

-(Class)responseType{
    return [ZjGetUmeterByNodeRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/umeter_enter_logs/get_umeter_by_node";
}

@end
