//
//  XLVoiceOrderView.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/25.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "XLVoiceOrderView.h"

@interface XLVoiceOrderView ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *village;
@property (weak, nonatomic) IBOutlet UIImageView *commodityImg;
@property (weak, nonatomic) IBOutlet UILabel *commodity;
@property (weak, nonatomic) IBOutlet UILabel *voice;
@property (weak, nonatomic) IBOutlet UILabel *voiceStatus;

@end

@implementation XLVoiceOrderView

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [self setupUI];
}
- (void)setupUI
{
    OrderListModel *model = self.model;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.userIcon]];
    [self.commodityImg sd_setImageWithURL:[NSURL URLWithString:model.good.goodImage]];
    self.name.text = model.userName;
    self.village.text = [NSString stringWithFormat:@"%@ %@",model.communityName,[NSDate compareCurrentTime: [NSDate cTimestampFromString:model.creationDate format:@"yyyy-MM-dd HH:mm:ss"]]] ;
    self.commodity.text = [NSString stringWithFormat:@"品名：%@\n数量：%ld",model.good.goodName,(long)model.goodNum];
    self.commodity.numberOfLines = [self.commodity.text length];
    
    self.voice.text = model.voiceContent;
    
    [self playerVoice];
}
- (IBAction)ordersClick {
    NetWork_orders *request = [[NetWork_orders alloc] init];
    request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
    request.id = [NSString stringWithFormat:@"%ld",(long)self.model.id];
    request.type = 1;
    [request startPostWithBlock:^(OrdersRespone *result, NSString *msg, BOOL finished) {
        if (finished) {
            [SVProgressHUD showSuccessWithStatus:msg];
            [self dismissViewControllerAnimated:YES completion:^{
                if (self.reloadTable) {
                    self.reloadTable();
                }
            }];
        }
    }];
}
- (IBAction)playClick {
    self.voiceStatus.text = @"语音播放中";
    [self playerVoice];
}
- (IBAction)closeOrder {
    NetWork_orders *request = [[NetWork_orders alloc] init];
    request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
    request.id = [NSString stringWithFormat:@"%ld",(long)self.model.id];
    request.type = 2;
    [request startPostWithBlock:^(OrdersRespone *result, NSString *msg, BOOL finished) {
        if (finished) {
            [SVProgressHUD showSuccessWithStatus:msg];
            [self dismissViewControllerAnimated:YES completion:^{
                if (self.reloadTable) {
                    self.reloadTable();
                }
            }];
        }
    }];
}

- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playerVoice
{
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.model.voiceUrl]];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    [self.view.layer addSublayer:layer];
    
    [player play];
}
- (void)moviePlayDidEnd
{
    self.voiceStatus.text = @"再听一次";
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
