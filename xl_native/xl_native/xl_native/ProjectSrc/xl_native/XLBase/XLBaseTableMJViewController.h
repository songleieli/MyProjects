//
//  BasePageTableViewController.h
//  ProjectStructure
//
//  Created by zhangfeng on 13-7-9.
//  Copyright (c) 2013年 zhangfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#import "UIScrollView+MJRefresh.h"
#import "MJRefreshGifHeader.h"
#import "MJRefreshAutoGifFooter.h"

#import "BaseTableViewCell.h"

@interface XLBaseTableMJViewController : ZJBaseViewController<UITableViewDataSource,UITableViewDelegate,CellDelegate>

@property (nonatomic, assign) BOOL          isGroup;
@property (nonatomic, strong) UITableView   *tableView;

@property (nonatomic, assign) NSInteger     currentPage;//当前页,默认值是1
@property (nonatomic, assign) NSInteger     totalCount;//总条数

#pragma mark ------------下拉刷新和上拉加载更多，需要OverWrite ------

- (void)loadMoreData;
- (void)loadNewData;

- (void)loadNewData:(NSString*)str;

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

-(void)refreshNoDataViewWithListCount:(NSInteger)listCount;

@end
