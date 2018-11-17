//
//  NetWork_plantingPlan.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/25.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "NetWork_plantingPlan.h"

@implementation PlantingPlanCostModel

@end
@implementation PlantingPlanCplanModel

@end
@implementation PlantingPlanMapchartsModel

@end
@implementation PlantingPlanMplanModel

@end
@implementation PlantingPlanPropertyModel

@end


@implementation PlantingPlanModel

@end

@implementation PlantingPlanRespone

- (NSDictionary *)propertyMappingObjcJson {
    return @{@"data" : @"data"};
}
- (NSDictionary *)classNameForItemInArray {
    return @{@"data" : @"PlantingPlanModel"};
}

@end

@implementation NetWork_plantingPlan

-(Class)responseType{
    return [PlantingPlanRespone class];
}
-(NSString*)responseCategory{
    if (self.type == 1) {
        return @"/mgt/user/villager/wealth/queryWPlanDetail";
    } else if (self.type == 2) {
        return @"/mgt/user/villager/wealth/queryWPlanDetail";
    } else if (self.type == 3) {
        return @"/mgt/user/villager/wealth/queryWorkWPlanDetail";
    }
    return @"";
}

@end
