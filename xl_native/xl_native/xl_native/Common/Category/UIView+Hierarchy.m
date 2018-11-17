//
//  UIView+Hierarchy.m
//  Ipad4
//
//  Created by 李 彦雷 on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+Hierarchy.h"

@implementation UIView(Hierarchy)

-(NSUInteger)getSubviewIndex
{
    return [self.superview.subviews indexOfObject:self];
}
//将一个View显示在最前面时调用
-(void)bringToFront
{
    [self.superview bringSubviewToFront:self];
}
//将一个View层推送到背后时调用
-(void)sendToBack
{
    [self.superview sendSubviewToBack:self];
}

-(void)bringOneLevelUp
{
    NSUInteger currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex+1];
}

-(void)sendOneLevelDown
{
    NSUInteger currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex-1];
}

-(BOOL)isInFront
{
    return ([self.superview.subviews lastObject]==self);
}

-(BOOL)isAtBack
{
    return ([self.superview.subviews objectAtIndex:0]==self);
}

-(void)swapDepthsWithView:(UIView*)swapView
{
    [self.superview exchangeSubviewAtIndex:[self getSubviewIndex] withSubviewAtIndex:[swapView getSubviewIndex]];
}

@end
