//
//  PublishSuccessView.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/8/4.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "PublishSuccessView.h"

@interface PublishSuccessView()

@property (nonatomic, strong)UILabel* titleLalbe;
@property (nonatomic ,strong)UILabel* detail;

@end


@implementation PublishSuccessView


- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self initialization];
    }
    
    
    return self;
    
    
}
- (instancetype)init{
    
    self = [super init];
    
    if(self){
        
        [self initialization];
    }
    
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    
    if(self){
        
        [self initialization];
    }
    
    
    return self;
}

- (void)initialization
{
    
    [self setupUi];
}

#pragma mark - 懒加载

- (UILabel *)titleLalbe{
    
    if (!_titleLalbe) {
        
        _titleLalbe = [[UILabel alloc] init];
        
        
        _titleLalbe.font = [UIFont defaultFontWithSize:MasScale_1080(48)];
        
        
        _titleLalbe.textColor = RGBFromColor(0xf58521);
        
        
        _titleLalbe.text = @"发布成功";
        
    }
    
    
    return _titleLalbe;
    
}

-(void)titleLabelF{
    
    [_titleLalbe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(MasScale_1080(68));
        
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    
    
}

- (UILabel *)detail{
    
    
    if (!_detail) {
        
        _detail = [[UILabel alloc] init];
        
        
        _detail.font = [UIFont defaultFontWithSize:MasScale_1080(39)];
        
        
        _detail.textColor = SubtitleColor;
        
        
        _detail.text = @"恭喜您获得3积分";
        
    }
    
    
    return _detail;
    
}

- (void)detailF{
    
    [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(MasScale_1080(-68));
        
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    
}

#pragma mark - setUi

- (void)setupUi{
    
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.titleLalbe];
    
    [self addSubview:self.detail];
    
    [self titleLabelF];
    
    //    [self detailF];
    
}

#pragma mark - 加载数据


#pragma mark - 实例方法

- (void)dataBind:(PublishSuccessViewModel*)model{
    
    
    
    NSString* str = [NSString stringWithFormat:@"恭喜您获得 %@ 积分",model.integral];
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:RGBFromColor(0xf58521)
     
                          range:NSMakeRange(6, str.length -9)];
    
    self.detail.attributedText = AttributedStr;
    
    
    self.titleLalbe.text = model.title;
    
    
    
    [self detailF];
     self.titleLalbe.hidden = NO;
    
    if (model.publishSuccessType == PublishSuccessNointegral) {
        
        self.detail.hidden = YES;
    }else if (model.publishSuccessType == PublishSuccessNotitle) {
        
        self.detail.hidden = NO;
        
        self.titleLalbe.hidden = YES;
        
        [_detail mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.center.mas_equalTo(self);
        }];
        
        
    } else{
        
        self.detail.hidden = NO;
    }
    
}

#pragma mark - 类方法

#pragma mark - delegate


@end


@implementation PublishSuccessViewModel



@end
