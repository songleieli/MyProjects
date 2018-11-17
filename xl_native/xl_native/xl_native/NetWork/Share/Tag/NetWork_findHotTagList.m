//
//  NetWork_findAllTagList.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/6/3.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_findHotTagList.h"

@implementation FindHotTagListResponse

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"FindAllTagDataModel"};
}

@end


@implementation NetWork_findHotTagList
-(Class)responseType{
    return [FindHotTagListResponse class];
}
-(NSString*)responseCategory{
    return @"/user/st/classifytag/video/findHotTagList";
}

@end
