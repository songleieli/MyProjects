//
//  NewProjectView.h
//  JrLoanMobile
//
//  Created by admin on 16/1/19.
//  Copyright © 2016年 Junrongdai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetWork_classifyVideo_list.h"
#import "VUILable.h"


@interface XLHomeFunctionView : UIView

-(void)reloadWithSource:(NSArray*)source dataLoadFinishBlock:(void(^)())dataLoadFinishBlock;

@property(nonatomic,strong) void (^zanClcik)(ListLoginModel *item,UIButton *btnZan,UILabel *labelZan);
@property(nonatomic,strong) void (^playVideoClcik)(ListLoginModel *item);

@end
