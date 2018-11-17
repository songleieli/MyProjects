//
//  MyImageView.m
//  致青春
//
//  Created by user on 13-7-17.
//  Copyright (c) 2013年 ouyangxiongchun. All rights reserved.
//

#import "MyImageView.h"

@implementation MyImageView
@synthesize imageDelegate;
@synthesize index;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:[UIApplication sharedApplication].keyWindow];
    NSLog(@"point:%@",NSStringFromCGPoint(point));
    
	if ([self.imageDelegate respondsToSelector:@selector(didSelectedWithImage:pointFromWindow:row:)]) {
		[self.imageDelegate didSelectedWithImage:self pointFromWindow:point row:index];
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
