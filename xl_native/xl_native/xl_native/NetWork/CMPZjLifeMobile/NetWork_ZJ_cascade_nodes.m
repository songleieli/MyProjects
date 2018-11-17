//
//  NetWork_ZJ_get_message_list.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/14.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "NetWork_ZJ_cascade_nodes.h"

@implementation ZjCascadeNodesModel

@end

@implementation ZjCascadeNodesTempModel

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"cascade_nodes" : @"cascade_nodes"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"cascade_nodes" : @"ZjCascadeNodesModel"};
}

@end


@implementation ZjCascadeNodesRespone

//- (NSDictionary *)propertyMappingObjcJson {
//    return @{@"result" : @"result"};
//}
- (NSDictionary *)classNameForItemInArray {
    return @{@"result" : @"ZjCascadeNodesTempModel"};
}

@end

@implementation NetWork_ZJ_cascade_nodes


-(Class)responseType{
    return [ZjCascadeNodesRespone class];
}

-(NSString*)responseCategory{
    return @"/api/v1/structures/cascade_nodes";
}

@end
