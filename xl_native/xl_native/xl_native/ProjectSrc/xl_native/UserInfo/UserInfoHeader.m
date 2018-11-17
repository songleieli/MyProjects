//
//  UserInfoHeader.m
//  xl_native
//
//  Created by MAC on 2018/9/29.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "UserInfoHeader.h"


@implementation UserInfoHeader

+ (instancetype)shareView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"UserInfoHeader" owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = YES;
    viewBorderRadius(self.icon, 40, 0, [UIColor clearColor]);
}
- (void)setupUI:(HimInfoModel *)model 
{
    self.himInfoModel = model;
    self.userName.text = model.nickName;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.userIcon]];
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:model.userIcon]];
    self.home.text = [NSString stringWithFormat:@"家乡:%@",model.attentionCommunityName] ;
    self.sign.text = [NSString stringWithFormat:@"签名:%@",model.selfIntroduction] ;
    
    [self.btnPublish setTitle:[NSString stringWithFormat:@"发布:%@",model.topicCount] forState:UIControlStateNormal];
    [self.btnFans setTitle:[NSString stringWithFormat:@"粉丝:%@",model.followedCount] forState:UIControlStateNormal];
    [self.btnFollowList setTitle:[NSString stringWithFormat:@"关注:%@",model.followerCount] forState:UIControlStateNormal];
    
    
    /*
     *设置button 按钮
     */
    [self.btnFollow setBackgroundColor:RGBAlphaColor(252, 117, 123, 1) forState:UIControlStateNormal];
    [self.btnFollow setBackgroundColor:[UIColor grayColor] forState:UIControlStateSelected];
    [self.btnFollow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnFollow setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.btnFollow.layer setMasksToBounds:YES];
    [self.btnFollow.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [self.btnFollow setTitle:@"关注" forState:UIControlStateNormal];
    [self.btnFollow setTitle:@"已关注" forState:UIControlStateSelected];

    if(self.himInfoModel.isAttention){
        self.btnFollow.selected = YES;
    }
    else{
        self.btnFollow.selected = NO;
    }
    
    //如果是自己，隐藏关注按钮
    if([self.himInfoModel.userId isEqualToString:[GlobalData sharedInstance].loginDataModel.userId]){//
        self.btnFollow.hidden = YES;
    }
    
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.bounds;
    [self insertSubview:visualEffectView aboveSubview:self.bgImg];
}

-(IBAction)btnfllowClick:(UIButton*)sender{
    
    
    if(!sender.selected){ //关注
        NetWork_addFollow *request = [[NetWork_addFollow alloc] init];
        request.followedId = self.himInfoModel.userId;
        request.token = [GlobalData sharedInstance].loginDataModel.token;
        [request startPostWithBlock:^(AddFollowResponse *result, NSString *msg, BOOL finished) {
            NSLog(@"------");
            
            if(finished){
                self.btnFollow.selected = YES;
            }
        }];
    }
    else{ //取消关注
        NetWork_delFollow *request = [[NetWork_delFollow alloc] init];
        request.followedId = self.himInfoModel.userId;
        request.token = [GlobalData sharedInstance].loginDataModel.token;
        [request startPostWithBlock:^(id result, NSString *msg, BOOL finished) {
            if(finished){
                self.btnFollow.selected = NO;
            }
        }];
    }
}

-(IBAction)btnPublishClick:(UIButton*)sender{
    
    if(self.publishClickBlock){
        self.publishClickBlock();
    }
}

-(IBAction)btnFansClick:(UIButton*)sender{
    
    if(self.fansClickBlock){
        self.fansClickBlock();
    }
}

-(IBAction)btnFollowListClick:(UIButton*)sender{
    
    if(self.followListClickBlock){
        self.followListClickBlock();
    }
}





@end
