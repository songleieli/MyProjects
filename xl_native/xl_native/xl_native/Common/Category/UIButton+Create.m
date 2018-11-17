//
//  UIButton+Create.m
//  Time2Face
//
//  Created by ios on 13-10-28.
//  Copyright (c) 2013年 Ios. All rights reserved.
//

#import "UIButton+Create.h"

@implementation UIButton (Create)

//纯图片类按钮
+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalImage:(NSString *)nomalImage
{
    return [UIButton createBtnWithFrame:frame
                             nomalImage:nomalImage
                                    tag:0];
}

+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalImage:(NSString *)nomalImage
                             tag:(NSInteger)tag
{
    return [UIButton createBtnWithFrame:frame
                             nomalImage:nomalImage
                         highlightImage:nil
                                    tag:tag];
}

+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalImage:(NSString *)nomalImage
                  highlightImage:(NSString *)highlightImage
{
    return [UIButton createBtnWithFrame:frame
                             nomalImage:nomalImage
                         highlightImage:highlightImage
                                    tag:0];
}

+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalImage:(NSString *)nomalImage
                  highlightImage:(NSString *)highlightImage
                             tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:nomalImage] forState:UIControlStateNormal];
    if (highlightImage) {
        [btn setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateSelected];
    }
//    btn.backgroundColor = [UIColor yellowColor];
    return btn;
}

//标题+背景图片 类按钮
+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalTitle:(NSString *)nomalTitle
                    nomalBgImage:(NSString *)nomalBgImage
{
    return [UIButton createBtnWithFrame:frame
                             nomalTitle:nomalTitle
                           nomalBgImage:nomalBgImage
                                    tag:0];
}

+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalTitle:(NSString *)nomalTitle
                    nomalBgImage:(NSString *)nomalBgImage
                             tag:(NSInteger)tag
{
    return [UIButton createBtnWithFrame:frame
                             nomalTitle:nomalTitle
                         highlightTitle:nil
                           nomalBgImage:nomalBgImage
                       highlightBgImage:nil
                                    tag:tag];
}

+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalTitle:(NSString *)nomalTitle
                  highlightTitle:(NSString *)highlightTitle
                    nomalBgImage:(NSString *)nomalBgImage
                highlightBgImage:(NSString *)highlightBgImage
{
    return [UIButton createBtnWithFrame:frame
                             nomalTitle:nomalTitle
                         highlightTitle:highlightTitle
                           nomalBgImage:nomalBgImage
                       highlightBgImage:highlightBgImage
                                    tag:0];
}

+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalTitle:(NSString *)nomalTitle
                  highlightTitle:(NSString *)highlightTitle
                    nomalBgImage:(NSString *)nomalBgImage
                highlightBgImage:(NSString *)highlightBgImage
                             tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.tag = tag;
    btn.titleLabel.font = [UIFont defaultFontWithSize:14];
    [btn setTitle:nomalTitle forState:UIControlStateNormal];
    if (highlightTitle) {
        //[btn setTitle:highlightTitle forState:UIControlStateHighlighted];
        [btn setTitle:highlightTitle forState:UIControlStateSelected];
    }
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:nomalBgImage] forState:UIControlStateNormal];
    if (highlightBgImage) {
        [btn setBackgroundImage:[UIImage imageNamed:highlightBgImage] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:highlightBgImage] forState:UIControlStateSelected];
    }
    
    return btn;
}


- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
