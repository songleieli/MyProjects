//
//  TMVerticallyCenteredTextView.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/4/18.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "TMVerticallyCenteredTextView.h"

@interface TMVerticallyCenteredTextView()
@end
@implementation TMVerticallyCenteredTextView
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.textAlignment = NSTextAlignmentCenter;
        [self addObserver:self forKeyPath:@"contentSize" options:  (NSKeyValueObservingOptionNew) context:NULL];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
        
    }
    return self;
}
- (id)initWithCoder:(NSCoder* )aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.textAlignment = NSTextAlignmentCenter;
        [self addObserver:self forKeyPath:@"contentSize" options:  (NSKeyValueObservingOptionNew) context:NULL];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"])
    {
        UITextView *tv = object;
        CGFloat deadSpace = ([tv bounds].size.height - [tv contentSize].height);
        CGFloat inset = MAX(0, deadSpace/2.0);
        tv.contentInset = UIEdgeInsetsMake(inset, tv.contentInset.left, inset, tv.contentInset.right);
    }
}


- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentSize"];
    
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
