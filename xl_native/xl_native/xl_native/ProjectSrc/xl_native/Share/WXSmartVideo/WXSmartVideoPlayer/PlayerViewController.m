//
//  MBPlaySmartVideoViewController.m
//  SmartVideo
//
//  Created by yindongbo on 17/1/5.
//  Copyright © 2017年 Nxin. All rights reserved.
//

#import "PlayerViewController.h"



@interface PlayerViewController ()


@end

#define kHEADERVIEW_HEIGHT 44
#define kBOTTOMVIEW_HEIGHT 50
@implementation PlayerViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    
//    [CMPZjLifeMobileAppDelegate shareApp].rootViewController.suspensionBtn.hidden = YES; //隐藏一呼即有按钮

    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [_playerView destroyPlayer];

//    [CMPZjLifeMobileAppDelegate shareApp].rootViewController.suspensionBtn.hidden = NO;//显示一呼即有按钮
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.view.backgroundColor = [UIColor blackColor];
//    //test
//    self.view.backgroundColor = [UIColor redColor];
    
    
    CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _playerView = playerView;
    [self.view addSubview:_playerView];
    
    
    [_playerView updateWithConfig:^(CLPlayerViewConfig *config) {
        //当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器
        config.isLandscape = NO;
        //全屏是否隐藏状态栏，默认一直不隐藏
        config.fullStatusBarHiddenType = FullStatusBarHiddenNever;
        //顶部工具条隐藏样式，默认不隐藏
        config.topToolBarHiddenType = TopToolBarHiddenNever;
        //全屏手势控制，默认Yes
        config.fullGestureControl = NO;
        //小屏手势控制，默认NO
        config.smallGestureControl = NO;
        
        config.videoFillMode = VideoFillModeResizeAspect;
        
    }];
    //视频地址
    _playerView.url = [NSURL URLWithString:self.videoUrlString];
    //播放
    [_playerView playVideo];
    //返回按钮点击事件回调,小屏状态才会调用，全屏默认变为小屏
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
        
        [self back];
    }];
    //播放完成回调
    [_playerView endPlay:^{
        NSLog(@"播放完成");
    }];
    
}



- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}




//#pragma mark - 手势侧滑
//- (void)interfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft|
//        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
//        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//        }
//    }else {
//        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//        }
//    }
//}

#pragma mark -
- (void)dealloc {
    
}

@end
