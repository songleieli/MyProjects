//
//  UILabel+Create.m
//  JrLoanMobile
//
//  Created by admin on 15/12/3.
//  Copyright © 2015年 Junrongdai. All rights reserved.
//

#import "UILabel+Create.h"
#import "UIFont+Custorm.h"

@implementation UILabel (Create)


+ (UILabel *)labelWithFrame:(CGRect)frame fontSize:(CGFloat)fontSize fontColor:(UIColor *)color text:(NSString *)text
{
    UILabel *labelComment = [[UILabel alloc] initWithFrame:frame];
    labelComment.backgroundColor = [UIColor clearColor];
    labelComment.text = text;
    labelComment.textColor = color;
    labelComment.font = [UIFont defaultFontWithSize:fontSize];
    
    return labelComment;
}

@end
