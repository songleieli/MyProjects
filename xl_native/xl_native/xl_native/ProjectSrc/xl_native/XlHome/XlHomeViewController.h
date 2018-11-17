//
//  FirstFunctionViewController.h
//  unify_platform
//
//  Created by mac on 2018/7/7.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "ZJCustomTabBarLjhTableViewController.h"
#import "SwitchPlayerViewController.h"
#import "SwitchPlayerView.h"

#import "NetWork_mt_home_list.h"


@interface XlHomeViewController : ZJCustomTabBarLjhTableViewController<SamPlayerScrollViewDelegate>


@property (nonatomic,strong) SwitchPlayerView *playerView;

//滚动条
@property(nonatomic, strong) SwitchPlayerScrollView * playerScrollView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, assign) NSInteger index;

@end
