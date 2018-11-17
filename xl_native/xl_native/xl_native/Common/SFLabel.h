//
//  SFLabel.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/5/17.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFLabel : UILabel
// 用来决定上下左右内边距，也可以提供一个借口供外部修改，在这里就先固定写死
@property (assign, nonatomic) UIEdgeInsets edgeInsets;
@end
