//
//  NetWork_findList.m
//  CMPLjhMobile
//
//  Created by sl on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_followVideo_list.h"


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

@implementation FollowVideoListModelTemp

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"list" : @"list"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"list" : @"ListLoginModel"};
}

@end

@implementation FollowVideoRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"data" : @"data"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"ClassifyVideoListModelTemp"};
}

@end




@implementation NetWork_followVideo_list



-(Class)responseType{
    return [FollowVideoRespone class];
}

-(NSString*)responseCategory{
    return @"/user/st/neighborhood/followVideo/list";
}

@end
