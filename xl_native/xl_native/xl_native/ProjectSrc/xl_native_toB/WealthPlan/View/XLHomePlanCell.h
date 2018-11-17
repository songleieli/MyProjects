//
//  XLHomePlanCell.h
//  xl_native_toB
//
//  Created by MAC on 2018/10/24.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const homePlanCellID = @"homePlanCellID";

NS_ASSUME_NONNULL_BEGIN

@interface XLHomePlanCell : UITableViewCell

@property (strong, nonatomic) HomePlanModel *model;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *time;


@end

NS_ASSUME_NONNULL_END
