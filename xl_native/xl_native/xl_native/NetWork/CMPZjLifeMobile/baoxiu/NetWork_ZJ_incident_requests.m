//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_incident_requests.h"


@implementation ZjIncidentRequestsModel


@end


@implementation ZjIncidentRequestsTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"incident_requests" : @"result"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjIncidentRequestsModel"};
}

@end


@implementation ZjIncidentRequestsRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjIncidentRequestsTempModel"};
}

@end

@implementation NetWork_ZJ_incident_requests


/*
 *如果需要缓存的话，需要给缓存的字段赋值
 */
-(id)init{
    self = [super init];
    if(self){
        self.cache_saveCacheModel = SaveCacheModelArray; //增量更新缓存模式，默认不缓存
        
        CacheModel *modelOne = [[CacheModel alloc] init];
        modelOne.cache_column = @"result:result";
        modelOne.cache_primary_key = @"request_number";
        modelOne.cache_array_model = [[ZjIncidentRequestsModel alloc] init];
        [self.arrayCacheModel addObject:modelOne];
        
        
    }
    return self;
}


-(Class)responseType{
    return [ZjIncidentRequestsRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/incident_requests";
}

@end
