//
//  AddressBookCell.m
//  xl_native
//
//  Created by MAC on 2018/10/10.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "AddressBookCell.h"

static NSString* const ViewTableViewCellId=@"InvitationCellId";


@implementation AddressBookCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    viewBorderRadius(self.icon, 23, 0, [UIColor clearColor]);
    viewBorderRadius(self.inviteBtn, 5, 1, RGBFromColor(0x0972DA));
}
- (void)setFansModel:(MyFansListModel *)fansModel
{
    _fansModel = fansModel;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:fansModel.USER_ICON]];
    self.name.text = fansModel.USER_NAME;
    self.desc.text = fansModel.communityName;
    
    self.inviteBtn.hidden = YES;
}
- (void)setModel:(AaddressBookModel *)model
{
    _model = model;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.societyUserIcon]];
    self.name.text = model.societyNickName;
    self.desc.text = model.communityName;
    
    if (model.everEntryStatus == 1) {
        self.inviteBtn.hidden = YES;
    } else {
        self.inviteBtn.hidden = NO;
    }
}

- (IBAction)inviteClick {
    if (self.inviteUser) {
        self.inviteUser(_model.societyUserId);
    }
}

@end
