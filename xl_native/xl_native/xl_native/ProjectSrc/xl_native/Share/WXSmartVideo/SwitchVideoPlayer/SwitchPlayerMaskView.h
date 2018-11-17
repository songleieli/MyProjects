//
//  CLPlayerMaskView.h
//  CLPlayerDemo
//
//  Created by JmoVxia on 2017/2/24.
//  Copyright © 2017年 JmoVxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLSlider.h"
#import "AILoadingView.h"
#import "NetWork_mt_home_list.h"
//#import "NetWork_video_list.h" //视频列表

/**
 *  space
 */
#define  Video_Btn_space      20.0f


@protocol SwitchPlayerMaskViewDelegate <NSObject>

/**返回按钮代理*/
- (void)backButtonAction:(UIButton *)button;
- (void)userInfoAction;///< 查看用户信息
- (void)commentAction;///< 查看用户信息

/**播放按钮*/
- (void)playButtonAction:(UIButton *)button;

/*点赞*/
- (void)zanButtonAction:(UIButton *)button;

@end

@interface SwitchPlayerMaskView : UIView

/*初始化方法传入listLoginModel*/
-(instancetype)initWithFrame:(CGRect)frame listLoginModel:(HomeListModel *)listLoginModel;

/**返回按钮*/
//@property (nonatomic,strong) UIButton *searchButton;
/**头像*/
@property(nonatomic,strong) UIImageView * imageViewUser;
/**赞*/
@property(nonatomic,strong) UIButton * btnZan;
/*赞数量*/
@property(nonatomic,strong) UILabel * lableZanCount;
/**评论*/
@property(nonatomic,strong) UIButton * btnComment;
/*评论量*/
@property(nonatomic,strong) UILabel * lableCommentCount;

/**查看*/
@property(nonatomic,strong) UIButton * btnView;
/*查看量*/
@property(nonatomic,strong) UILabel * lableViewCount;
/*视频内容*/
@property(nonatomic,strong) UILabel * lableVideoContent;
/*视频发布者*/
@property(nonatomic,strong) UILabel * lablePublisher;

/**头像*/
@property(nonatomic,strong) UIImageView * imageViewbg;

/**播放按钮*/
@property(nonatomic,strong) UIButton * btnPlay;

/*视频model*/
@property (nonatomic, strong) HomeListModel *listLoginModel;

/**代理人*/
@property (nonatomic,weak) id<SwitchPlayerMaskViewDelegate> delegate;


-(void)showPlayBtn;
-(void)hidePlayBtn;

@end
