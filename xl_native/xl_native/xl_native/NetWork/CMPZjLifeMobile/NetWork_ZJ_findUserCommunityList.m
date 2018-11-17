//
//  NetWork_ activityCommentList.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/31.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_findUserCommunityList.h"



//@implementation ZjAdminLoginBaseEmployeeModel
//
//
//@end
//
//@implementation ZjAdminLoginDataListModel
//
//
//@end
//
@implementation ZjFindUserCommunityListModel

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"communityList" : @"communityList"};
//}
//- (NSDictionary *)classNameForItemInArray {
//    return @{@"communityList" : @"ZjAdminLoginDataListModel",@"baseEmployee":@"ZjAdminLoginBaseEmployeeModel"};
//}


@end


@implementation ZjFindUserCommunityListRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"ZjFindUserCommunityListModel"};
}
@end


@implementation NetWork_ZJ_findUserCommunityList

-(Class)responseType{
    return [ZjFindUserCommunityListRespone class];
}

-(NSString*)responseCategory{
    return @"/mgt/user/findUserCommunityList";
}

- (NSString*)responeApiType{
    /*
     overwrite me  appNameProperty：物业APP；appNameOwner：业主APP
     
     调用乐家慧接口需要重写改方法并返回appNameOwner，默认是appNameProperty，调用物管接口
     
     */
    
    return @"appNameOwner";
}

@end
