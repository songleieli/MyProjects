//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_ibeacon_operation.h"


@implementation ZjIbeaconOperationModel


@end


@implementation ZjIbeaconOperationRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"dev_list" : @"dev_list"};
//}

//- (NSDictionary *)classNameForItemInArray {
//    return @{@"dev_list" : @"ZjIbeaconOperationModel"};
//}

@end

@implementation NetWork_ZJ_ibeacon_operation

/*
 *如果需要缓存的话，需要给缓存的字段赋值
 */
-(id)init{
    self = [super init];
    if(self){
        self.cache_saveCacheModel = SaveCacheModelArray; //增量更新缓存模式，默认不缓存
        
        CacheModel *modelOne = [[CacheModel alloc] init];
        modelOne.cache_column = @"result:cacheArray";
        modelOne.cache_primary_key = @"ibeacon_code";
        modelOne.cache_array_model = [[ZjIbeaconOperationModel alloc] init];
        
        [self.arrayCacheModel addObject:modelOne];
        
    }
    return self;
}

-(Class)responseType{
    return [ZjIbeaconOperationRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/intelligent_patrols/ibeacon_operation";
}

@end
