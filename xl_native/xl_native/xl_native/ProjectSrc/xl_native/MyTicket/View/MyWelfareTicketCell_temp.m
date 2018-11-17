//
//  MyViewTableViewCell.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/26.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "MyWelfareTicketCell_temp.h"



static NSString* const ViewTableViewCellId=@"InvitationCellId";

@interface MyWelfareTicketCell_temp()


@property (nonatomic,strong)UIImageView* titleImg;//图片
@property (nonatomic,strong)UIImageView* overTimeImg;//过期图片

@property (nonatomic,strong)UIImageView* rightImg;//左侧图片
@property (nonatomic, strong)UIImageView* lineVerticalView;//右侧虚线

@property (nonatomic, strong)UILabel *lableEqualsPrice;//等额价值
@property (nonatomic, strong)UILabel *lableDescribes;  //用途

@property (nonatomic, strong)UILabel *lableTitle;//标题
@property (nonatomic, strong)UILabel *lableUsePlatform;//使用平台
@property (nonatomic, strong)UILabel *lableUseTime;//有效期
@property (nonatomic, strong)UILabel *lableUseNow;//立即使用

@end




@implementation MyWelfareTicketCell_temp


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier{
    
    self=[super initWithStyle: style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupUi];
    }
    return self;
}


#pragma mark - 懒加载

//背景图
- (UIImageView *)titleImg{
    
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] init];
        _titleImg.size = [UIView getSize_width:TitleImgWidth height:TitleImgWidth];
        _titleImg.origin = [UIView getPoint_x:15 y:(MyWelfareTicketCellHeight - _titleImg.height)/2];
        
    }
    return _titleImg;
}
//过期图片
- (UIImageView *)overTimeImg{
    
    if (!_overTimeImg) {
        _overTimeImg = [[UIImageView alloc] init];
        _overTimeImg.size = [UIView getSize_width:TitleImgWidth-20 height:TitleImgWidth-20];
        _overTimeImg.origin = [UIView getPoint_x:ScreenWidth - _overTimeImg.width -20
                                               y:(MyWelfareTicketCellHeight - _overTimeImg.height)/2];
    }
    return _overTimeImg;
}

- (UIImageView *)rightImg{
    
    if (!_rightImg) {
        
        CGFloat scale = (CGFloat)430/173;
        
        _rightImg = [[UIImageView alloc] init];
        _rightImg.size = [UIView getSize_width:TitleImgWidth*scale height:TitleImgWidth];
        _rightImg.origin = [UIView getPoint_x:_titleImg.right y:(MyWelfareTicketCellHeight - _titleImg.height)/2];
        _rightImg.image = [UIImage imageNamed:@"组 323"];
    }
    return _rightImg;
}

//文字内容
- (UILabel*)lableEqualsPrice{

    if (!_lableEqualsPrice) {
        _lableEqualsPrice = [[UILabel alloc] init];
        _lableEqualsPrice.font = [UIFont defaultFontWithSize:16];
        _lableEqualsPrice.textColor = [UIColor whiteColor];
        _lableEqualsPrice.size = [UIView getSize_width:self.titleImg.width height:25];
        _lableEqualsPrice.left = 0;
        _lableEqualsPrice.textAlignment = NSTextAlignmentCenter;

        _lableEqualsPrice.top = self.titleImg.height/2-_lableEqualsPrice.height;

        _lableEqualsPrice.left = 0;


        //test
        //_lableEqualsPrice.backgroundColor = [UIColor blueColor];
    }
    return _lableEqualsPrice;
}
- (UILabel*)lableDescribes{
    
    if (!_lableDescribes) {
        _lableDescribes = [[UILabel alloc] init];
        _lableDescribes.font = [UIFont defaultFontWithSize:16];
        _lableDescribes.textColor = [UIColor whiteColor];
        _lableDescribes.size = [UIView getSize_width:self.titleImg.width height:25];
        _lableDescribes.left = 0;
        _lableDescribes.top = self.titleImg.height/2;
        _lableDescribes.textAlignment = NSTextAlignmentCenter;
        //test
        //_lableDescribes.backgroundColor = [UIColor greenColor];
    }
    return _lableDescribes;
}


- (UILabel*)lableTitle{
    
    if (!_lableTitle) {
        _lableTitle = [[UILabel alloc] init];
        _lableTitle.font = [UIFont defaultFontWithSize:16];
        _lableTitle.textColor = XLColorMainLableAndTitle;
        _lableTitle.size = [UIView getSize_width:self.lableUsePlatform.width height:25];
        _lableTitle.left = 20;
        _lableTitle.top = self.lableUsePlatform.top-_lableTitle.height;
        _lableTitle.textAlignment = NSTextAlignmentLeft;
        //test
//        _lableTitle.backgroundColor = [UIColor greenColor];
    }
    return _lableTitle;
}

- (UILabel*)lableUsePlatform{
    
    if (!_lableUsePlatform) {
        _lableUsePlatform = [[UILabel alloc] init];
        _lableUsePlatform.font = [UIFont defaultFontWithSize:13];
        _lableUsePlatform.textColor = XLColorMainClassTwoTitle;
        _lableUsePlatform.size = [UIView getSize_width:self.rightImg.width-20-25 height:25];
        _lableUsePlatform.left = 20;
        _lableUsePlatform.top = (self.rightImg.height - _lableUsePlatform.height)/2;
        _lableUsePlatform.textAlignment = NSTextAlignmentLeft;
        //test
//        _lableUsePlatform.backgroundColor = [UIColor redColor];
    }
    return _lableUsePlatform;
}

- (UILabel*)lableUseTime{
    
    if (!_lableUseTime) {
        _lableUseTime = [[UILabel alloc] init];
        _lableUseTime.font = [UIFont defaultFontWithSize:13];
        _lableUseTime.textColor = XLColorMainClassTwoTitle;
        _lableUseTime.size = [UIView getSize_width:self.lableUsePlatform.width height:25];
        _lableUseTime.left = 20;
        _lableUseTime.top = self.lableUsePlatform.bottom;
        _lableUseTime.textAlignment = NSTextAlignmentLeft;
        //test
        //_lableUseTime.backgroundColor = [UIColor greenColor];
    }
    return _lableUseTime;
}

- (UIImageView *)lineVerticalView{
    
    if (!_lineVerticalView) {
        
        CGFloat scale = (CGFloat)3/276;
        
        _lineVerticalView = [[UIImageView alloc] init];
        _lineVerticalView.size = [UIView getSize_width:self.rightImg.height*scale height:self.rightImg.height];
        _lineVerticalView.origin = [UIView getPoint_x:self.lableUsePlatform.right y:0];
        _lineVerticalView.image = [UIImage imageNamed:@"组 325"];
    }
    return _lineVerticalView;
    
}

- (UILabel *)lableUseNow{
    
    if (!_lableUseNow) {
        
        CGFloat scale = (CGFloat)12/65;

        _lableUseNow = [[UILabel alloc] init];
        _lableUseNow.size = [UIView getSize_width:self.rightImg.height*scale height:self.rightImg.height];
        _lableUseNow.origin = [UIView getPoint_x:self.lableUsePlatform.right+4 y:0];
        _lableUseNow.textColor = XLColorMainPart;
        _lableUseNow.text = @"立\n即\n使\n用";
        _lableUseNow.font = [UIFont defaultFontWithSize:14];
        _lableUseNow.textAlignment = NSTextAlignmentCenter;
        _lableUseNow.numberOfLines = 4; ///相当于不限制行数
    }
    return _lableUseNow;
}


#pragma mark - 设置UI

- (void)setupUi{
    
    self.contentView.backgroundColor = XLColorBackgroundColor;
    
    [self.contentView addSubview:self.titleImg];
    [self.contentView addSubview:self.rightImg];
    [self.contentView addSubview:self.overTimeImg];
    [self.contentView bringSubviewToFront:self.overTimeImg];
    
    [self.titleImg addSubview:self.lableEqualsPrice];
    [self.titleImg addSubview:self.lableDescribes];
    
    [self.rightImg addSubview:self.lableTitle];
    [self.rightImg addSubview:self.lableUsePlatform];
    [self.rightImg addSubview:self.lableUseTime];
    
    [self.rightImg addSubview:self.lineVerticalView];
    [self.rightImg addSubview:self.lableUseNow];

}


#pragma mark - 实例方法
- (void)dataBind:(MyWelfareTicketModel*)model{
    
    self.listModel = model;
    
    self.lableEqualsPrice.text = model.equalsPrice;
    self.lableDescribes.text = model.describes;
    self.lableTitle.text = model.title;
    self.lableUsePlatform.text = [NSString stringWithFormat:@"使用平台：%@",model.usePlat];
    self.lableUseTime.text = [NSString stringWithFormat:@"有效期至：%@",model.limitDate];
    
     ///< -1，可兑换，0使用过，1未使用过，2过期
    if([model.isused isEqualToString:@"-1"]){ //可兑换
        self.titleImg.image = [UIImage imageNamed:@"组 324"];
        self.lableUseNow.hidden = NO;
        self.overTimeImg.hidden = YES;
    }
    else if([model.isused isEqualToString:@"0"]){ //使用过
        self.titleImg.image = [UIImage imageNamed:@"组 326"];
        self.overTimeImg.image = [UIImage imageNamed:@"组 328"];
        self.overTimeImg.hidden = NO;
        self.lableUseNow.hidden = YES;
    
    }
    else if([model.isused isEqualToString:@"1"]){ //未使用过
        self.titleImg.image = [UIImage imageNamed:@"组 324"];
        self.lableUseNow.hidden = NO;
        self.overTimeImg.hidden = YES;
    }
    else if([model.isused isEqualToString:@"2"]){ //过期
        self.titleImg.image = [UIImage imageNamed:@"组 326"];
        self.lableUseNow.hidden = YES;
        self.overTimeImg.image = [UIImage imageNamed:@"组 327"];
        self.overTimeImg.hidden = NO;
    }
    
}


- (void)inviteClick {
//    if (self.inviteUser) {
//        self.inviteUser(self.listModel.societyUserId);
//    }
}

#pragma mark - 类方法
+ (NSString*) cellId{
    return ViewTableViewCellId;
}


@end


