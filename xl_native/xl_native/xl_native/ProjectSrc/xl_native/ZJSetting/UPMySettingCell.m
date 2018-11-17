//
//  ActiviteyCell.m
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "UPMySettingCell.h"

@implementation UPMySettingModel

@end

@implementation UPMySettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.contentView.backgroundColor = defaultBgColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.viewBg = [UIButton buttonWithType:UIButtonTypeCustom];
    self.viewBg.size = [UIView getSize_width:ScreenWidth height:UPMySettingCellHeight];
    self.viewBg.origin = [UIView getPoint_x:0 y:0];
    [self.viewBg setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.viewBg setBackgroundColor:defaultBgColor forState:UIControlStateHighlighted];
    [self.viewBg addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.viewBg];
    

    self.imageVeiwIcon = [[UIImageView alloc]init];
    self.imageVeiwIcon.size = [UIView getSize_width:UPMySettingCellHeight-30 height:UPMySettingCellHeight-30];
    self.imageVeiwIcon.origin = [UIView getPoint_x:(self.viewBg.height - self.self.imageVeiwIcon.height)/2
                                                 y:(self.viewBg.height - self.self.imageVeiwIcon.height)/2];
    self.imageVeiwIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self.viewBg addSubview:self.imageVeiwIcon];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(self.imageVeiwIcon.right+10, self.viewBg.height - 1,
                                                              self.viewBg.width-self.imageVeiwIcon.right,1)];
    line.backgroundColor = RGBAlphaColor(236, 237, 241, 1);
    [self.viewBg addSubview:line];
    
    self.labelName = [[UILabel alloc]init];
    self.labelName.size = [UIView getSize_width:150 height:20];
    self.labelName.origin = [UIView getPoint_x:self.imageVeiwIcon.right+10
                                             y:(self.viewBg.height-self.labelName.height)/2];
    self.labelName.font = [UIFont defaultFontWithSize:14];
    [self.viewBg addSubview:self.labelName];
    
    self.labelDetail = [[UILabel alloc]init];
    self.labelDetail.size = [UIView getSize_width:200 height:18];
    self.labelDetail.origin = [UIView getPoint_x:self.imageVeiwIcon.right+10 y:self.labelName.bottom+5];
    self.labelDetail.font = [UIFont defaultFontWithSize:12];
    self.labelDetail.textColor = RGBAlphaColor(108, 98, 85, 1);
    //[self.viewBg addSubview:self.labelDetail];
}
- (void)fillDataWithModel:(UPMySettingModel *)model{
    self.listModel = model;
    
    self.imageVeiwIcon.image = [UIImage imageNamed:model.image];
    self.labelName.text = model.name;
    self.labelDetail.text = model.des;
    
    self.viewBg.backgroundColor = [UIColor redColor];
}

- (void)cellClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(btnClicked:cell:)]) {
        [self.delegate btnClicked:sender cell:self];
    } else {
        NSLog(@"代理没响应，快开看看吧");
    }
}




@end
