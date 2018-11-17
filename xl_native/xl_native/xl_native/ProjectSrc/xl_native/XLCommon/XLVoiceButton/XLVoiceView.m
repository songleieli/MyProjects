//
//  XLVoiceView.m
//  xl_native
//
//  Created by MAC on 2018/10/9.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLVoiceView.h"

@interface XLVoiceView ()

@end

@implementation XLVoiceView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:^{
        if (self.vcDismiss) {
            self.vcDismiss();
        }
    }];
}

@end
