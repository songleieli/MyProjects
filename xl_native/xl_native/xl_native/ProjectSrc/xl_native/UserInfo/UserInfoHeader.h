//
//  UserInfoHeader.h
//  xl_native
//
//  Created by MAC on 2018/9/29.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetWork_addFollow.h"
#import "NetWork_delFollow.h"

@interface UserInfoHeader : UIView

+ (instancetype)shareView;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *btnFollow; //关注按钮
@property (weak, nonatomic) IBOutlet UIButton *btnPublish; //发布按钮
@property (weak, nonatomic) IBOutlet UIButton *btnFans; //粉丝按钮
@property (weak, nonatomic) IBOutlet UIButton *btnFollowList; //关注列表按钮

@property (weak, nonatomic) IBOutlet UILabel *home;
@property (weak, nonatomic) IBOutlet UILabel *sign;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;

@property (strong, nonatomic) HimInfoModel *himInfoModel;


- (void)setupUI:(HimInfoModel *)model;

/*dispatch_block_t 简单的实现不带参数的回调函数*/
//@property (copy, nonatomic) dispatch_block_t followClickBlock; ///< 关注按钮
@property (copy, nonatomic) dispatch_block_t publishClickBlock; ///< 发布
@property (copy, nonatomic) dispatch_block_t fansClickBlock; ///< 粉丝
@property (copy, nonatomic) dispatch_block_t followListClickBlock; ///< 关注


@end
