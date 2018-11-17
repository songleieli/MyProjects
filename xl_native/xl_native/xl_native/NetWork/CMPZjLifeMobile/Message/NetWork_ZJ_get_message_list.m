//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_get_message_list.h"

@implementation ZjGetMessageListModel

@end

@implementation ZjGetMessageListTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"notifyList" : @"notifyList"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"notifyList" : @"ZjGetMessageListModel"};
}

@end


@implementation ZjGetMessageListRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"ZjGetMessageListTempModel"};
}

@end

@implementation NetWork_ZJ_get_message_list

/*
 *如果需要缓存的话，需要给缓存的字段赋值
 */
-(id)init{
    self = [super init];
    if(self){
//        self.cache_saveCacheModel = SaveCacheModelArray; //增量更新缓存模式，默认不缓存
//        self.cache_column = @"data_notifyList";
//        self.cache_primary_key = @"id";
//        self.cache_array_model = [[ZjGetMessageListModel alloc] init];
        
        
        self.cache_saveCacheModel = SaveCacheModelArray; //增量更新缓存模式，默认不缓存
        
        CacheModel *modelOne = [[CacheModel alloc] init];
        modelOne.cache_column = @"data:notifyList";
        modelOne.cache_primary_key = @"id";
        modelOne.cache_array_model = [[ZjGetMessageListModel alloc] init];
        [self.arrayCacheModel addObject:modelOne];

    }
    return self;
}


-(Class)responseType{
    return [ZjGetMessageListRespone class];
}

-(NSString*)responseCategory{
    return @"/mgt/notifyRecords/list";
}

- (NSString*)responeApiType{
    /*
     overwrite me  appNameProperty：物业APP；appNameOwner：业主APP
     
     调用乐家慧接口需要重写改方法并返回appNameOwner，默认是appNameProperty，调用物管接口
     
     */
    
    return @"appNameOwner";
}

@end
