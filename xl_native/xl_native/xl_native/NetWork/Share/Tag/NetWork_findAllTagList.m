//
//  NetWork_findAllTagList.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/6/3.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_findAllTagList.h"

@implementation FindAllTagDataModel



@end

@implementation FindAllTagListResponse

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"FindAllTagDataModel"};
}



@end


@implementation NetWork_findAllTagList
-(Class)responseType{
    return [FindAllTagListResponse class];
}
-(NSString*)responseCategory{
    return @"/user/classifytag/findAllTagList";
}


@end
