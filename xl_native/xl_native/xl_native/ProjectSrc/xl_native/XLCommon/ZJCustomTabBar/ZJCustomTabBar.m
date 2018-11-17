//
//  CustomTabBar.m
//  CustomTabBarController
//
//  Created by Hu Zhiqiang on 22/05/2012.
//  Copyright (c) 2012 __My Computer__. All rights reserved.
//

#import "ZJCustomTabBar.h"

@implementation ZJCustomTabBar
@synthesize delegate = _delegate;
@synthesize buttons = _buttons;

- (id)initWithButtonImages:(NSArray *)imageArray
                titleArray:(NSArray*)titleArray
                  delegate:(id<ZJCustomTabBarDelegate>)delegate{
    
    self = [super init];
    if (self){
        
        self.delegate = delegate;
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.4)];
        lineLabel.backgroundColor = [UIColor grayColor]; //RGBAlphaColor(222, 222, 222, 0.8);
        [self addSubview:lineLabel];
        
        if([NSStringFromClass([self.delegate class]) isEqualToString:@"XlHomeViewController"]){
            self.backgroundColor = [UIColor clearColor];
        }
        else{
            self.backgroundColor = [UIColor blackColor];
        }
        
        self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
        int offX = 0;
        CGFloat width = (CGFloat)ScreenWidth/imageArray.count; //320/30=106.6 3个106.6 加起来不够320，所以需要添加0.4
        
        for (int i = 0; i < [imageArray count]; i++){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            btn.frame = CGRectMake(offX, 0.4, width, kTabBarHeight_New-0.4);
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            offX += width;
            
            
            UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            titleBtn.tag = i;
            titleBtn.size = [UIView getSize_width:30 height:20];
            titleBtn.origin = [UIView getPoint_x:(btn.width - titleBtn.width)/2
                                               y:(btn.height - titleBtn.height)/2];
            
            
//            titleBtn.frame = CGRectMake(0, 0, width, 12);
//
//            titleBtn.top = kTabBarHeight_New - titleBtn.height - sizeScale(4.5);
//            if(isIPhoneXAll){
//                titleBtn.top = kTabBarHeight_New - titleBtn.height - sizeScale(4.5) - 34;
//            }
            
            titleBtn.titleLabel.font = [UIFont defaultBoldFontWithSize: 15.0];
            [titleBtn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [titleBtn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn addSubview:titleBtn];
            
            //test
//            titleBtn.backgroundColor = [UIColor redColor];
            
            
            UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            imgBtn.size = [UIView getSize_width:titleBtn.width height:5];
            imgBtn.origin = [UIView getPoint_x:titleBtn.left y:btn.height - imgBtn.height];
            [imgBtn setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
            [imgBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateSelected];
//            imgBtn.backgroundColor = [GlobalFunc randomColor];
            
//            imgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//            imgBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            imgBtn.tag = i;
//            imgBtn.frame = CGRectMake(0, btn.height - , btn.width, 5);
            
            
            if(i == 2){
//                CGFloat imageHeight = 115;
//                CGFloat imgBtnTop = - imageHeight/4;//+sizeScale(3.5);
                imgBtn.frame = CGRectMake(0, 5, 50, 32);
                UIImage *img = [BundleUtil getCurrentBundleImageByName:@"mt_publish"];
                [imgBtn setImage:img  forState:UIControlStateNormal];
            }
            
            imgBtn.left = (btn.width - imgBtn.width)/2;
            [btn addSubview:imgBtn];
            [imgBtn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttons addObject:btn];
            [self addSubview:btn];
        }
    }
    return self;
}


////暂时不用了
//- (void)longPressBtn:(UILongPressGestureRecognizer*)guester{
//     NSLog(@"长按事件%ld",guester.view.tag);
//
//
//    if ([_delegate respondsToSelector:@selector(tabBar:longPressed:guester:)]){
//        [_delegate tabBar:self longPressed:guester.view.tag guester:guester];
//    }
//
//}


- (void)tabBarButtonClicked:(id)sender{
    UIButton *btn = sender;
    if ([_delegate respondsToSelector:@selector(tabBar:shouldSelectIndex:)]){
        BOOL should = [_delegate tabBar:self shouldSelectIndex:btn.tag];
        if(should == NO){
            return;
        }
    }
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)]){
        [_delegate tabBar:self didSelectIndex:btn.tag];
    }
}

- (void)selectTabAtIndex:(NSInteger)index{
    for (int i = 0; i < [self.buttons count]; i++){
        UIButton *imgBtn = [[[self.buttons objectAtIndex:i] subviews] objectAtIndex:0];
        UIButton *titleBtn = [[[self.buttons objectAtIndex:i] subviews] objectAtIndex:1];
        imgBtn.selected = NO;
        titleBtn.selected = NO;
        
        
    }
    UIButton *imgBtn = [[[self.buttons objectAtIndex:index] subviews] objectAtIndex:0];
    UIButton *titleBtn = [[[self.buttons objectAtIndex:index] subviews] objectAtIndex:1];
    imgBtn.selected = YES;
    titleBtn.selected = YES;
    
    [imgBtn setUserInteractionEnabled:NO];
}

@end
