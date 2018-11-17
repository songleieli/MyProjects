//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_categories.h"

@implementation ZjCategoriesModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"children" : @"children"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"children" : @"ZjCategoriesModel"};
}

@end

@implementation ZjCategoriesTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"children" : @"children"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"children" : @"ZjCategoriesModel"};
}

@end


@implementation ZjCategoriesRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjCategoriesTempModel"};
}

@end

@implementation NetWork_ZJ_categories

/*
 *如果需要缓存的话，需要给缓存的字段赋值
 */
-(id)init{
    self = [super init];
    if(self){
        self.cache_saveCacheModel = SaveCacheModelAll; //整个返回json的模式。默认不缓存
    }
    return self;
}

-(Class)responseType{
    return [ZjCategoriesRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/incident_requests/categories";
}

@end
