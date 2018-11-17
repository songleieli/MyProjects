//
//  FirstFunctionViewController.m
//  unify_platform
//
//  Created by mac on 2018/7/7.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "TBWealthPlanViewController.h"
#import "Callback_token.h"
#import "XLBreedingPlanVC.h"
#import "XLBusinessPlanVC.h"
#import "XLPlantingPlanVC.h"
#import "XLSearchVC.h"

@interface TBWealthPlanViewController () <UIScrollViewDelegate>

@property (nonatomic,strong) UIView *indicatorView;
@property (nonatomic,strong) UIButton *selectButton;
@property (nonatomic,strong) UIView *titlesView;
@property (nonatomic,strong) UIScrollView *contentView;

@property (strong, nonatomic) UILabel *planting;
@property (strong, nonatomic) UILabel *breeding;
@property (strong, nonatomic) UILabel *business;

@end

@implementation TBWealthPlanViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*四个一级页面判断需要登录，我爱我乡没有游客模式*/
    [[TBLoginService sharedInstance] authenticateWithCompletion:^(BOOL success) {
    } cancelBlock:nil isAnimat:YES];

    self.tabBar.top = [self getTabbarTop];    //  重新设置tabbar的高度
}

- (void)dealloc {
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"财富计划";

    [self addNavigationItem];
    [self addSearchBar];
    
    [self setupChildVces];
    
    [self setupTitlesView];
    
    [self setupContentView];
}

-(void)setupContentView
{
    CGFloat y = CGRectGetMaxY(self.navBackGround.frame) + 52 + 46;
    
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
    
    [XLTBSingleTool sharedInstance].searchType = index + 1;
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
    titlesView.y = CGRectGetMaxY(self.navBackGround.frame) + 46;
    titlesView.height = 52;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = XLRGBColor(9, 114, 218);
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    NSArray *array = @[@"种植计划",@"养殖计划",@"创业计划"];
    CGFloat width = titlesView.width / array.count;
    for (NSInteger i = 0; i < array.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.height = titlesView.height;
        button.width = width;
        button.x = i * width;
        [button setTitleColor:XLRGBColor(102, 102, 102) forState:UIControlStateNormal];
        [button setTitleColor:XLRGBColor(9, 114, 218) forState:UIControlStateDisabled];
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

-(void)setupChildVces {
    XLPlantingPlanVC *first = [[XLPlantingPlanVC alloc] init];
    first.totallBlock = ^(NSInteger total) {
        if (total >99) {
            self.planting.text = @"99+";
        } else {
            self.planting.text = [NSString stringWithFormat:@"%ld",(long)total];
        }
    };
    [self addChildViewController:first];

    XLBreedingPlanVC *second = [[XLBreedingPlanVC alloc] init];
    second.totallBlock = ^(NSInteger total) {
        if (total >99) {
            self.breeding.text = @"99+";
        } else {
            self.breeding.text = [NSString stringWithFormat:@"%ld",(long)total];
        }
    };
    [self addChildViewController:second];

    XLBusinessPlanVC *third = [[XLBusinessPlanVC alloc] init];
    third.totallBlock = ^(NSInteger total) {
        if (total >99) {
            self.business.text = @"99+";
        } else {
            self.business.text = [NSString stringWithFormat:@"%ld",(long)total];
        }
    };
    [self addChildViewController:third];
}
- (UILabel *)planting {
    if (!_planting) {
        _planting = [[UILabel alloc] init];
        _planting.textColor = [UIColor whiteColor];
        _planting.backgroundColor = [UIColor redColor];
        _planting.font = [UIFont systemFontOfSize:10];
        _planting.textAlignment = NSTextAlignmentCenter;
        viewBorderRadius(_planting, 10, 0, [UIColor clearColor]);
        [self.view addSubview:_planting];

        [_planting mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(20);
            make.right.equalTo(self.view.mas_left).offset(self.titlesView.width / 3 - 5);
            make.top.equalTo(self.titlesView).offset(5);
        }];
    }
    return _planting;
}
- (UILabel *)breeding {
    if (!_breeding) {
        _breeding = [[UILabel alloc] init];
        _breeding.textColor = [UIColor whiteColor];
        _breeding.backgroundColor = [UIColor redColor];
        _breeding.font = [UIFont systemFontOfSize:10];
        _breeding.textAlignment = NSTextAlignmentCenter;
        viewBorderRadius(_breeding, 10, 0, [UIColor clearColor]);
        [self.view addSubview:_breeding];
        
        [_breeding mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(20);
            make.right.equalTo(self.view.mas_left).offset(self.titlesView.width / 3 * 2 - 5);
            make.top.equalTo(self.titlesView).offset(5);
        }];
    }
    return _breeding;
}
- (UILabel *)business {
    if (!_business) {
        _business = [[UILabel alloc] init];
        _business.textColor = [UIColor whiteColor];
        _business.backgroundColor = [UIColor redColor];
        _business.font = [UIFont systemFontOfSize:10];
        _business.textAlignment = NSTextAlignmentCenter;
        viewBorderRadius(_business, 10, 0, [UIColor clearColor]);
        [self.view addSubview:_business];
        
        [_business mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(20);
            make.right.equalTo(self.view.mas_left).offset(self.titlesView.width - 5);
            make.top.equalTo(self.titlesView).offset(5);
        }];
    }
    return _business;
}


@end
