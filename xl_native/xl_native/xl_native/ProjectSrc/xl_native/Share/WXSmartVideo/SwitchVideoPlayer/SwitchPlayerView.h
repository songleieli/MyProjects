//
//  PlayerView.h
//  CLPlayerDemo
//
//  Created by JmoVxia on 2016/11/1.
//  Copyright © 2016年 JmoVxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchPlayerMaskView.h"

#import "NetWork_neighborhood_view.h"
#import "NetWork_topicPraise.h"

#import "NetWork_mt_home_list.h"



//typedef void(^BackButtonBlock)(UIButton *button);
//typedef void(^EndBolck)(void);



@interface SwitchPlayerView : UIView<SwitchPlayerMaskViewDelegate>

/*初始化方法传入listLoginModel*/
-(instancetype)initWithFrame:(CGRect)frame listLoginModel:(HomeListModel *)listLoginModel;

/**视频url*/
@property (nonatomic, strong) NSURL *url;
/**播放*/
- (void)playVideo;
/**暂停*/
- (void)pausePlay;
/**销毁播放器*/
- (void)destroyPlayer;

/**返回按钮Block*/

@property (nonatomic, strong) void (^backBlock)();

/*视频model*/
@property (nonatomic, strong) HomeListModel *listLoginModel;

@property (copy, nonatomic) dispatch_block_t pushUserInfo; ///< 进入个人信息页面
@property (copy, nonatomic) dispatch_block_t commentClick; ///< 评论
@property (copy, nonatomic) dispatch_block_t hideCommentClick; 

@end
