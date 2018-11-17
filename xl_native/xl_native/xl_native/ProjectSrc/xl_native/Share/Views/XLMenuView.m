//
//  XLMenuView.m
//  xl_native
//
//  Created by MAC on 2018/10/10.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLMenuView.h"

@interface XLMenuView ()

@end

@implementation XLMenuView

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor clearColor];
}
- (IBAction)btnClick:(UIButton *)sender {
    NSInteger num = sender.tag - 1000;
    if (self.select) {
        self.select(num);
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
