//
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/10.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "TBBaseViewController.h"

@interface TBBaseViewController ()

@end

@implementation TBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
}

-(void)initNavTitle{
    /*
     *重载父类中的方法，初始化NavTitle
     */
    [super initNavTitle];
    
    [[UINavigationBar appearance] setBarTintColor:defaultZjBlueColor];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont defaultFontWithSize:18];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}


- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}



@end
