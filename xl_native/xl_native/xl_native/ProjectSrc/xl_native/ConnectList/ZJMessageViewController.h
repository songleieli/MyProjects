//
//  ZJMessageViewController.h
//  CMPLjhMobile
//
//  Created by lei song on 2016/11/8.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "ZJCustomTabBarLjhTableViewController.h"
#import "ZJMessageDetailViewController.h"
#import "ZJMessageCell.h"

#import "ZJRenovationCheckViewController.h"
#import "ZJEquipmentCheckViewController.h"
#import "ZJMyRepairViewController.h"
#import "ZJSecurityCheckViewController.h"
#import "ZJReadingsCheckSearchViewController.h"


@interface ZJMessageViewController : ZJCustomTabBarLjhTableViewController<CellDelegate,DeleteClickDelegate>




@property(nonatomic,strong) NSMutableArray * listDataArray;//列表的数据
@property(nonatomic,strong) ZjGetMessageListModel *deleModel;//列表的数据

@property(nonatomic,assign) BOOL isHidentabBar;
@property(nonatomic,assign) BOOL isShowBackBtn;

@property(nonatomic,copy) NSString *msgType;

-(void)refreshMsgList:(NSString*)pushType pushId:(NSString*)pushId;

-(void)jumpNoticeWithId:(NSString*)noticeId;



@end
