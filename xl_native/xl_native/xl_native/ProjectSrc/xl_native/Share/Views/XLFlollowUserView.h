//
//  NeighboursLabelView.h
//  CMPLjhMobile
//
//  Created by 宋磊磊 on 2017/8/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Network_followTopicList.h"


@interface LableFlollowModel: NSObject

@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong) NSArray *lables;

@end


@interface XLFlollowUserView : UIView

@property (nonatomic, copy) void(^didSelectUserBlock)(NSMutableArray *selectArray);//点击按钮的回调

- (void)dataBind:(NSMutableArray*)dataSource;


@end
