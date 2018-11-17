//
//  MyViewTableViewCell.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/26.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "InvitationCell.h"



static NSString* const ViewTableViewCellId=@"InvitationCellId";

@interface InvitationCell()

@property (nonatomic, strong)UILabel *lableName;//姓名
@property (nonatomic, strong)UILabel *lableVillage;//姓名
@property (nonatomic,strong)UIImageView* imgView;//图片
@property (nonatomic, strong)UIView* lineView;//底部横线
@property (nonatomic, strong)UIButton* btnInvitation;//邀请按钮
//@property (nonatomic, strong)UIImageView *narrowImg;//箭头

@end




@implementation InvitationCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier{
    
    self=[super initWithStyle: style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupUi];
    }
    return self;
}


#pragma mark - 懒加载

- (UIImageView *)imgView{
    
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.size = [UIView getScaleSize_width:sizeScale(30) height:sizeScale(30)];
        _imgView.origin = [UIView getPoint_x:sizeScale(20) y:(InvitationCellHeight - _imgView.height)/2];
        
        //圆角
        CALayer * imageViewLayer = [_imgView layer];
        [imageViewLayer setMasksToBounds:YES];
        [imageViewLayer setCornerRadius:_imgView.width/2];
        _imgView.userInteractionEnabled = YES;
        
        //test
//        _imgView.backgroundColor = [UIColor redColor];
    }
    return _imgView;
}



- (UILabel*)lableName{

    if (!_lableName) {
        _lableName = [[UILabel alloc] init];
        _lableName.font = [UIFont defaultFontWithSize:MasScale_1080(39)];
        _lableName.textColor = RGBFromColor(0x333333);
        _lableName.size = [UIView getSize_width:150 height:sizeScale(30)/2];
        _lableName.origin = [UIView getPoint_x:self.imgView.right+15
                                              y:self.imgView.top];
        
        //test
//        _lableName.backgroundColor = [UIColor blueColor];
    }
    return _lableName;
}

- (UILabel*)lableVillage{
    
    if (!_lableVillage) {
        _lableVillage = [[UILabel alloc] init];
        _lableVillage.font = [UIFont defaultFontWithSize:MasScale_1080(39)];
        _lableVillage.textColor = RGBFromColor(0x666666);
        _lableVillage.size = [UIView getSize_width:150 height:sizeScale(30)/2];
        _lableVillage.left = self.imgView.right+15;
        _lableVillage.bottom = self.imgView.bottom;
        
        //test
//        _lableVillage.backgroundColor = [UIColor greenColor];
    }
    return _lableVillage;
}

- (UIButton *)btnInvitation{
    //narrow_gray
    if (!_btnInvitation) {
        
        //btnInvitation = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_arrow"]];
        _btnInvitation = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnInvitation.size = [UIView getSize_width:80 height:32];
        _btnInvitation.origin = [UIView getPoint_x:ScreenWidth - _btnInvitation.width - 15
                                                 y:(InvitationCellHeight - _btnInvitation.height)/2];
        
        [_btnInvitation setTitle:@"邀请" forState:UIControlStateNormal];
        _btnInvitation.titleLabel.font = [UIFont defaultFontWithSize:18];
        [_btnInvitation setTitleColor:XLColorMainPart forState:UIControlStateNormal];
        [_btnInvitation setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_btnInvitation setBackgroundColor:XLColorMainPart forState:UIControlStateHighlighted];
        _btnInvitation.layer.cornerRadius = 5;
        _btnInvitation.layer.borderWidth = 1.0f;
        _btnInvitation.layer.borderColor = XLColorMainPart.CGColor;
        [_btnInvitation addTarget:self action:@selector(inviteClick) forControlEvents:UIControlEventTouchUpInside];
        _btnInvitation.layer.masksToBounds = YES;
    }
    return _btnInvitation;
}

- (UIView *)lineView{
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor =  defaultJawBgColor;
        _lineView.size = [UIView getSize_width:ScreenWidth height:1];
        _lineView.origin = [UIView getPoint_x:0 y:InvitationCellHeight-_lineView.height];
    }
    return _lineView;
    
}


#pragma mark - 设置UI

- (void)setupUi{
    
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.lableName];
    [self.contentView addSubview:self.lableVillage];
    [self.contentView addSubview:self.btnInvitation];
    [self.contentView addSubview:self.lineView];
}


#pragma mark - 实例方法
- (void)dataBind:(AaddressBookModel*)model{
    
    self.listModel = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.societyUserIcon]
                    placeholderImage:[UIImage imageNamed:@"user_default_icon"]];
    self.lableName.text = model.societyNickName;
    self.lableVillage.text = model.communityName;
    //self.lineView.hidden = !model.isShowLine;
    
    if (model.everEntryStatus == 1) {
        self.btnInvitation.hidden = YES;
    } else {
        self.btnInvitation.hidden = NO;
    }
}


- (void)inviteClick {
    if (self.inviteUser) {
        self.inviteUser(self.listModel.societyUserId);
    }
}

#pragma mark - 类方法
+ (NSString*) cellId{
    return ViewTableViewCellId;
}


@end


