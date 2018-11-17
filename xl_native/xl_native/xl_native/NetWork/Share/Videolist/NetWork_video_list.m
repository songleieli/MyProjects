//
//  NetWork_findList.m
//  CMPLjhMobile
//
//  Created by sl on 16/5/24.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_video_list.h"


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

@implementation VideoListModelTemp

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"list" : @"list"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"list" : @"ListLoginModel"};
}

@end

@implementation VideoListRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"data" : @"data"};
//}

- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"VideoListModelTemp"};
}

@end




@implementation NetWork_video_list



-(Class)responseType{
    return [VideoListRespone class];
}

-(NSString*)responseCategory{
    return @"/user/st/neighborhood/video/list";
}

@end
