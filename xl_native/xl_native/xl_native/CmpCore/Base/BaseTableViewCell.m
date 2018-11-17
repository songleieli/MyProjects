//
//  BaseCell.m
//  zf
//
//  Created by zhangfeng on 13-7-12.
//  Copyright (c) 2013年 zhangfeng. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
