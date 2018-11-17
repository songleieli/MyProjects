//
//  AlerViewJoinCostom.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/7/8.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "AlerViewJoinCostom.h"

#define kAlertWidth    sizeScale(254.0f)
#define kContentHeight sizeScale(250.0f)
#define kButtonHeight  sizeScale(43.0f)


@implementation AlerViewJoinCostom


-(id)initWithFontColor:(UIColor*)titleColor{
    self = [super init];
    
    if (self) {
        self.titleColor = titleColor;
    }
    return self;
}

-(void)popViewWithViewType:(AlerViewJoinCostom_Type)Type joinerIPone:(NSString *)jionerIpone leftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rigthTitle leftBlock:(void (^)())leftBlock rightBlock:(void (^)())rightBlock dismissBlock:(void (^)())dismissBlock{
    
    self.type = Type;

//  弹出视图的View
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    self.leftBlock = leftBlock;
    self.rightBlock =rightBlock;
    self.dismissBlock = dismissBlock;
    
    //顶部视图的View
    UIView * content = [[UIView alloc]init];
    content.frame =CGRectMake(0, 0, kAlertWidth, kContentHeight);
    content.backgroundColor = [UIColor whiteColor];
    self.tvContent = content;
    [self addSubview:content];
    
    if (Type == AlerViewJoinCostom_reserve) {
        [self createReserveUI:content popView:self leftTitle:leftTitle rigthTitle:rigthTitle];

    }
    if (Type == AlerViewJoinCostom_succeed){
        [self createSuccessUI:content];
        
    }
    if (Type == AlerViewJoinCostom_defeats) {
        [self createDefultUI:content];

    }
    if (Type == AlerViewJoinCostom_UpDataVersion) {
        
        [self createUpDataVersionUI:content leftTitle:leftTitle rigthTitle:rigthTitle];
    }
    
    [self resetFrame];
    [self show];
}
#pragma mark - 版本更新弹出视图
-(void)createUpDataVersionUI:(UIView *)content leftTitle:leftTitle rigthTitle:rigthTitle{
    //  contentView的描述
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"icon_update"];
    imageView.size = [UIView getSize_width:sizeScale(60) height:sizeScale(60)];
    imageView.left = (kAlertWidth - imageView.width)/2;
    imageView.top = sizeScale(30);
    [content addSubview:imageView];
    
    UILabel * labeltitle = [[UILabel alloc]init];
    labeltitle.size = [UIView getSize_width:150 height:sizeScale(19)];
    labeltitle.top  = imageView.bottom + sizeScale(30);
    labeltitle.left = (kAlertWidth - labeltitle.width)/2;
    labeltitle.text = @"发现新版本";
    labeltitle.textColor = self.titleColor;
    labeltitle.textAlignment = NSTextAlignmentCenter;
    labeltitle.font = [UIFont defaultFontWithSize:sizeScale(17)];
    [content addSubview:labeltitle];

    self.scrollBg = [[UIScrollView alloc]init];
    self.scrollBg.size = [UIView getSize_width:kAlertWidth - 15*2 height:90];
    self.scrollBg.origin = [UIView getPoint_x:15 y:labeltitle.bottom + sizeScale(15)];
    self.scrollBg.contentSize = CGSizeMake(self.scrollBg.width, 1000);
    self.scrollBg.backgroundColor = [UIColor clearColor];
    [self addSubview:self.scrollBg];
    
    UILabel * labelDecrbe = [[UILabel alloc]init];
    labelDecrbe.backgroundColor = [UIColor clearColor];
    labelDecrbe.text = [NSString stringWithFormat:@"%@",[self.upData stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"]];
    labelDecrbe.textColor = RGBFromColor(0xaaaaaa);
    labelDecrbe.top = 0;
    labelDecrbe.left = 5;
    labelDecrbe.numberOfLines = 0;
    labelDecrbe.font = [UIFont defaultFontWithSize:12];
    CGFloat labeleContectW = self.scrollBg.width-10;
    labelDecrbe.lineBreakMode = NSLineBreakByWordWrapping;
    CGRect labeleContectSize = [labelDecrbe.text boundingRectWithSize:CGSizeMake(labeleContectW, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:labelDecrbe.font,NSFontAttributeName, nil] context:nil];
    CGFloat labeleContectH = labeleContectSize.size.height;
    labelDecrbe.size = [UIView getSize_width:self.scrollBg.width-10 height:labeleContectH];
    [self.scrollBg addSubview:labelDecrbe];
    
    self.scrollBg.contentSize = CGSizeMake(kAlertWidth - 15*2,labelDecrbe.bottom);

    
    UILabel * labelLineTop = [[UILabel alloc]init];
    labelLineTop.size = [UIView getSize_width:kAlertWidth height:1];
    labelLineTop.left = 0;
    labelLineTop.top = kContentHeight- 1;
    labelLineTop.backgroundColor = RGBFromColor(0xecedf1);
    [content addSubview:labelLineTop];
    
    CGRect  leftBtnFram;
    CGRect  rightbtnFrame;
    //左侧按钮
    leftBtnFram = CGRectMake(0, CGRectGetMaxY(self.tvContent.frame),self.width/2, kButtonHeight);
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.frame = leftBtnFram;
    self.leftBtn.backgroundColor=[UIColor whiteColor];
    [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = [UIFont defaultFontWithSize:sizeScale(17)];
    [self.leftBtn setTitleColor:RGBAlphaColor(164, 164, 164, 1) forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:self.titleColor forState:UIControlStateHighlighted];
    [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftBtn];
    //分割xian
    UILabel * labelLine = [[UILabel alloc]init];
    labelLine.size = [UIView getSize_width:1 height:self.leftBtn.height];
    labelLine.left = kAlertWidth/2 - 1;
    labelLine.top = 0;
    labelLine.backgroundColor = RGBFromColor(0xecedf1);
    [self.leftBtn addSubview:labelLine];
    //右侧按钮
    rightbtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFram), CGRectGetMaxY(self.tvContent.frame), self.width/2, kButtonHeight);
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = rightbtnFrame;
    self.rightBtn.backgroundColor=[UIColor whiteColor];
    [self.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.titleLabel.font = [UIFont defaultFontWithSize:sizeScale(17)];
    [self addSubview:self.rightBtn];
}


#pragma mark - 发布失败的
-(void)createDefultUI:(UIView *)content {
    self.timer = 2;
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"neighborhood_iphoneDefeated"];
    imageView.size = [UIView getSize_width:sizeScale(60) height:sizeScale(60)];
    imageView.left = (kAlertWidth - imageView.width)/2;
    imageView.top = sizeScale(35);
    [content addSubview:imageView];
    
    UILabel * labeltitle = [[UILabel alloc]init];
    labeltitle.size = [UIView getSize_width:150 height:sizeScale(19)];
    labeltitle.top  = imageView.bottom + sizeScale(35);
    labeltitle.left = (kAlertWidth - labeltitle.width)/2;
    labeltitle.text = @"报名失败!";
    labeltitle.textColor = RGBFromColor(0xfa555c);
    labeltitle.textAlignment = NSTextAlignmentCenter;
    labeltitle.font = [UIFont defaultFontWithSize:sizeScale(17)];
    [content addSubview:labeltitle];
    
    UILabel * labelTime = [[UILabel alloc]init];
    
    labelTime.tag = 134689132740129;
    labelTime.textColor = RGBFromColor(0xfa555c);
    labelTime.textAlignment = NSTextAlignmentCenter;
    labelTime.size = [UIView getSize_width:100 height:15];
    labelTime.left = (kAlertWidth - labelTime.width)/2;
    labelTime.top = labeltitle.bottom +sizeScale(17);
    labelTime.text = [NSString stringWithFormat:@"%ld S",(long)self.timer--];
    [content addSubview:labelTime];
//    [GlobalData invalidateTimer];
//    [GlobalData sharedInstance].timerCode = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCodeString) userInfo:nil repeats:YES];



}
#pragma mark - 发布成功的
-(void)createSuccessUI:(UIView *)content{
    self.timer = 2;

    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"neighborhood_iphoneSucceed"];
    imageView.size = [UIView getSize_width:sizeScale(60) height:sizeScale(60)];
    imageView.left = (kAlertWidth - imageView.width)/2;
    imageView.top = sizeScale(35);
    [content addSubview:imageView];
    
    UILabel * labeltitle = [[UILabel alloc]init];
    labeltitle.size = [UIView getSize_width:150 height:sizeScale(19)];
    labeltitle.top  = imageView.bottom + sizeScale(35);
    labeltitle.left = (kAlertWidth - labeltitle.width)/2;
    labeltitle.text = @"已报名成功!";
    labeltitle.textColor = RGBFromColor(0xfa555c);
    labeltitle.textAlignment = NSTextAlignmentCenter;
    labeltitle.font = [UIFont defaultFontWithSize:sizeScale(17)];
    [content addSubview:labeltitle];

    UILabel * labelTime = [[UILabel alloc]init];
    
    labelTime.tag = 134689132740129;
    labelTime.textColor = RGBFromColor(0xfa555c);
    labelTime.textAlignment = NSTextAlignmentCenter;
    labelTime.size = [UIView getSize_width:100 height:15];
    labelTime.left = (kAlertWidth - labelTime.width)/2;
    labelTime.top = labeltitle.bottom +sizeScale(17);
    labelTime.text = [NSString stringWithFormat:@"%ld S",(long)self.timer--];
    [content addSubview:labelTime];
//    [GlobalData invalidateTimer];
//    [GlobalData sharedInstance].timerCode = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCodeString) userInfo:nil repeats:YES];
}

-(void)timerCodeString{
    
    if (self.timer == 0) {
        //关闭定时器
//        [GlobalData invalidateTimer];
        [self dismissAlert];
        return ;
    }
    UILabel * labelTime = (UILabel *)[self viewWithTag:134689132740129];
    labelTime.text = [NSString stringWithFormat:@"%ld S",(long)self.timer--];
}
#pragma mark - 预留界面UI
-(void)createReserveUI:(UIView *)content popView:(AlerViewJoinCostom *)popView leftTitle:(NSString *)leftTitle  rigthTitle:(NSString *)rigthTitle{
    //  contentView的描述
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"neighborhood_iphone"];
    imageView.size = [UIView getSize_width:sizeScale(60) height:sizeScale(60)];
    imageView.left = (kAlertWidth - imageView.width)/2;
    imageView.top = sizeScale(35);
    [content addSubview:imageView];
    
    UILabel * labeltitle = [[UILabel alloc]init];
    labeltitle.size = [UIView getSize_width:150 height:sizeScale(19)];
    labeltitle.top  = imageView.bottom + sizeScale(30);
    labeltitle.left = (kAlertWidth - labeltitle.width)/2;
    labeltitle.text = @"预留联系方式";
    labeltitle.textColor = RGBFromColor(0xfa555c);
    labeltitle.textAlignment = NSTextAlignmentCenter;
    labeltitle.font = [UIFont defaultFontWithSize:sizeScale(17)];
    [content addSubview:labeltitle];
    
    UILabel * labelDecrbe = [[UILabel alloc]init];
    NSString * stringDecrbe = [NSString stringWithFormat:@"为了方便联络,预留电话给活动发布者%@",@"15010320551"];
    labelDecrbe.text = stringDecrbe;
    labelDecrbe.size = [UIView getSize_width:sizeScale(220) height:sizeScale(30)];
    labelDecrbe.top = labeltitle.bottom +sizeScale(15);
    labelDecrbe.left = (kAlertWidth - labelDecrbe.width)/2;
    labelDecrbe.numberOfLines = 0;
    labelDecrbe.textAlignment = NSTextAlignmentCenter;
    labelDecrbe.textColor = RGBFromColor(0xaaaaaa);
    labelDecrbe.font = [UIFont defaultFontWithSize:sizeScale(12)];
    [content addSubview:labelDecrbe];
    UILabel * labelLineTop = [[UILabel alloc]init];
    labelLineTop.size = [UIView getSize_width:kAlertWidth height:1];
    labelLineTop.left = 0;
    labelLineTop.top = kContentHeight- 1;
    labelLineTop.backgroundColor = RGBFromColor(0xecedf1);
    [content addSubview:labelLineTop];
    CGRect  leftBtnFram;
    CGRect  rightbtnFrame;
    //左侧按钮
    leftBtnFram = CGRectMake(0, CGRectGetMaxY(popView.tvContent.frame),popView.width/2, kButtonHeight);
    popView.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popView.leftBtn.frame = leftBtnFram;
    popView.leftBtn.backgroundColor=[UIColor whiteColor];
    [popView.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
    popView.leftBtn.titleLabel.font = [UIFont defaultFontWithSize:sizeScale(17)];
    [popView.leftBtn setTitleColor:RGBAlphaColor(164, 164, 164, 1) forState:UIControlStateNormal];
    [popView.leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [popView.leftBtn addTarget:popView action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [popView addSubview:popView.leftBtn];
    //分割xian
    UILabel * labelLine = [[UILabel alloc]init];
    labelLine.size = [UIView getSize_width:1 height:popView.leftBtn.height];
    labelLine.left = kAlertWidth/2 - 1;
    labelLine.top = 0;
    labelLine.backgroundColor = RGBFromColor(0xecedf1);
    [popView.leftBtn addSubview:labelLine];
    //右侧按钮
    rightbtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFram), CGRectGetMaxY(popView.tvContent.frame), popView.width/2, kButtonHeight);
    popView.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popView.rightBtn.frame = rightbtnFrame;
    popView.rightBtn.backgroundColor=[UIColor whiteColor];
    [popView.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
    [popView.rightBtn setTitleColor:RGBFromColor(0xfa555c) forState:UIControlStateNormal];
    [popView.rightBtn addTarget:popView action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    popView.rightBtn.titleLabel.font = [UIFont defaultFontWithSize:sizeScale(17)];
    [popView addSubview:popView.rightBtn];
}
#pragma mark - 点击左右按钮
- (void)leftBtnClicked:(id)sender
{
    
    _leftLeave = YES;
    if (self.leftBlock) {
        self.leftBlock();
    }
    [self dismissAlert];
}

- (void)rightBtnClicked:(id)sender
{
    
    NSLog(@"%d",self.isDismissAlertView);

    _leftLeave = NO;
    if (self.rightBlock) {
        self.rightBlock();
    }
    if (self.isDismissAlertView == NO) {
    }else{
        [self dismissAlert];
    }


}
#pragma mark - view显示的空间
-(void)show{
    // 弹出一个window视图。在window上显示View控件
    UIViewController *topVC = [self appRootViewController];
    self.frame=CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5,
                          -self.frame.origin.y-30,
                          self.frame.size.width,
                          self.frame.size.height);
    NSLog(@"------------------------%f",self.frame.size.height);
    NSLog(@"------------------------%f",self.frame.origin.y);
    [topVC.view addSubview:self];
}
- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

//View控件消失
- (void)dismissAlert{
    

    if (self.dismissBlock) {
        self.dismissBlock();
    }
    [self removeFromSuperview];

}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPress:)];
        tapGesture.numberOfTapsRequired=1;
        [self.backImageView addGestureRecognizer:tapGesture];
        
    }
    [topVC.view addSubview:self.backImageView];
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    
    
    self.transform = CGAffineTransformMakeRotation(0);
    self.frame =  self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - self.frame.size.height) * 0.5,
                                          self.frame.size.width,
                                          self.frame.size.height);
    
    
    [super willMoveToSuperview:newSuperview];
}
#pragma mark UITapGestureRecognizer
-(void)handleTapPress:(UITapGestureRecognizer *)gestureRecognizer
{
    if (self.type == AlerViewJoinCostom_UpDataVersion) {
        return;
    }
    _leftLeave = YES;
    [self dismissAlert];
}

//重写remoview方法
- (void)removeFromSuperview
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5,
                            CGRectGetHeight(topVC.view.bounds),
                            self.frame.size.width,
                            self.frame.size.height);
    if (_leftLeave) {
        self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
    }else {
        self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
    }
    
    [super removeFromSuperview];
}
#pragma mark - 设置白色view的大小
-(void)resetFrame{
    {
        CGRect frame=self.tvContent.frame;
        frame.size.height=kContentHeight;
        self.tvContent.frame=frame;
    }
    {
        CGRect leftBtnFrame = CGRectMake(0, CGRectGetMaxY(self.tvContent.frame),kAlertWidth/2, kButtonHeight);
        CGRect rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame), CGRectGetMaxY(self.tvContent.frame), kAlertWidth/2, kButtonHeight);
        self.leftBtn.frame = leftBtnFrame;
        self.rightBtn.frame = rightBtnFrame;
    }
    {
        CGRect frame=self.frame;
        frame.size.height=kButtonHeight
        +self.tvContent.frame.size.height;
        frame.size.width=kAlertWidth;
        self.frame=frame;
    }
}
@end
