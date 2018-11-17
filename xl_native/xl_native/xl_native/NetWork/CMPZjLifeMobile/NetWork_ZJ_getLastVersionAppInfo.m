//
//  NetWork_ZJ_getLastVersionAppInfo
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/7/13.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_getLastVersionAppInfo.h"

@implementation GetLastVersionAppInfoData



@end

@implementation GetLastVersionAppInfoRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"GetLastVersionAppInfoData"};
}


@end


@implementation NetWork_ZJ_getLastVersionAppInfo

- (ApiType_Cspt)responeApiType{
    return ApiType_Cspt_Hap;
}

-(Class)responseType{
    return [GetLastVersionAppInfoRespone class];
}
-(NSString*)responseCategory{
    return @"/user/appdownload/appDownload/getLastVersionAppInfo";
}

//- (NSString*)responeApiType{
//    /*
//     overwrite me  appNameProperty：物业APP；appNameOwner：业主APP
//     
//     调用乐家慧接口需要重写改方法并返回appNameOwner，默认是appNameProperty，调用物管接口
//     
//     */
//    
//    return ApiType_Cspt_Hap;
//}


@end
