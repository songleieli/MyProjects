//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_incident_requests_create.h"



@implementation ZjIncidentRequestsCreateModel



@end


@implementation ZjIncidentRequestsCreateTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"patrol_records" : @"result"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjIncidentRequestsCreateModel"};
}

@end


@implementation ZjIncidentRequestsCreateRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjIncidentRequestsCreateTempModel"};
}

@end

@implementation NetWork_ZJ_incident_requests_create

/*
 *如果需要缓存的话，需要给缓存的字段赋值
 */
-(id)init{
    self = [super init];
    if(self){
        self.cache_saveCacheModel = SaveCacheModelArray; //增量更新缓存模式，默认不缓存
        
        CacheModel *modelOne = [[CacheModel alloc] init];
        modelOne.cache_column = @"result:result";
        modelOne.cache_primary_key = @"create_repair_id";
        modelOne.cache_array_model = [[ZjIncidentRequestsCreateModel alloc] init];
        [self.arrayCacheModel addObject:modelOne];

        
        
//        self.cache_column = @"result_result";
//        self.cache_primary_key = @"create_repair_id";
//        self.cache_array_model = [[ZjIncidentRequestsCreateModel alloc] init];
    }
    return self;
}

-(Class)responseType{
    return [ZjIncidentRequestsCreateRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/incident_requests";
}

@end
