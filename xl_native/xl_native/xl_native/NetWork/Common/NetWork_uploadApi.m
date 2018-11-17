//
//  NetWork_upload.m
//  CMPLjhMobile
//
//  Created by sl on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_uploadApi.h"

@implementation UploadModel

@end

@implementation UploadRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"UploadModel"};
}


@end

@implementation NetWork_uploadApi

- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}

-(NSInteger)getTimeOut{
    return 60;
}

-(Class)responseType{
    return [UploadRespone class];
}
-(NSString*)responseCategory{
//    return @"/uploadApi";
    
    return @"/common/file/upload";
    
}

@end
