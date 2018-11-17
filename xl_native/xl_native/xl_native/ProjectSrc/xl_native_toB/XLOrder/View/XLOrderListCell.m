//
//  XLOrderListCell.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/24.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "XLOrderListCell.h"

@implementation XLOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];

    viewBorderRadius(self.icon, 22.5, 0, [UIColor clearColor]);
}
- (void)setModel:(OrderListModel *)model
{
    self.title.text = model.userName;
    self.desc.text = model.communityName;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.userIcon]];
}
- (IBAction)voiceClick:(id)sender {
    if (self.voiceBtnclick) {
        self.voiceBtnclick();
    }
}
- (void)setUserListModel:(UserListModel *)userListModel {
    self.title.text = userListModel.masterName;
    self.desc.text = userListModel.communityName;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:userListModel.icon]];
    self.rightImg.alpha = 0;
}

@end
