//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_code_scan.h"

@implementation ZjCodeScanCacheModel


@end


@implementation ZjCodeScanModel


- (NSDictionary *)propertyMappingObjcJson {
    return @{@"cache_array" : @"cache_array"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"cache_array" : @"ZjCodeScanCacheModel"};
}

@end


@implementation ZjCodeScanRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjCodeScanModel"};
}

@end

@implementation NetWork_ZJ_code_scan

/*
 *如果需要缓存的话，需要给缓存的字段赋值
 */
-(id)init{
    self = [super init];
    if(self){
        self.cache_saveCacheModel = SaveCacheModelArray; //增量更新缓存模式，默认不缓存
        
        CacheModel *modelOne = [[CacheModel alloc] init];
        modelOne.cache_column = @"result:cacheArray";
        modelOne.cache_primary_key = @"primaryKeyTime";
        modelOne.cache_array_model = [[ZjCodeScanCacheModel alloc] init];
        
        [self.arrayCacheModel addObject:modelOne];
        
    }
    return self;
}



-(Class)responseType{
    return [ZjCodeScanRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/patrol_comprehensive/code_scan";
}

@end
