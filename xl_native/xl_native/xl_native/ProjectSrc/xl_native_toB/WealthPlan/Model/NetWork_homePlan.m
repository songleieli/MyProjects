//
//  NetWork_homePlan.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/24.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "NetWork_homePlan.h"

@implementation HomePlanModel

@end

@implementation HomePlanRespone

@end

@implementation NetWork_homePlan

-(Class)responseType{
    return [HomePlanRespone class];
}
-(NSString*)responseCategory{
    if (self.type == 1) {
        return @"/mgt/user/villager/wealth/queryWealthPlantList";
    } else if (self.type == 2) {
        return @"/mgt/user/villager/wealth/queryWealthAnimalList";
    } else if (self.type == 3) {
        return @"/mgt/user/villager/wealth/queryWealthWorkList";
    }
    
    return @"";
}

@end
