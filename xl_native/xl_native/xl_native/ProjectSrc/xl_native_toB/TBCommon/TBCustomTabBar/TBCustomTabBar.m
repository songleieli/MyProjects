//
//  CustomTabBar.m
//  CustomTabBarController
//
//  Created by Hu Zhiqiang on 22/05/2012.
//  Copyright (c) 2012 __My Computer__. All rights reserved.
//

#import "TBCustomTabBar.h"

@implementation TBCustomTabBar
@synthesize delegate = _delegate;
@synthesize buttons = _buttons;

- (id)initWithButtonImages:(NSArray *)imageArray
                titleArray:(NSArray*)titleArray
                  delegate:(id<TBCustomTabBarDelegate>)delegate{
    
    self = [super init];
    if (self){
        
        self.delegate = delegate;
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.4)];
        lineLabel.backgroundColor = RGBAlphaColor(222, 222, 222, 0.8);
        [self addSubview:lineLabel];
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
        int offX = 0;
        float width = ScreenWidth/imageArray.count+0.4; //320/30=106.6 3个106.6 加起来不够320，所以需要添加0.4
        
        for (int i = 0; i < [imageArray count]; i++){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            btn.frame = CGRectMake(offX, 1, width, kTabBarHeight_New);
            btn.backgroundColor = [UIColor whiteColor];
            [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            offX += width;
            
            UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            imgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            imgBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            imgBtn.tag = i;
            imgBtn.frame = CGRectMake(0, 5, 20, 20);
            
            //imgBtn.backgroundColor = [UIColor redColor];
            
//            NSString *classStr = NSStringFromClass([self.delegate superclass]);
//            if([classStr isEqualToString:@"ZJCustomTabBarLjhTableViewController"]){
                if(i == 2){
                    CGFloat imageHeight = sizeScale(45);
                    CGFloat imgBtnTop = - imageHeight/4;//+sizeScale(3.5);
                    imgBtn.frame = CGRectMake(0, imgBtnTop, imageHeight, imageHeight);
                }
//            }
            
            imgBtn.left = (btn.width - imgBtn.width)/2;
            [btn addSubview:imgBtn];
            
            UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            titleBtn.tag = i;
            titleBtn.frame = CGRectMake(0, 0, width, 12);
            
            titleBtn.top = kTabBarHeight_New - titleBtn.height - sizeScale(4.5);
            if(isIPhoneXAll){
                titleBtn.top = kTabBarHeight_New - titleBtn.height - sizeScale(4.5) - 34;
            }
            
            titleBtn.titleLabel.font = [UIFont defaultFontWithSize: 11.0];
            [titleBtn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [titleBtn setTitleColor:NavLableColor forState:UIControlStateNormal];
            [titleBtn setTitleColor:defaultMainColor forState:UIControlStateSelected];
            [titleBtn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn addSubview:titleBtn];
            
            [imgBtn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"]  forState:UIControlStateNormal];
            [imgBtn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Seleted"]  forState:UIControlStateSelected];
            
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
