//
//  Network_allTopicListLogin.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/28.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "Network_hotTopicList.h"

@implementation ImagesLoginModel

@end

@implementation ListLoginModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"medias" : @"medias"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"medias" : @"ImagesLoginModel"};
}


@end

@implementation UserModel

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"medias" : @"medias"};
//}
//- (NSDictionary *)classNameForItemInArray {
//    return @{@"medias" : @"ImagesLoginModel"};
//}


@end

@implementation allTopicListLoginModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"list" : @"list" , @"listUsers" : @"listUsers"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"list" : @"ListLoginModel" , @"listUsers" : @"UserModel"};
}


@end

@implementation allTopicListLoginResponse

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"allTopicListLoginModel"};
}

@end


@implementation Network_hotTopicList
-(Class)responseType{
    
    return [allTopicListLoginResponse class];
}
- (NSString*)responseCategory {
    return @"/user/st/neighborhood/allTopicList";
}

@end
