//
//  ShowNotice.m
//  中酒批
//
//  Created by zhaoweibing on 14-4-25.
//  Copyright (c) 2014年 Ios. All rights reserved.
//

#import "ShowNotice.h"
#import "UIView+Common.h"

@interface ShowNotice ()

@property (nonatomic, retain) UIView *viewBg;//黑色半透明背景色
@property (nonatomic, retain) UILabel *labelMsg;//提示文本
@property (nonatomic, retain) UIActivityIndicatorView *activityView;//指示器


@end

@implementation ShowNotice

- (id)init{
    return [self initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kNavBarHeight_New)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        //黑色透明背景
        self.viewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 90)];
        _viewBg.backgroundColor = [UIColor blackColor];
        _viewBg.center = CGPointMake(self.width/2, self.height/2);
        _viewBg.layer.masksToBounds = YES;
        _viewBg.layer.cornerRadius = 8;
        _viewBg.alpha = 0.8f;
        [self addSubview:_viewBg];
        
        //指示器
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.backgroundColor = [UIColor clearColor];
        [self addSubview:_activityView];
        _activityView.center = CGPointMake(self.width/2, 30+_viewBg.y);
        
        //文本 提示信息
        self.labelMsg = [[UILabel alloc] initWithFrame:CGRectMake(_viewBg.x, _viewBg.height+_viewBg.y-30, _viewBg.width, 21)];
        _labelMsg.backgroundColor = [UIColor clearColor];
        _labelMsg.textAlignment = NSTextAlignmentCenter;
        _labelMsg.textColor = [UIColor whiteColor];
        _labelMsg.font = [UIFont defaultFontWithSize:14];
        [self addSubview:_labelMsg];
        
    }
    return self;
}

+ (ShowNotice *)showView:(UIView *)view frame:(CGRect)frame msg:(NSString *)msg
{
    ShowNotice *notice = [[ShowNotice alloc] initWithFrame:frame];
//    notice.backgroundColor = [UIColor yellowColor];
    notice.labelMsg.text = msg;
    [notice.activityView startAnimating];
    [view addSubview:notice];
    
    //显示
    notice.alpha = 0;
    __block ShowNotice *weakNotice = notice;
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        weakNotice.alpha = 1;
    } completion:nil];
    
    return notice;
}

- (void)hideNoticeAnimated:(BOOL)animated
{
    if (animated == NO) {
        [self.activityView startAnimating];
        [self removeFromSuperview];
        return ;
    }
    
    __block typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.activityView startAnimating];
        [weakSelf removeFromSuperview];
    }];
}

-(void)setNoticeMsg:(NSString*)msg{
    _labelMsg.text = msg;
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
