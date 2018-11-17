//
//  BasePageTableViewController.m
//  ProjectStructure
//
//  Created by zhangfeng on 13-7-9.
//  Copyright (c) 2013年 zhangfeng. All rights reserved.
//

#import "BaseTableMJViewController.h"


@interface BaseTableMJViewController ()

@end

@implementation BaseTableMJViewController

- (void)dealloc{
    self.tableView = nil;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
}
- (UITableView *)tableView
{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-kNavBarHeight_New-kTabBarHeight_New);
        _tableView = [[UITableView alloc]initWithFrame:frame style:(int)_isGroup];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [[UIView alloc] init];
        
        MJRefreshGifHeader *mJefreshGifHeader = [[MJRefreshGifHeader alloc]init];
        [mJefreshGifHeader prepare];
        [mJefreshGifHeader setRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        
        //    self.mj_y = - self.mj_h - self.ignoredScrollViewContentInsetTop;
        
        // 设置普通状态的动画图片Loading0%02lu
        NSMutableArray *idleImages = [NSMutableArray array];
        for (NSUInteger i = 1; i<=16; i++) {
            //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
            //        [idleImages addObject:image];
            //        NSLog(@"%@",[NSString stringWithFormat:@"%ld", i]);
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", i]];
            [idleImages addObject:image];
        }
        [mJefreshGifHeader setImages:idleImages forState:MJRefreshStateIdle];
        
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        NSMutableArray *refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 1; i<=16; i++) {
            //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", i]];
            
            [refreshingImages addObject:image];
        }
        [mJefreshGifHeader setImages:refreshingImages forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        [mJefreshGifHeader setImages:refreshingImages forState:MJRefreshStateRefreshing];
        // 隐藏时间
        mJefreshGifHeader.lastUpdatedTimeLabel.hidden = YES;
        // 隐藏状态
        mJefreshGifHeader.stateLabel.hidden = YES;
        
        
        _tableView.mj_header = mJefreshGifHeader;
        
        // 马上进入刷新状态
        
        //    [self.tableView.mj_header beginRefreshing];
        
        
        MJRefreshAutoGifFooter *footer = [[MJRefreshAutoGifFooter alloc]init];
        [footer prepare];
        [footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        // 设置正在刷新状态的动画图片
        NSMutableArray *refreshingFooterImages = [NSMutableArray array];
        for (NSUInteger i = 1; i<=16; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", i]];
            [refreshingFooterImages addObject:image];
        }
        
        [footer setImages:refreshingFooterImages forState:MJRefreshStateRefreshing];
        footer.refreshingTitleHidden = NO;
        _tableView.mj_footer = footer;
    }
    return _tableView;
}
- (void)loadNewData:(NSString*)str{
    //overwrite me
    NSLog(@"please overwrite loadNewData");
    
    
}
#pragma mark - 下拉刷新和上拉加载更多，需要OverWrite

- (void)loadNewData{
    //overwrite me
    NSLog(@"please overwrite loadNewData");
    
}

- (void)loadMoreData{
    //overwrite me
    
    NSLog(@"please overwrite loadMoreData");
}


#pragma mark - 列表区 (Table view)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

#pragma mark - Table view CellDelegate

- (void)btnClicked:(id)sender cell:(BaseTableViewCell *)cell{
    //overrite me
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
}


#pragma mark no data display

-(void)refreshNoDataViewWithListCount:(NSInteger)listCount{
    //添加空数据页面
    if(listCount == 0){
        [self addImageViewNoData];
    }
    else{
        [self removeImageViewNoData];
    }
}


- (void) addImageViewNoData{
    
    UIView *viewNoData = [self.tableView viewWithTag:99999];
    if(viewNoData == nil){
        viewNoData = [[UIView alloc] init];
        viewNoData.tag = 99999;
        viewNoData.size = [UIView getSize_width:145 height:92 + 30];

        viewNoData.origin = [UIView getPoint_x:(self.tableView.width - viewNoData.width)/2 y:sizeScale(150)];
        [self.tableView addSubview:viewNoData];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.size = [UIView getSize_width:145 height:92];
        imageView.origin = [UIView getPoint_x:0 y:0];
        imageView.image = [UIImage imageNamed:@"tablaview_nodata"];
        [viewNoData addSubview:imageView];
        
        UILabel *labelTitle = [[UILabel alloc]init];
        labelTitle.size = [UIView getSize_width:viewNoData.width height:30];
        labelTitle.origin = [UIView getPoint_x:0 y:imageView.bottom+10];
        labelTitle.textColor = defaultZJGrayColor;
        labelTitle.font = [UIFont defaultFontWithSize:14];
        labelTitle.textAlignment =  NSTextAlignmentCenter;
        labelTitle.text = @"抱歉，暂无内容";
        [viewNoData addSubview:labelTitle];
    }
}

-(void)removeImageViewNoData{
    UIView *viewNoData = [self.tableView viewWithTag:99999];
    if(viewNoData){
        [viewNoData removeAllSubviews];
        [viewNoData removeFromSuperview];
        viewNoData = nil;
    }
}


@end
