//
//  NetWork_noticeList.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/18.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_download_qr.h"


@implementation ZjDownloadQrModel


@end

@implementation ZjDownloadQrRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}

- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"ZjDownloadQrModel"};
}
@end

@implementation NetWork_ZJ_download_qr


-(Class)responseType{
    return [ZjDownloadQrRespone class];
}
-(NSString*)responseCategory{
    return @"/common/get/app/download/qr";
}

- (NSString*)responeApiType{
    /*
     overwrite me  appNameProperty：物业APP；appNameOwner：业主APP

     调用乐家慧接口需要重写改方法并返回appNameOwner，默认是appNameProperty，调用物管接口

     */

    return @"appNameOwner";
}


@end
