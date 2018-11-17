//
//  NetWork_findList.m
//  CMPLjhMobile
//
//  Created by sl on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_classifyVideo_list.h"


//@implementation MediaModel
//
//
//
//@end
//
//@implementation VideoListModel
//
//
//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"medias" : @"medias"};
//}
//- (NSDictionary *)classNameForItemInArray {
//    return @{@"medias" : @"MediaModel"};
//}



//@end

@implementation ClassifyVideoListModelTemp

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"list" : @"list"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"list" : @"ListLoginModel"};
}

@end

@implementation ClassifyVideoRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"data" : @"data"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"ClassifyVideoListModelTemp"};
}

@end




@implementation NetWork_classifyVideo_list



-(Class)responseType{
    return [ClassifyVideoRespone class];
}

-(NSString*)responseCategory{
    return @"/user/st/neighborhood/classifyVideo/list";
}

@end
