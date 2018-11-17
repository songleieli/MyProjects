//
//  MyImageView.h
//  致青春
//
//  Created by user on 13-7-17.
//  Copyright (c) 2013年 ouyangxiongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyImageDelegate;

@interface MyImageView : UIImageView

@property (assign, nonatomic) NSInteger index;

@property (weak  , nonatomic) id<MyImageDelegate> imageDelegate;

@end


@protocol MyImageDelegate <NSObject>

- (void)didSelectedWithImage:(MyImageView *)image pointFromWindow:(CGPoint)point row:(NSInteger)row;

@end