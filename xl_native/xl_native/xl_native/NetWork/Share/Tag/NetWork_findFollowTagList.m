//
//  NetWork_findAllTagList.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/6/3.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_findFollowTagList.h"


@implementation FindFollowTagTagListResponse

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"FindAllTagDataModel"};
}



@end


@implementation NetWork_findFollowTagList
-(Class)responseType{
    return [FindFollowTagTagListResponse class];
}
-(NSString*)responseCategory{
    return @"/user/st/classifytag/video/findFollowTagList";
}


@end
