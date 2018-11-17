//
//  XLMyWelfareTicketVC.m
//  xl_native
//
//  Created by MAC on 2018/10/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLMyWelfareTicketVC.h"
#import "XLUsableTicketVC.h"

@interface XLMyWelfareTicketVC () <UIScrollViewDelegate>

@property (nonatomic,strong) UIView *indicatorView;
@property (nonatomic,strong) UIButton *selectButton;
@property (nonatomic,strong) UIView *titlesView;
@property (nonatomic,strong) UIScrollView *contentView;

@end

@implementation XLMyWelfareTicketVC


-(void)initNavTitle{
    [super initNavTitle];
    self.title = @"我的福利券";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupChildVces];
    
    [self setupTitlesView];
    
    [self setupContentView];
}
-(void)setupContentView
{
    CGFloat y = CGRectGetMaxY(self.navBackGround.frame) + 52;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = CGRectMake(0, y, ScreenWidth, ScreenHeight - y);
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.showsHorizontalScrollIndicator = NO;
    [self.view insertSubview:contentView atIndex:0];
    
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count,0);
    
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}
#pragma mark <UIScrollViewDelegate>
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x =scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    [scrollView addSubview:vc.view];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

-(void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor whiteColor];
    titlesView.width = ScreenWidth;
    titlesView.y = CGRectGetMaxY(self.navBackGround.frame);
    titlesView.height = 52;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = XLRGBColor(255, 97, 28);
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    NSArray *array = @[@"可兑换",@"待使用",@"已使用",@"已过期"];
    CGFloat width = titlesView.width / array.count;
    for (NSInteger i = 0; i < array.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.height = titlesView.height;
        button.width = width;
        button.x = i * width;
        [button setTitleColor:XLRGBColor(102, 102, 102) forState:UIControlStateNormal];
        [button setTitleColor:XLRGBColor(255, 97, 28) forState:UIControlStateDisabled];
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];

        if (i == 0) {
            [button.titleLabel sizeToFit];
            [self titleClick:button];
        }
    }
    [titlesView addSubview:indicatorView];
}
-(void)titleClick:(UIButton *)button
{
    self.selectButton.enabled = YES;
    button.enabled = NO;
    self.selectButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = self.selectButton.titleLabel.width;
        self.indicatorView.centerX = self.selectButton.centerX;
    }];
    
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

-(void)setupChildVces
{
    ///< 0使用过，1未使用过，2过期
    XLUsableTicketVC *first = [[XLUsableTicketVC alloc] init];
    first.isused = @"-1"; //可兑换
    [self addChildViewController:first];
    
    XLUsableTicketVC *second = [[XLUsableTicketVC alloc] init];
    second.isused = @"1"; //
    [self addChildViewController:second];
    
    XLUsableTicketVC *third = [[XLUsableTicketVC alloc] init];
    third.isused = @"0";
    [self addChildViewController:third];
    
    XLUsableTicketVC *forth = [[XLUsableTicketVC alloc] init];
    forth.isused = @"2";
    [self addChildViewController:forth];
}


@end
