//
//  AlerViewJoinCostom.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/7/8.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    AlerViewJoinCostom_reserve = 0,
    AlerViewJoinCostom_succeed,
    AlerViewJoinCostom_defeats,
    AlerViewJoinCostom_UpDataVersion
}AlerViewJoinCostom_Type ;

@interface AlerViewJoinCostom : UIView

@property(nonatomic,assign) BOOL  isDismissAlertView;
@property(nonatomic,strong) UIScrollView * scrollBg;
@property(nonatomic,assign) AlerViewJoinCostom_Type  type;
@property(nonatomic,strong) NSString * upData;//更新内容
@property(nonatomic,strong) UIColor * titleColor;//字体颜色



@property (nonatomic) BOOL leftLeave;
@property (nonatomic, strong) UIView *tvContent;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;
@property(nonatomic,assign) NSInteger  timer;
@property(nonatomic,strong) void(^leftBlock)();
@property(nonatomic,strong) void(^rightBlock)();
@property(nonatomic,strong) void(^dismissBlock)();

-(id)initWithFontColor:(UIColor*)titleColor;

-(void)popViewWithViewType:(AlerViewJoinCostom_Type )Type joinerIPone:(NSString *)jionerIpone leftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rigthTitle leftBlock:(void(^)())leftBlock rightBlock:(void(^)())rightBlock dismissBlock:(void(^)())dismissBlock;

@end
