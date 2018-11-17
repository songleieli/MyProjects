//
//  UITextFeildCustrom.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/6/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "UITextFeildCustrom.h"

@implementation UITextFeildCustrom


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 15;
        self.clipsToBounds = YES;
        self.borderWidth = 1;
        self.borderColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
        self.tintColor = [UIColor grayColor];
//        self.placeholder = @"写评论...";
//        [self  setValue:RGBFromColor(0xaaaaaa) forKeyPath:@"_placeholderLabel.textColor"];
//        [self  setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    }
    return self;
}
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
-(void)textChange:(NSNotification *)notice{
    
    NSLog(@"%@",notice.object);
    
    [self setNeedsDisplay];
}

-(void)setTextViewPlaceholder:(NSString *)textViewPlaceholder{
    
    _textViewPlaceholder = textViewPlaceholder;
    
    [self setNeedsDisplay];
    
}
-(void)setTextViewPlaceholderColer:(UIColor *)textViewPlaceholderColer{
    
    _textViewPlaceholderColer = textViewPlaceholderColer;
    [self setNeedsDisplay];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];//调用这个方法，都会调用dreawRect这个方法
}
//这个方法是setNeedsDisPlay异步调用的
-(void)drawRect:(CGRect)rect{
    if (self.hasText) {
        return;
    }
    NSLog(@"%@",NSStringFromCGRect(rect));
    
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.textViewPlaceholderColer?self.textViewPlaceholderColer:[UIColor grayColor];
    CGFloat x = 5;
    CGFloat w = rect.size.width - 2 *x;
    CGFloat y = 8;
    CGFloat h = rect.size.height - 2* y;
    
    [self.textViewPlaceholder drawInRect:CGRectMake(x, y, w, h) withAttributes:attrs];
    
}


//控制placeHolder的位置
//-(CGRect)placeholderRectForBounds:(CGRect)bounds{
//    
//    CGRect inset = CGRectMake(bounds.origin.x+15, bounds.origin.y, bounds.size.width - 10, bounds.size.height);
//    return inset;
//}
//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );
    CGRect inset = CGRectMake(bounds.origin.x +15, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 50, 0);
    CGRect inset = CGRectMake(bounds.origin.x+15, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    
    return inset;
    
}

@end
