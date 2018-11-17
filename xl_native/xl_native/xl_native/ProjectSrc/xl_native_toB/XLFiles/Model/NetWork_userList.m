//
//  NetWork_userList.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/26.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "NetWork_userList.h"

@implementation UserListModel

@end

@implementation UserListRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"UserListModel"};
}

@end

@implementation NetWork_userList

-(Class)responseType{
    return [UserListRespone class];
}
-(NSString*)responseCategory {

    NSArray *arr = [GlobalData sharedInstance].adminLoginDataModel.communityList;
    
    NSString *communityCode = @"";
    for (int i = 0; i < arr.count; i ++)
    {
        NSDictionary *dict = arr[1];
        
        AdminLoginCommunityListModel *model = [AdminLoginCommunityListModel yy_modelWithDictionary:dict];
        communityCode = [NSString stringWithFormat:@"/user/farm/family/list/%@",model.communityCode];
    }
    return communityCode;
}

@end
