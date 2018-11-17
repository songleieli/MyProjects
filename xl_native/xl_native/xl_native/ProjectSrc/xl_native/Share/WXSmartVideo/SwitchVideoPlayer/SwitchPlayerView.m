//
//  PlayerView.m
//  CLPlayerDemo
//
//  Created by JmoVxia on 2016/11/1.
//  Copyright © 2016年 JmoVxia. All rights reserved.
//

#import "SwitchPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

// 播放器的几种状态
typedef NS_ENUM(NSInteger, CLPlayerState) {
    CLPlayerStateFailed,     ///< 播放失败
    CLPlayerStateBuffering,  ///< 缓冲中
    CLPlayerStatePlaying,    ///< 播放中
    CLPlayerStateStopped,    ///< 停止播放
};


@interface SwitchPlayerView ()

/** 播发器的几种状态 */
@property (nonatomic, assign) CLPlayerState    state;
/**视频拉伸模式*/
@property (nonatomic, copy) NSString           *fillMode;
/**播放器*/
@property (nonatomic, strong) AVPlayer         *player;
/**playerLayer*/
@property (nonatomic, strong) AVPlayerLayer    *playerLayer;
/**播放器item*/
@property (nonatomic, strong) AVPlayerItem     *playerItem;
/**遮罩*/
@property (nonatomic, strong) SwitchPlayerMaskView *maskView;

@end

@implementation SwitchPlayerView

//MARK:JmoVxia---懒加载
//遮罩
- (SwitchPlayerMaskView *) maskView{
    if (_maskView == nil){
        _maskView  = [[SwitchPlayerMaskView alloc] initWithFrame:self.bounds listLoginModel:self.listLoginModel];
        _maskView.delegate = self;
    }
    return _maskView;
}

//MARK:JmoVxia---播放地址
- (void)setUrl:(NSURL *)url{
    [self resetPlayer];
    _url                      = url;
    self.playerItem           = [AVPlayerItem playerItemWithAsset:[AVAsset assetWithURL:_url]];
    _player                   = [AVPlayer playerWithPlayerItem:_playerItem];
    _playerLayer              = [AVPlayerLayer playerLayerWithPlayer:_player];
    //AVLayerVideoGravityResize;//全屏拉伸
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;//保持视频原有比例，不需要全屏拉伸
    //放到最下面，防止遮挡
    [self.layer insertSublayer:_playerLayer atIndex:0];
}

-(void)setPlayerItem:(AVPlayerItem *)playerItem{
    if (_playerItem == playerItem){
        return;
    }
    if (_playerItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:_playerItem];
        //重置播放器
        [self resetPlayer];
    }
    _playerItem = playerItem;
    if (playerItem) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayDidEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:playerItem];
    }
}

- (void)setState:(CLPlayerState)state{
    if (_state == state) {
        return;
    }
    _state = state;
    if (state == CLPlayerStateBuffering) {
        //[self.maskView.loadingView starAnimation];
    }else if (state == CLPlayerStateFailed){
        //[self.maskView.loadingView stopAnimation];
        //self.maskView.failButton.hidden   = NO;
        //self.maskView.playButton.selected = NO;
#ifdef DEBUG
        NSLog(@"加载失败");
#endif
    }else{
        //[self.maskView.loadingView stopAnimation];
        [self playVideo];
    }
}

//MARK:JmoVxia---dealloc
- (void)dealloc{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:_player.currentItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:[UIDevice currentDevice]];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillResignActiveNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
    //回到竖屏
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
#ifdef DEBUG
    NSLog(@"播放器被销毁了");
#endif
}

#pragma mark ----------初始化-------------

-(instancetype)initWithFrame:(CGRect)frame listLoginModel:(HomeListModel *)listLoginModel{
    
    if (self = [super initWithFrame:frame]){
        
        self.listLoginModel = listLoginModel;
        
        //开启
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];

        //APP运行状态通知，将要被挂起
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appDidEnterBackground:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        // app进入前台
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appDidEnterPlayground:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    self.backgroundColor = [UIColor blackColor];
    //最上面的View , 先去掉主要是 toolBar，等操作控件
    [self addSubview:self.maskView];
    
    //test
    self.maskView.backgroundColor = [UIColor clearColor];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
    self.maskView.frame    = self.bounds;
}

#pragma mark ---------类方法-------------

- (void)moviePlayDidEnd:(id)sender{
    [self.maskView showPlayBtn];
    [self pausePlay];
}

- (void)pausePlay{
    [_player pause];
}
- (void)playVideo{
    
    /*观看次数+1*/
//    NetWork_neighborhood_view *request = [[NetWork_neighborhood_view alloc] init];
//    request.token = [GlobalData sharedInstance].loginDataModel.token;
//    request.id = self.listLoginModel.id;
//    [request startPostWithBlock:^(NeighborhoodViewResponse *result, NSString *msg, BOOL finished) {
//        if(finished){
//            NSLog(@"-----%@ 观看成功",self.listLoginModel.topicContent);
//        }
//    }];
    
    [self.maskView hidePlayBtn];
    [_player play];
}

- (void)destroyPlayer{
    
    [self pausePlay];
    //移除
    [self.playerLayer removeFromSuperlayer];
    [self removeFromSuperview];
//    self.maskView.loadingView = nil;
    self.playerLayer = nil;
    self.player      = nil;
    self.maskView    = nil;
}

- (void)resetPlayer{
    //重置状态
    self.state   = CLPlayerStateStopped;
    //移除之前的
    [self pausePlay];
    [self.playerLayer removeFromSuperlayer];
    self.playerLayer = nil;
    self.player = nil;
}

//MARK:JmoVxia---重新开始播放
- (void)resetPlay{
    
    [_player seekToTime:CMTimeMake(0, 1) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self playVideo];
}

#pragma mark ---------SwitchPlayerMaskViewDelegate-------------
- (void)backButtonAction:(UIButton *)button{
    //self.
    
    if (self.backBlock){
        self.backBlock();
    }
}

- (void)playButtonAction:(UIButton *)button{
    [self resetPlay];
}

- (void)zanButtonAction:(UIButton *)button{
    //[self resetPlay];
    NSLog(@"---------------");
    
    
//    NetWork_topicPraise * request = [[NetWork_topicPraise alloc]init];
//    request.token = [GlobalData sharedInstance].loginDataModel.token;
//    request.topicId = self.listLoginModel.id;
////    [topicPraise showWaitMsg:@"" handle:self];
//    [request startPostWithBlock:^(TopicPraiseResponse * result, NSString *msg, BOOL finished) {
//        
//        if (finished) {
//            NSInteger zanCount = [self.listLoginModel.praiseNum integerValue];
//            zanCount += 1;
//            self.listLoginModel.praiseNum = [NSNumber numberWithInteger:zanCount];
//            self.listLoginModel.praiseFlag = YES;
//            self.maskView.listLoginModel = self.listLoginModel;
//            
//            //[[AddIntegralTool sharedInstance] addIntegral:self code:@"10008"];
//        }
//    }];
    
}


// 查看用户信息
- (void)userInfoAction
{
    if (self.pushUserInfo) {
        self.pushUserInfo();
    }
}
- (void)commentAction {
    if (self.commentClick) {
        self.commentClick();
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.hideCommentClick) {
        self.hideCommentClick();
    }
}

#pragma mark ---------App Background-------------

- (void)appDidEnterBackground:(NSNotification *)note{
    [self pausePlay];
}
- (void)appDidEnterPlayground:(NSNotification *)note{
        [self playVideo];
}

@end

