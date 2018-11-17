//
//  UIFont+Custorm.m
//  君融贷
//
//  Created by admin on 15/11/3.
//  Copyright © 2015年 JRD. All rights reserved.
//

#import "UIFont+Custorm.h"

@implementation UIFont (Custorm)

//自定义默认字体
+ (UIFont *)defaultFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}

+ (UIFont *)defaultBoldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

@end
