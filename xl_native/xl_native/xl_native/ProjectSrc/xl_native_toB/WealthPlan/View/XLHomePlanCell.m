//
//  XLHomePlanCell.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/24.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "XLHomePlanCell.h"

@implementation XLHomePlanCell

- (void)setModel:(HomePlanModel *)model
{
    _model = model;
    
    self.title.text = model.name;
    self.desc.text = model.item;
    self.time.text = model.date;
    
    self.time.text = [NSDate compareCurrentTime: [NSDate obtainCurrentTimestampEnd:model.date]];
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.image]];
}
- (void)awakeFromNib {
    [super awakeFromNib];

    viewBorderRadius(self.icon, 22.5, 0, [UIColor clearColor]);
}

@end
