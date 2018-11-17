//
//  UIPlaceholderTextView.m
//  CMPLjhMobile
//
//  Created by lei song on 2016/12/28.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "UIPlaceholderTextView.h"

@implementation UIPlaceholderTextView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self awakeFromNib];
        
    }
    
    return self;
    
}

- (void)awakeFromNib

{
    
    [self addObserver];
    
}

//    注册通知

- (void)addObserver

{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    
}

//    移除通知

- (void)dealloc

{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

//    开始编辑

- (void)textDidBeginEditing:(NSNotification *)notification

{
    
    if ([super.text isEqualToString:_placeholder]) {
        
        super.text = @"";
        
        [super setTextColor:[UIColor blackColor]];
        
    }
    
}

//    结束编辑

- (void)textDidEndEditing:(NSNotification *)notification

{
    
    if (0 == super.text.length) {
        
        super.text = _placeholder;
        
        [super setTextColor:[UIColor lightGrayColor]];
       
    }
    
}

//    重写 setPlaceholder 方法

- (void)setPlaceholder:(NSString *)aPlaceholder

{
    
    _placeholder = aPlaceholder;
    
    [self textDidEndEditing:nil];
    
}

//    重写 getText 方法

- (NSString *)text

{
    
    NSString *text = [super text];
    
    if ([text isEqualToString:_placeholder]) {
        
        return @"";
        
    }
    
    return text;
    
}

@end
