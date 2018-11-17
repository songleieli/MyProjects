//
//  TBFilesDetailVc.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/26.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "TBFilesDetailVc.h"

@interface TBFilesDetailVc ()

@end

@implementation TBFilesDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"档案详情";
    [self setupWebView];
}
- (void)setupWebView
{
    NSString *url = [WCBaseContext sharedInstance].h5Server;
    url = [NSString stringWithFormat:@"%@/portrait/content/main.html?familyId=%@",url,self.familyId];
    
    [self.webDefault loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    [self.webDefault mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navBackGround.mas_bottom);
        make.bottom.equalTo(self.view).offset(-KTabBarHeightOffset_New);
    }];
}

@end
