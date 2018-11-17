//
//  MyViewTableViewCell.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/6/26.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "NetWork_myWelfareTicket.h"

#define TitleImgWidth    ScreenWidth*((CGFloat)170/640)  //根据效果图，左侧图像与屏幕宽度的比例计算TitleImgWidth

#define MyWelfareTicketCellHeight     TitleImgWidth+20  //评论title的高度

@interface MyWelfareTicketCell_temp : UITableViewCell


@property (nonatomic, strong)MyWelfareTicketModel * listModel;
@property (copy, nonatomic) void (^inviteUser)(NSString *userId);



- (void)dataBind:(MyWelfareTicketModel*)model;

+ (NSString*) cellId;


@end
