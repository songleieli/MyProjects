//
//  SamPlayerScrollView.h
//  inke
//
//  Created by songleilei on 2/7/17.
//  Copyright © 2017 Zhejiang University of Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWork_mt_home_list.h" //视频列表



@class SwitchPlayerScrollView;

@protocol SamPlayerScrollViewDelegate <NSObject>

- (void)playerScrollView:(SwitchPlayerScrollView *)playerScrollView currentPlayerIndex:(NSInteger)index;

@end

@interface SwitchPlayerScrollView : UIScrollView

@property (nonatomic, assign) id<SamPlayerScrollViewDelegate> playerDelegate;
@property (nonatomic, assign) NSInteger index;
- (instancetype)initWithFrame:(CGRect)frame;

- (void)updateForLives:(NSMutableArray *)livesArray withCurrentIndex:(NSInteger) index;

@end

