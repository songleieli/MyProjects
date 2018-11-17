//
//  NetWork_ deleteTopic.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NetWork_neighborhood_view.h"

@implementation NeighborhoodViewResponse


@end

@implementation NetWork_neighborhood_view

-(Class)responseType{
    return [NeighborhoodViewResponse class];
}

-(NSString*)responseCategory{
    return @"/user/st/neighborhood/view";
}

@end
