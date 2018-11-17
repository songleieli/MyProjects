//
//  MBPlaySmartVideoViewController.h
//  SmartVideo
//
//  Created by songleilei on 17/1/5.
//  Copyright © 2017年 Nxin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SwitchPlayerView.h"
#import "UIView+CLSetRect.h"
#import "SwitchPlayerScrollView.h"
#import "SwitchPlayerSelectTagView.h"

typedef enum : NSUInteger {
    VideoTypeHome = 0,    //首页
    VideoTypeHot = 1,     //热门
    VideoTypeFollow = 2,  //关注
} VideoType;

@interface SwitchPlayerViewController : UIViewController <SamPlayerScrollViewDelegate>

@property (nonatomic, copy) NSString *videoUrlString;
@property (nonatomic,strong) SwitchPlayerView *playerView;
@property (nonatomic,assign) VideoType videoType;

//滚动条
@property(nonatomic, strong) SwitchPlayerScrollView * playerScrollView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong)HomeListModel *clickItem;
/*选择标签*/
@property (nonatomic,strong) SwitchPlayerSelectTagView *selectTagView;
@property (nonatomic, strong)FindAllTagDataModel *currTagModel;


@end
