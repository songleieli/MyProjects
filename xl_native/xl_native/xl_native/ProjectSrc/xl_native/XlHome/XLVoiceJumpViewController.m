//
//  XLVoiceJumpViewController.m
//  xl_native
//
//  Created by MAC on 2018/9/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLVoiceJumpViewController.h"

@interface XLVoiceJumpViewController ()

@property (copy, nonatomic) NSString *url;

@end

@implementation XLVoiceJumpViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)initNavTitle{
    
    self.isNavBackGroundHiden  = YES;
}

- (instancetype)initWithModel:(VoiceJumpModel *)model
{
    self = [super init];
    if (self) {
        self.url = model.url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webDefault loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
}
-(void)reLoadHomeUrl{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)voicePurchase:(NSString*)myCallBack
{
    CMPZjLifeMobileRootViewController *vc = (CMPZjLifeMobileRootViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    [vc.suspensionBtn voiceSingleClick:VoiceSingleClickTypePurchase];
//    
//    __weak __typeof(self) weakSelf = self;
//    
//    vc.suspensionBtn.voiceResultAction = ^(VoiceJumpModel *model) {
//        if (model.voiceSingleClickType == 1) {// 语音购买
//            [weakSelf voiceCallBack:model.filePathMp3 voiceContent:model.voiceText myCallBack:myCallBack];
//        } else {
//            [[NSNotificationCenter defaultCenter] postNotificationName:NSNotificationXLVoiceResultPushVC object:model];
//        }
//    };
}

@end
