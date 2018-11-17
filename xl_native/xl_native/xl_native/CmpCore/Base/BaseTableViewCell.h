//
//  BaseCell.h
//  zf
//
//  Created by zhangfeng on 13-7-12.
//  Copyright (c) 2013年 zhangfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellDelegate;

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, weak) UIView *viewBottomLine;
@property (nonatomic, weak) id<CellDelegate> delegate;

- (void)cellClick:(id)sender;

@end

@protocol CellDelegate <NSObject>

- (void)btnClicked:(id)sender cell:(BaseTableViewCell *)cell;

@end
