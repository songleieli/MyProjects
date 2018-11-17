//
//  BaseCollectionController.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/7/25.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "BaseCollectionController.h"

@interface BaseCollectionController ()

@end

@implementation BaseCollectionController

static NSString * const reuseIdentifier = @"Cell";

- (void)dealloc{
    self.collectionView = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGRect frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-kNavBarHeight_New-kTabBarHeight_New);
    //创建布局
    BWaterflowLayout * layout = [[BWaterflowLayout alloc]init];
    layout.delegate = self;
    
    //创建CollectionView
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = defaultJawBgColor;
    
//    [self.view addSubview:collectionView];
    //[collectionView registerNib:[UINib nibWithNibName:@"BShopCell" bundle:nil] forCellWithReuseIdentifier:@"shop"];
    self.collectionView = collectionView;
    
    
    
    MJRefreshGifHeader *mJefreshGifHeader = [[MJRefreshGifHeader alloc]init];
    [mJefreshGifHeader prepare];
    [mJefreshGifHeader setRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=16; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];

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
    
    
    
    MJRefreshAutoGifFooter *footer = [[MJRefreshAutoGifFooter alloc]init];
    [footer prepare];
    [footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingFooterImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=16; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", i]];

        [refreshingFooterImages addObject:image];
    }
    
    [footer setImages:refreshingFooterImages forState:MJRefreshStateRefreshing];
    footer.refreshingTitleHidden = YES;
    
    self.collectionView.mj_header = mJefreshGifHeader;
    // 马上进入刷新状态
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer = footer;
    
//    [self.view addSubview:self.collectionViewTemp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
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

#pragma mark - <BWaterflowLayoutDelegate>

-(CGFloat)waterflowLayout:(BWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    return 1;
}
//瀑布流列数
- (CGFloat)columnCountInWaterflowLayout:(BWaterflowLayout *)waterflowLayout {
    return 2;
}
- (CGFloat)columnMarginInWaterflowLayout:(BWaterflowLayout *)waterflowLayout {
    return 10;
    
}
- (CGFloat)rowMarginInWaterflowLayout:(BWaterflowLayout *)waterflowLayout {
    return 10;
}
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(BWaterflowLayout *)waterflowLayout {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


@end
