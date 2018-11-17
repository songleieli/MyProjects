//
//  TopicCell.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/26.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "Network_hotTopicList.h"
#import "Network_topicViewNoLogin.h"
#import "Network_topicViewLogin.h"
#import "NetWork_topicOffPraise.h"
#import "ImageButton.h"
#import "ButtonMaskView.h"
//add by songlei
#import "LxGridViewFlowLayout.h"
#import "TZTestCell.h"


@protocol ClickDelegate <NSObject>

/*赞点击*/
-(void)clickPraiseDelegate:(NSString *)topicId andCell:(UITableViewCell *)cell;

/*点击播放视频*/
-(void)clickPlayVedio:(ListLoginModel*)listLoginModel;

/*点击tag*/
-(void)clickTag:(ListLoginModel*)listLoginModel;

/*背景点击，查看详情*/
-(void)clickViewBgDelegate:(ListLoginModel *)listLoginModel;

/*点击评论按钮*/
-(void)clickCommentDelegate:(ListLoginModel *)listLoginModel;

/*点击用户头像*/
-(void)clickUserIcon:(ListLoginModel *)listLoginModel;

@end

@interface TopicCell : BaseTableViewCell

@property(nonatomic, weak)id <ClickDelegate> clickDelegate;

@property (nonatomic,strong)UIButton *iconBtn;

@property (nonatomic,strong)UILabel *nameLable;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UILabel *timeLabel;
//@property (nonatomic,strong)UILabel * typeLabel;
@property (nonatomic,strong)UILabel * locationLabel;
@property (nonatomic,strong)UIButton * zanBtn;
@property (nonatomic,strong)UIButton * commentBtn;
@property (nonatomic,strong)UILabel * zanLabel;
@property (nonatomic,strong)UILabel * commentLabel;

//评论大btn
@property(nonatomic,strong) UIButton * commentBigBtn;
//点赞大btn
@property(nonatomic,strong) UIButton * zanBigBtn;

@property(nonatomic, strong)NSMutableArray * imageArr;

@property(nonatomic,assign)CGFloat H;
@property (nonatomic,strong)UIView * separateView;

@property (nonatomic, strong) UIView *maskView;
//add by songlei
@property(nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,assign) NSInteger itemWH;
@property (nonatomic,assign) NSInteger margin;
@property (nonatomic,assign) NSInteger colCount;
@property(nonatomic,strong) LxGridViewFlowLayout *layout;

@property (nonatomic, strong)ListLoginModel * listLoginModel;

@property(nonatomic,strong)UIButton * viewBg;

@end
