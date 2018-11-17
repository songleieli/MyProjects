//
//  XLAboutViewController.m
//  xl_native
//
//  Created by MAC on 2018/10/11.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLAboutViewController.h"

@interface XLAboutViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *version;
@property (weak, nonatomic) IBOutlet UIWebView *web;

@end

@implementation XLAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"关于";

    [self setupUI];
}
- (void)setupUI
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    self.version.text = info[@"CFBundleShortVersionString"];
    
    self.icon.image = [UIImage imageNamed:@"AppIcon"];
    viewBorderRadius(self.icon, 10, 0, [UIColor clearColor]);
    
    self.web.scrollView.bounces = NO;
    self.web.scrollView.showsVerticalScrollIndicator = NO;
    self.web.scrollView.showsHorizontalScrollIndicator = NO;
    
    NetWork_aboutUs *net = [[NetWork_aboutUs alloc] init];
    net.contentType = @"ABOUT_US";
    [net startPostWithBlock:^(AboutUsRespone *result, NSString *msg, BOOL finished) {
        NSDictionary *dict = (NSDictionary *)result.data;
        NSString *str = dict[@"content"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.web loadHTMLString:str baseURL:nil];
        });
    }];
}

@end
