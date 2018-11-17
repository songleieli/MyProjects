//
//  BaseCollectionController.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/7/25.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#import "UIScrollView+MJRefresh.h"
#import "MJRefreshGifHeader.h"
#import "MJRefreshAutoGifFooter.h"

#import "BWaterflowLayout.h"



@interface BaseCollectionController : BaseViewController<UICollectionViewDataSource,BWaterflowLayoutDelegate,UICollectionViewDelegate>
//@property (nonatomic, assign) BOOL          isGroup;
@property (nonatomic, strong) UICollectionView   *collectionView;

@property (nonatomic, assign) NSInteger     currentPage;//当前页,默认值是1
@property (nonatomic, assign) NSInteger     totalCount;//总条数

#pragma mark ------------下拉刷新和上拉加载更多，需要OverWrite
- (void)loadMoreData;
- (void)loadNewData;



@end
