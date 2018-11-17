//
//  MyWelfareTicketCell.h
//  xl_native
//
//  Created by MAC on 2018/10/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWork_myWelfareTicket.h"


NS_ASSUME_NONNULL_BEGIN

#define MyWelfareTicketCellHeight     sizeScale(50)  //评论title的高度


@interface MyWelfareTicketCell : UITableViewCell

@property (strong, nonatomic) MyWelfareTicketModel *model;

@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *cycleDesc;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *usePlat;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UIImageView *usedImg;
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@property (weak, nonatomic) IBOutlet UIImageView *lineImg;

@property (copy, nonatomic) dispatch_block_t btnClickBlock;

+ (NSString*) cellId;

@end

NS_ASSUME_NONNULL_END
