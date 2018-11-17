//
//  ScrollRefreshView.m
//  ZJW
//
//  Created by 中酒批 on 15/5/25.
//  Copyright (c) 2015年 oyxc. All rights reserved.
//

#import "SRScrollerRefreshView.h"
#import "SRRefreshView.h"

@interface SRScrollerRefreshView () <SRRefreshDelegate>

@property (nonatomic, strong, readwrite) SRRefreshView *srHeadView;//下拉刷新视图
@property (nonatomic, assign) BOOL isFresh;

@end

@implementation SRScrollerRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.srHeadView = [[SRRefreshView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
        _srHeadView.delegate = self;
        _srHeadView.upInset = 0;
        _srHeadView.slimeMissWhenGoingBack = YES;
        _srHeadView.slime.bodyColor = [UIColor colorWithRed:177/225.0 green:177/225.0 blue:177/225.0 alpha:1];
        _srHeadView.slime.skinColor = [UIColor colorWithRed:153/225.0 green:153/225.0 blue:153/225.0 alpha:1];
        _srHeadView.slime.lineWith = 1;
        _srHeadView.slime.shadowBlur = 4;
        _srHeadView.slime.shadowColor = [UIColor clearColor];
        [self addSubview:_srHeadView];
        
    }
    return self;
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.subviews containsObject:_srHeadView]) {
        [_srHeadView scrollViewDidScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([self.subviews containsObject:_srHeadView]) {
        [_srHeadView scrollViewDidEndDraging];
    }
}

#pragma mark - slimeRefresh delegate
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    if ([self.srdelegate respondsToSelector:@selector(srScrollerViewLoadDataWithRefresh)]) {
        [self.srdelegate srScrollerViewLoadDataWithRefresh];
    } else {
        NSLog(@"下拉刷新代理没有响应");
    }
    
    self.isFresh = YES;
    [self performSelector:@selector(freshFinished) withObject:nil afterDelay:1.0f];
}

- (void)freshFinished
{
    self.isFresh = NO;
    [self.srHeadView endRefresh];
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
