//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_pms_patrol_records.h"


@implementation ZjPmsPatrolRecordsModel

@end

@implementation ZjPmsPatrolOrderListModel



@end

@implementation ZjPmsPatrolRecordsTempModel


- (NSDictionary *)propertyMappingObjcJson {
    return @{@"patrol_records" : @"patrol_records",@"orders_list" : @"orders_list"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"patrol_records" : @"ZjPmsPatrolRecordsModel",@"orders_list" : @"ZjPmsPatrolOrderListModel"};
}

@end


@implementation ZjPmsPatrolRecordsRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjPmsPatrolRecordsTempModel"};
}

@end

@implementation NetWork_ZJ_pms_patrol_records

/*
 *如果需要缓存的话，需要给缓存的字段赋值
 */
-(id)init{
    self = [super init];
    if(self){
        
        self.cache_saveCacheModel = SaveCacheModelArray; //增量更新缓存模式，默认不缓存
        
        CacheModel *modelOne = [[CacheModel alloc] init];
        modelOne.cache_column = @"result:patrol_records";
        modelOne.cache_primary_key = @"record_id";
        modelOne.cache_array_model = [[ZjPmsPatrolRecordsModel alloc] init];
        [self.arrayCacheModel addObject:modelOne];

        CacheModel *modelTwo = [[CacheModel alloc] init];
        modelTwo.cache_column = @"result:orders_list";
        modelTwo.cache_primary_key = @"order_id";
        modelTwo.cache_array_model = [[ZjPmsPatrolOrderListModel alloc] init];
        
        [self.arrayCacheModel addObject:modelTwo];
        
    }
    return self;
}



-(Class)responseType{
    return [ZjPmsPatrolRecordsRespone class];
}

-(NSString*)responseCategory{
//    return @"/api/v1/intelligent_patrols/pms_patrol_records";
    return @"/api/v1/patrol_comprehensive/pms_patrol_records"; //修改后的巡检接口
}

-(NSString *)get_cache_column{
    return @"123";
}

@end
