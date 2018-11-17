//
//  CLPlayerMaskView.h
//  CLPlayerDemo
//
//  Created by JmoVxia on 2017/2/24.
//  Copyright © 2017年 JmoVxia. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MtHomeTopView : UIView

/*初始化方法*/
-(instancetype)initWithFrame:(CGRect)frame;

/**搜索按钮*/
@property (nonatomic,strong) UIButton *searchButton;

/**推荐按钮*/
@property (nonatomic,strong) UIButton *recommendButton;

/**城市按钮*/
@property (nonatomic,strong) UIButton *cityButton;

/**扫描按钮*/
@property (nonatomic,strong) UIButton *scanButton;

/**刷新按钮*/
@property (nonatomic,strong) UIButton *refreshButton;


@end
