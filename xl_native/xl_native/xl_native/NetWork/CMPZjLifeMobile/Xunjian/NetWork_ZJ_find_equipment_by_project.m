//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_find_equipment_by_project.h"

//@implementation ZjFindEquipmentByProjectModel
//
//
//@end

@implementation ZjFindEquipmentByTempProjectModel

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"dev_list" : @"dev_list"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"date" : @"ZjFindEquipmentByProjectModel"};
}
@end


@implementation ZjFindEquipmentByProjectRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"dev_list" : @"dev_list"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjFindEquipmentByTempProjectModel"};
}

@end

@implementation NetWork_ZJ_find_equipment_by_project


/*
 *如果需要缓存的话，需要给缓存的字段赋值
 */
-(id)init{
    self = [super init];
    if(self){
        self.cache_saveCacheModel = SaveCacheModelAll; //非增量更新缓存
        
//        CacheModel *modelOne = [[CacheModel alloc] init];
//        modelOne.cache_column = @"result:cacheArray";
//        modelOne.cache_primary_key = @"uuid";
//        modelOne.cache_array_model = [[ZjIbeaconOperationModel alloc] init];
//        
//        [self.arrayCacheModel addObject:modelOne];
        
    }
    return self;
}


-(Class)responseType{
    return [ZjFindEquipmentByProjectRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/intelligent_patrols/find_equipment_by_project";
}

@end
