//
//  PulishCell.m
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/30.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "PulishCell.h"

@implementation PulishCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    CGFloat high = sizeScale((self.height - 30)/2);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _communityLabel = [[UILabel alloc] init];
    _communityLabel.frame = CGRectMake(10, high, 50, 40);
    _communityLabel.textColor = [UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1.0];
    [self.contentView addSubview:_communityLabel];
    
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.frame = CGRectMake(ScreenWidth - 300, high,250, 40);
    _descriptionLabel.textAlignment = NSTextAlignmentRight;
    _descriptionLabel.textColor = [UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:1.0];
    [self.contentView addSubview:_descriptionLabel];
    
    
}


@end
