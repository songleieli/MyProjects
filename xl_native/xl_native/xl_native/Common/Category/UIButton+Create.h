//
//  UIButton+Create.h
//  Time2Face
//
//  Created by ios on 13-10-28.
//  Copyright (c) 2013年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Create)


//纯图片 类按钮
+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalImage:(NSString *)nomalImage;

+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalImage:(NSString *)nomalImage
                             tag:(NSInteger)tag;

+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalImage:(NSString *)nomalImage
                  highlightImage:(NSString *)highlightImage;

+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalImage:(NSString *)nomalImage
                  highlightImage:(NSString *)highlightImage
                             tag:(NSInteger)tag;

//标题+背景图片 类按钮
+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalTitle:(NSString *)nomalTitle
                    nomalBgImage:(NSString *)nomalBgImage;

+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalTitle:(NSString *)nomalTitle
                    nomalBgImage:(NSString *)nomalBgImage
                             tag:(NSInteger)tag;

+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalTitle:(NSString *)nomalTitle
                  highlightTitle:(NSString *)highlightTitle
                    nomalBgImage:(NSString *)nomalBgImage
                highlightBgImage:(NSString *)highlightBgImage;

+ (UIButton *)createBtnWithFrame:(CGRect)frame
                      nomalTitle:(NSString *)nomalTitle
                  highlightTitle:(NSString *)highlightTitle
                    nomalBgImage:(NSString *)nomalBgImage
                highlightBgImage:(NSString *)highlightBgImage
                             tag:(NSInteger)tag;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
