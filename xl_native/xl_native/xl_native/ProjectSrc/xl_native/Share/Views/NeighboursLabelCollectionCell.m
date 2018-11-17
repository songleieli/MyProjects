//
//  NeighboursLabelCollectionCell.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/8/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NeighboursLabelCollectionCell.h"

static NSString* const CollectionCellId=@"NeighboursLabelCollectionCellId";

@interface NeighboursLabelCollectionCell()

@property (nonatomic, strong)UIView *containView;

@property (nonatomic, strong)UILabel *contentLable;


@end

@implementation NeighboursLabelCollectionCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


#pragma mark - 初始化

- (void)initialization{
    
    [self setupUi];
    
}


#pragma mark -- setupUi

- (void)setupUi{
    
    [self.contentView addSubview:self.containView];
    [self.contentView addSubview:self.contentLable];
    
    //[self containViewF];
    
//    make.height.mas_equalTo(MasScale_1080(102));
//
//    make.width.mas_equalTo(MasScale_1080(222));
    
    self.containView.height = 25;
    self.containView.width = 70;
    
    self.contentLable.size = [UIView getSize_width:self.containView.width height:25];
    
    self.contentLable.top = self.contentView.height - self.contentLable.height - self.contentLable.height;
    
    
    //[self contentLableF];
    
    //make.center.mas_equalTo(_containView);
}


#pragma mark - 懒加载

- (UILabel *)contentLable{
    
    
    if (!_contentLable) {
        _contentLable = [[UILabel alloc] init];
        
        _contentLable.font = [UIFont defaultFontWithSize:MasScale_1080(42)];
        
        _contentLable.textColor = RGBFromColor(0x454545);
        
        
        _contentLable.textAlignment = NSTextAlignmentCenter;
        
        
        
        
        
    }
    
    return _contentLable;
}

//- (void)contentLableF{
//
//    [_contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.center.mas_equalTo(_containView);
//
//
//    }];
//
//}



- (UIView *)containView{
    
    
    if (!_containView) {
        _containView = [[UIView alloc] init];
        
        _containView.backgroundColor = RGBFromColor(0xe7e7e7);
        
        
//        _containView.backgroundColor = [UIColor redColor];
        _containView.layer.masksToBounds = YES;
        _containView.layer.cornerRadius = MasScale_1080(10);
    }
    
    return _containView;
    
    
}


- (void)containViewF{
    
    
    [_containView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(MasScale_1080(0));
        
        make.height.mas_equalTo(MasScale_1080(102));
        
        make.width.mas_equalTo(MasScale_1080(222));
        
    }];
    
    
}


#pragma mark - 实例方法



- (void)dataBind:(NeighboursLabelCollectionCellModel *)model{
    
    
    self.contentLable.text = model.titleStr;
    
    if (model.isSelected) {
        self.contentLable.textColor = RGBFromColor(0xfd6f00);
    }else{
    
        self.contentLable.textColor = RGBFromColor(0x454545);
    }
    
}

#pragma mark - 类方法
+ (NSString *)registerCellID
{
    
    return CollectionCellId;
    
}




#pragma mark  - delegate


@end
@implementation NeighboursLabelCollectionCellModel



@end
