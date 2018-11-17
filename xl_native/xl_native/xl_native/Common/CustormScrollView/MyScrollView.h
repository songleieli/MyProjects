//
//  MyScrollView.h
//  中酒批
//
//  Created by ios on 13-12-19.
//  Copyright (c) 2013年 Ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyImageView.h"

@protocol MyScrolDelegate;

@interface MyScrollView : UIView <UIScrollViewDelegate>

@property (strong, nonatomic) NSTimer *scrolTimer;
@property (strong, nonatomic) UIScrollView *scrolDefault;
@property (strong, nonatomic) UIPageControl *pageDefault;
@property (weak, nonatomic) id<MyScrolDelegate> scrolDelegate;

- (void)reloadData:(NSArray*)source pageEnable:(BOOL)pageEnable full:(BOOL)full;

@end


@protocol MyScrolDelegate <NSObject>

- (void)myScrolView:(MyScrollView *)scrol didSelectedImgWithRow:(NSInteger)row;

@end
