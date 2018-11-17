//
//  SRTableView.m
//  SlimeRefresh
//
//  Created by zhaoweibing on 14-4-23.
//  Copyright (c) 2014年 zrz. All rights reserved.
//

#import "SRTableView.h"

@interface SRTableView () <SRRefreshDelegate>

@property (nonatomic, assign) BOOL isForbid;//上拉是否禁止
@property (nonatomic, assign) BOOL isFrensh;//是否正在刷新
@property (nonatomic, assign) BOOL isLoadMore;//是否正在加载更多

@end

@implementation SRTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)tableViewStyle
{
    self = [super initWithFrame:frame style:tableViewStyle];
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
        _srHeadView.backgroundColor = defaultBgColor;
        [self addSubview:_srHeadView];
        
        self.srFootView = [[SRFootView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
        self.tableFooterView = _srFootView;
        
    }
    return self;
}

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isFrensh || _isLoadMore) {
        return ;
    }
    
    if ([self.subviews containsObject:_srHeadView]) {
        [_srHeadView scrollViewDidScroll];
    }
    
    //执行上拉必须满足下面条件 高度超过屏幕、footview要在可视界面区域、不在加载更多状态、还有更多数据、不在刷新状态、offset.y大于0、是否包含加载更多
    CGFloat currentOffSetY = scrollView.contentSize.height-scrollView.frame.size.height-scrollView.contentOffset.y;
    BOOL isHeight = scrollView.contentSize.height > scrollView.frame.size.height;
    BOOL isDistance = currentOffSetY < _srFootView.frame.size.height;
    BOOL isContainFoot = [self.subviews containsObject:_srFootView];
    
    if (isDistance && !_isForbid && scrollView.contentOffset.y > 0 && isHeight && isContainFoot) {
        self.isLoadMore = YES;
        _srFootView.labelFootState.hidden = NO;
        [_srFootView.activityView startAnimating];
        //NSLog(@"来了");
        if ([self.srdelegate respondsToSelector:@selector(SRTableViewLoadDataWithStates:)]) {
            [self.srdelegate SRTableViewLoadDataWithStates:SRStates_loadMore];
        } else {
            NSLog(@"上拉加载更多代理没有响应");
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_srHeadView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    self.isFrensh = YES;
    self.srFootView.hidden = YES;
    if ([self.srdelegate respondsToSelector:@selector(SRTableViewLoadDataWithStates:)]) {
        [self.srdelegate SRTableViewLoadDataWithStates:SRStates_fresh];
    } else {
        NSLog(@"下拉刷新代理没有响应");
    }
}

- (void)reloadDataWithMsg:(NSString *)msg isEnable:(BOOL)enable
{
    self.isForbid = !enable;
    if(self.isForbid){
        NSLog(@"---------------------------------");
    }
    
    _srFootView.labelFootState.text = msg;
    
    [_srFootView.activityView stopAnimating];

//    if (enable) {
//        _srFootView.labelFootState.hidden = YES;
//    }
    
    [self performSelector:@selector(loadMoreFinished) withObject:nil afterDelay:0.01];
    
    if (_isLoadMore == NO) {
        [self.srHeadView endRefresh];
        [self performSelector:@selector(freshFinished) withObject:nil afterDelay:1.5];
        

    }
    
    [self reloadData];
}

- (void)reloadDataWithMsg:(NSString *)msg isEnable:(BOOL)enable isStart:(BOOL)start
{
    self.isLoadMore = !enable;
    _srFootView.labelFootState.text = msg;
    if (start) {
        [_srFootView.activityView startAnimating];
    }
    
    [self reloadData];
}

- (void)freshFinished
{
    self.isFrensh = NO;
    self.srFootView.hidden = NO;
    
    if ([self.srdelegate respondsToSelector:@selector(SRTableViewReshFinished)]) {
        [self.srdelegate SRTableViewReshFinished];
    }
}

- (void)loadMoreFinished
{
    self.isLoadMore = NO;
}

- (void)CloseFootView
{
    if ([self.subviews containsObject:_srFootView]) {
        [_srFootView removeFromSuperview];
    }
}

- (void)CloseheadView
{
    if ([self.subviews containsObject:_srHeadView]) {
        [_srHeadView removeFromSuperview];
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
