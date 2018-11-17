//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_meter_enter_log_update.h"


//@implementation ZjMeterEnterLogCacheUpdateModel
//
//
//@end

@implementation ZjMeterEnterLogUpdateRespone


- (NSDictionary *)propertyMappingObjcJson {
    return @{@"cacheArray" : @"cacheArray"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"cacheArray" : @"ZjMeterEnterLogCacheModel"};
}


@end

@implementation NetWork_ZJ_meter_enter_log_update


/*
 *如果需要缓存的话，需要给缓存的字段赋值
 */
-(id)init{
    self = [super init];
    if(self){
        self.cache_saveCacheModel = SaveCacheModelArray; //增量更新缓存模式，默认不缓存
        
        CacheModel *modelOne = [[CacheModel alloc] init];
        modelOne.cache_column = @"cacheArray";
        modelOne.cache_primary_key = @"equipment_number";
        modelOne.cache_array_model = [[ZjMeterEnterLogCacheModel alloc] init];
        
        [self.arrayCacheModel addObject:modelOne];
    }
    return self;
}


-(Class)responseType{
    return [ZjMeterEnterLogUpdateRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/umeter_enter_logs/meter_enter_log_update";
}

@end
