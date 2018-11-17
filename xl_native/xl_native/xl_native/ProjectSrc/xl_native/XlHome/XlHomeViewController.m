//
//  FirstFunctionViewController.m
//  unify_platform
//
//  Created by mac on 2018/7/7.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XlHomeViewController.h"

@interface XlHomeViewController ()

@end

@implementation XlHomeViewController

#pragma mark =========== 懒加载 ===========

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

- (MtHomeTopView *)topView{
    if (!_topView) {
        CGRect frame = CGRectMake(0, 0, ScreenWidth, kNavBarHeight_New);
        _topView = [[MtHomeTopView alloc] initWithFrame:frame];
        
        //test
//        _topView.backgroundColor = [UIColor redColor];
    }
    return _topView;
}

- (SwitchPlayerScrollView *)playerScrollView{
    if (!_playerScrollView) {
        _playerScrollView = [[SwitchPlayerScrollView alloc] initWithFrame:self.view.bounds];
        _playerScrollView.playerDelegate = self;
        _playerScrollView.index = self.index;
    }
    return _playerScrollView;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
}

-(void)initNavTitle{
    self.isNavBackGroundHiden = YES;
}

-(void)dealloc{    
    /*dealloc*/
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //先屏蔽，用于在加载首页，添加视频列表
    [self setupUI];
    [self reloadVideo]; //加载当前选择标签数据，如果是点击进来的话，加载的是点击视频所属标签。
}

#pragma -mark ------ CustomMethod ----------

-(void)setupUI{
    
    [self.view addSubview:self.topView];
    
}

-(void)reloadVideo{
    
    if(self.playerView){
        [self.playerView destroyPlayer];
        [self.playerView removeAllSubviews];
        [self.playerView removeFromSuperview];
        self.playerView = nil;
    }
    
    if(self.playerScrollView){
        [self.playerScrollView removeAllSubviews];
        [self.playerScrollView removeFromSuperview];
        self.playerScrollView = nil;
    }
    
    [self.view addSubview:self.playerScrollView];
    
    [self.view bringSubviewToFront:self.topView];
    
    [self loadVedioListData];
}


-(void)loadVedioListData{
    NetWork_mt_home_list *request = [[NetWork_mt_home_list alloc] init];
    request.pageNo = @"1";
    request.pageSize = @"10";
    [request startGetWithBlock:^(HomeListResponse *result, NSString *msg) {
        /*
         缓存暂时先不用考虑
         */
    } finishBlock:^(HomeListResponse *result, NSString *msg, BOOL finished) {
        NSLog(@"----");
        
        [self.dataList addObjectsFromArray:result.obj];
        [self.playerScrollView updateForLives:self.dataList withCurrentIndex:self.index];
        [self addPlayToScrollAndPlay];
    }];
}


-(void)addPlayToScrollAndPlay{
    
    if(self.dataList.count>0){
        
        HomeListModel *listModel = [self.dataList objectAtIndex:0];
        CGRect frame = CGRectMake(0, ScreenHeight, self.view.width, self.view.height);
        self.playerView = [[SwitchPlayerView alloc] initWithFrame:frame listLoginModel:listModel];
        _playerView.url = [NSURL URLWithString:listModel.videoUrl];//视频地址
        [_playerView playVideo];//播放
//        __weak __typeof(self) weakSelf = self;
        [self.playerView setBackBlock:^{
            //[weakSelf back];
        }];
        _playerView.pushUserInfo = ^{
        };
        _playerView.commentClick = ^{
        };
        _playerView.hideCommentClick = ^{
        };
        [self.playerScrollView addSubview:self.playerView];
    }
}

#pragma mark --------- PlayerScrollViewDelegate ----------

- (void)playerScrollView:(SwitchPlayerScrollView *)playerScrollView currentPlayerIndex:(NSInteger)index{
    
    NSLog(@"current index from delegate:%ld  %s",(long)index,__FUNCTION__);
    if (self.index == index) {
        return;
    } else {
        [self reloadPlayerWithLive:self.dataList[index]];
        self.index = index;
    }
}

- (void)reloadPlayerWithLive:(HomeListModel *)listLoginModel{
    
    [self.playerView pausePlay]; //暂停视频
    [self.playerView removeFromSuperview];
    
    
    CGRect frame = CGRectMake(0, ScreenHeight, self.view.width, self.view.height);
    
    
    self.playerView = [[SwitchPlayerView alloc] initWithFrame:frame listLoginModel:listLoginModel];
    if(listLoginModel.videoUrl.length > 0){
        //视频地址
        _playerView.url = [NSURL URLWithString:listLoginModel.videoUrl];
        //播放
        [_playerView playVideo];
    }
//    __weak __typeof(self) weakSelf = self;
    [self.playerView setBackBlock:^{
        //[weakSelf back];
    }];
    
    _playerView.pushUserInfo = ^{
        
//        TopicViewController *vc = [[TopicViewController alloc] init];
//        vc.topicViewControllerType = TopicViewControllerTypeUserInfo;
//        //        vc.userId = listLoginModel.publishId;
//        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    _playerView.commentClick = ^{
//        [weakSelf.view addSubview:weakSelf.commentListView];
//        [weakSelf.view addSubview:weakSelf.commentView];
    };
    _playerView.hideCommentClick = ^{
//        [weakSelf.commentView removeFromSuperview];
//        weakSelf.commentView = nil;
//        [weakSelf.commentListView removeFromSuperview];
//        weakSelf.commentListView = nil;
    };
    [self.playerScrollView addSubview:self.playerView];
}



@end
