//
//  SRTableView.h
//  SlimeRefresh
//
//  Created by zhaoweibing on 14-4-23.
//  Copyright (c) 2014年 zrz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRRefreshView.h"
#import "SRFootView.h"

@protocol SRTableViewDelegate;

typedef NS_ENUM(NSInteger, SRStates) {
    SRStates_fresh,
    SRStates_loadMore
};


@interface SRTableView : UITableView

@property (nonatomic, strong) SRFootView *srFootView;//加载更多视图
@property (nonatomic, strong) SRRefreshView *srHeadView;//下拉刷新视图

@property (nonatomic, weak) id<SRTableViewDelegate> srdelegate;


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)tableViewStyle;

- (void)reloadDataWithMsg:(NSString *)msg isEnable:(BOOL)enable;
- (void)reloadDataWithMsg:(NSString *)msg isEnable:(BOOL)enable isStart:(BOOL)start;
- (void)CloseFootView;
- (void)CloseheadView;

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end

@protocol SRTableViewDelegate <NSObject>

- (void)SRTableViewLoadDataWithStates:(SRStates)states;

- (void)SRTableViewReshFinished;

@end