//
//  FirstFunctionViewController.m
//  unify_platform
//
//  Created by mac on 2018/7/7.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLGchangNewViewController.h"
#import "NetWork_uploadApi.h"
#import "NetWork_voice_order_add.h"

@interface XLGchangNewViewController ()

@property (copy, nonatomic) NSString *myCallBack;

@end

@implementation XLGchangNewViewController

#pragma mark =========== 懒加载 ===========

#pragma mark --- header ---

- (MyScrollView *)scrolBanner{
    
    if (!_scrolBanner) {
        CGRect rect =  [UIView getFrame_x:0 y:0 width:ScreenWidth height:sizeScale(137)];
        _scrolBanner = [[MyScrollView alloc] initWithFrame:rect];
        _scrolBanner.scrolDelegate = self;
    }
    return  _scrolBanner;
}

- (XLGCBodyView *)bodyView{
    
    if (!_bodyView) {
        CGRect rect =  [UIView getFrame_x:0 y:0 width:ScreenWidth height:sizeScale(137)];
        _bodyView = [[XLGCBodyView alloc] initWithFrame:rect];
//        _bodyView.scrolDelegate = self;
    }
    return  _bodyView;
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    /*四个一级页面判断需要登录，我爱我乡没有游客模式*/
//    [[ZJLoginService sharedInstance] authenticateWithCompletion:^(BOOL success) {
//    } cancelBlock:nil isAnimat:YES];
//    
    self.tabBar.top = [self getTabbarTop];    //  重新设置tabbar的高度
}

-(void)initNavTitle{
    self.isNavBackGroundHiden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark ------ CustomMethod  ------

-(void)setupUI{
    [self.view addSubview:self.tableView];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    
    NSInteger tableViewHeight = ScreenHeight -kTabBarHeight_New - KViewStartTopOffset_New;
    
    self.tableView.size = [UIView getSize_width:ScreenWidth height:tableViewHeight];
    self.tableView.origin = [UIView getPoint_x:0 y:KViewStartTopOffset_New];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = XLColorBackgroundColor; //RGBFromColor(0xecedf1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    
    self.tableView.tableHeaderView = [self getHeadView];
    self.tableView.tableFooterView = [self getFooterView];
}

-(UIView*)getHeadView{
    
    self.viewHeadBg = [[UIView alloc] init];
    self.viewHeadBg.size = [UIView getSize_width:ScreenWidth height:self.scrolBanner.height + 15];
    self.viewHeadBg.origin = [UIView getPoint_x:0 y:0];
    self.viewHeadBg.backgroundColor = XLColorBackgroundColor;
    
    
    //财富计划
    [self.viewHeadBg addSubview:self.scrolBanner];
//    [self.viewHeadBg addSubview:self.viewWealthPlan];
//    //游戏View
//    [self.viewHeadBg addSubview:self.viewGame];
//    [self.viewHeadBg bringSubviewToFront:self.viewWealthPlan]; //放置到最上乘
//
//    self.viewHeadBg.height = self.viewGame.bottom;
    //加载，首页滚动图
    NSMutableArray *muArrViews = [NSMutableArray array];
    [muArrViews addObject:@"banner_wealth_chuangye"];
    [self.scrolBanner reloadData:muArrViews pageEnable:YES full:NO];
    
    return self.viewHeadBg;
}

-(UIView*)getFooterView{
    
    self.viewFooterBg = [[UIView alloc] init];
    self.viewFooterBg.size = [UIView getSize_width:ScreenWidth height:sizeScale(184)];
    self.viewFooterBg.origin = [UIView getPoint_x:0 y:0];
    
//    [self.viewFooterBg addSubview:self.viewFooterTitle];
    
    NSMutableArray *arrayExteriorFunctions = [[NSMutableArray alloc]init];
    
    
    GCItemModel *itemModelThree = [[GCItemModel alloc]init];
    itemModelThree.itemTitle = @"儿童乐园";
    itemModelThree.itemIcon = @"xl_children_park";
    itemModelThree.itemContent = @"大牌厂商 安全放心";
    itemModelThree.gcType = XLGC_ChildrenPark;
    [arrayExteriorFunctions addObject:itemModelThree];
    
    GCItemModel *itemModelOne = [[GCItemModel alloc]init];
    itemModelOne.itemTitle = @"百货小店";
    itemModelOne.itemIcon = @"xl_small_shop";
    itemModelOne.itemContent = @"线上下单 送货到家";

    itemModelOne.gcType = XLGC_SmallShop;
    [arrayExteriorFunctions addObject:itemModelOne];
    
    GCItemModel *itemModelTwo = [[GCItemModel alloc]init];
    itemModelTwo.itemTitle = @"乡里美食";
    itemModelTwo.itemIcon = @"xl_local_food";
    itemModelTwo.itemContent = @"乡邻美食 一键送达";
    itemModelTwo.gcType = XLGC_LocalFood;
    [arrayExteriorFunctions addObject:itemModelTwo];
    
    
    GCItemModel *itemModelClean = [[GCItemModel alloc]init];
    itemModelClean.itemTitle = @"乡村影院";
    itemModelClean.itemIcon = @"xl_country_movie";
    itemModelClean.itemContent = @"超级大片 每周放送";
    itemModelClean.gcType = XLGC_CountryMovie;
    [arrayExteriorFunctions addObject:itemModelClean];
    
    [self.viewFooterBg addSubview:self.bodyView];
    
    [self.bodyView reloadWithSource:arrayExteriorFunctions];
    
    __weak __typeof(self) weakSelf = self;
    [self.bodyView setBlockClcik:^(GCItemModel *item) {
        [weakSelf showFaliureHUD:@"广场建设中，敬请期待"];
    }];
    
    self.viewFooterBg.height = self.bodyView.bottom;
    return self.viewFooterBg;
}


@end
