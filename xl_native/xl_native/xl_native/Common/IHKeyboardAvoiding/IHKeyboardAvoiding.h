//
//  IHKeyboardAvoiding.h
//  lejiahui
//
//  Created by iOS开发 on 16/4/17.
//  Copyright © 2016年 zhongmingwuye. All rights reserved.
//

#import <Foundation/Foundation.h>

enum KeyboardAvoidingMode {
    
    KeyboardAvoidingModeMaximum = 0,
    KeyboardAvoidingModeMinimum = 1,
    KeyboardAvoidingModeMinimumDelayed = 2
    
}
typedef KeyboardAvoidingMode;

@interface IHKeyboardAvoiding : NSObject

+ (void)setKeyboardAvoidingMode:(KeyboardAvoidingMode)keyboardAvoidingMode;

+ (void)setAvoidingView:(UIView *)avoidingView withTarget:(UIView *)targetView;

+ (void)addTarget:(UIView *)targetView;

+ (void)removeTarget:(UIView *)targetView;

+ (void)removeAll;

// utility method to find out if the keyboard is visible. Works for docked, undocked and split keyboards
+ (BOOL)isKeyboardVisible;

// If the visible keyboard plus the buffer intersect with the targetView, then the avoiding View will be moved. Default buffer is 0 points
+ (void)setBuffer:(int)buffer;

// padding to put between the keyboard and avoiding view. Default padding is 0 points
+ (void)setPadding:(int)padding;

@end
