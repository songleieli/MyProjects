//
//  NetWork_findList.m
//  CMPLjhMobile
//
//  Created by sl on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_getSonElement.h"




@implementation SonElementModel


//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"medias" : @"medias"};
//}
//- (NSDictionary *)classNameForItemInArray {
//    return @{@"medias" : @"MediaModel"};
//}



@end

@implementation SonElementRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"SonElementModel"};
}

@end




@implementation NetWork_getSonElement



-(Class)responseType{
    return [SonElementRespone class];
}

-(NSString*)responseCategory{
    return @"/user/villager/getSonElement";
}

@end
