//
//  MyViewTableViewCell.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/26.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "MyFansCell.h"



static NSString* const ViewTableViewCellId=@"MyFansCellId";

@interface MyFansCell()

@property (nonatomic, strong)UILabel *lableName;//姓名
@property (nonatomic, strong)UILabel *lableVillage;//姓名
@property (nonatomic,strong)UIImageView* imgView;//图片
@property (nonatomic, strong)UIView* lineView;//底部横线
@property (nonatomic, strong)UIImageView *narrowImg;//箭头

@end




@implementation MyFansCell


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
        _imgView.origin = [UIView getPoint_x:sizeScale(20) y:(MyFansCellHeight - _imgView.height)/2];
        
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

- (UIImageView *)narrowImg{
    //narrow_gray
    if (!_narrowImg) {
        _narrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_arrow"]];
        _narrowImg.size = [UIView getSize_width:9 height:13];
        _narrowImg.origin = [UIView getPoint_x:ScreenWidth - _narrowImg.width - 15
                                             y:(MyFansCellHeight - _narrowImg.height)/2];
    }
    return _narrowImg;
}

- (UIView *)lineView{
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor =  defaultJawBgColor;
        _lineView.size = [UIView getSize_width:ScreenWidth height:1];
        _lineView.origin = [UIView getPoint_x:0 y:MyFansCellHeight-_lineView.height];
    }
    return _lineView;
    
}


#pragma mark - 设置UI

- (void)setupUi{
    
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.lableName];
    [self.contentView addSubview:self.lableVillage];
    [self.contentView addSubview:self.narrowImg];
    [self.contentView addSubview:self.lineView];
}


#pragma mark - 实例方法
- (void)dataBind:(QueryFollowedModel*)model{
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.USER_ICON]
                    placeholderImage:[UIImage imageNamed:@"user_default_icon"]];
    self.lableName.text = model.USER_NAME;
    //self.lableVillage.text = model.USER_NAME;
    //self.lineView.hidden = !model.isShowLine;
}

#pragma mark - 类方法
+ (NSString*) cellId{
    return ViewTableViewCellId;
}


@end


