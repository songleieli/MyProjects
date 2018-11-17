//
//  SRFootView.m
//  SlimeRefresh
//
//  Created by zhaoweibing on 14-4-23.
//  Copyright (c) 2014年 zrz. All rights reserved.
//

#import "SRFootView.h"

@implementation SRFootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.backgroundColor = [UIColor clearColor];
        _activityView.color = [UIColor colorWithRed:128/225.0 green:128/225.0 blue:128/225.0 alpha:1];
        //_activityView.hidesWhenStopped = YES;
//        _activityView.frame = CGRectMake(110+frame.size.width/2-320/2, 20, 0, 0);
        _activityView.frame = CGRectMake(110+frame.size.width/2-320/2 + 50, 20, 0, 0);

        [self addSubview:_activityView];
        [_activityView startAnimating];
        
        self.labelFootState = [[UILabel alloc] initWithFrame:CGRectMake(130+frame.size.width/2-320/2, 10, 200, 21)];
        _labelFootState.backgroundColor = [UIColor clearColor];
        _labelFootState.textColor = [UIColor colorWithRed:128/225.0 green:128/225.0 blue:128/225.0 alpha:1];
        _labelFootState.font = [UIFont defaultFontWithSize:13];
//        _labelFootState.text = @"加载中...";
        _labelFootState.text = @"";

        [self addSubview:_labelFootState];
        
    }
    return self;
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
