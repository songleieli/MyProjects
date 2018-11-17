//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_Notify_List.h"

@implementation ZjNotifyListModel

@end


@implementation ZjNotifyListRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"ZjNotifyListModel"};
}

@end

@implementation NetWork_ZJ_Notify_List

/*
 *如果需要缓存的话，需要给缓存的字段赋值
 */
-(id)init{
    self = [super init];
    if(self){
        self.cache_saveCacheModel = SaveCacheModelArray; //增量更新缓存模式，默认不缓存
        
        CacheModel *modelOne = [[CacheModel alloc] init];
        modelOne.cache_column = @"data";
        modelOne.cache_primary_key = @"articleId";
        modelOne.cache_array_model = [[ZjNotifyListModel alloc] init];
        [self.arrayCacheModel addObject:modelOne];

    }
    return self;
}


-(Class)responseType{
    return [ZjNotifyListRespone class];
}

-(NSString*)responseCategory{
    return @"/user/operate/cms/article/mgt/list";
}

- (NSString*)responeApiType{
    /*
     overwrite me  appNameProperty：物业APP；appNameOwner：业主APP
     
     调用乐家慧接口需要重写改方法并返回appNameOwner，默认是appNameProperty，调用物管接口
     
     */
    return @"appNameOwner";
}

@end
