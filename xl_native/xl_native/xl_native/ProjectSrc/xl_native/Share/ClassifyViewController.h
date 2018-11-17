//
//  ClassifyViewController.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/29.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "BaseViewController.h"


@protocol selectedClassityDelegate <NSObject>


-(void)selectedClassityDelegate:(NSString *)name and:(NSString *)tepyID andTag:(NSInteger)tag;



@end


@interface ClassifyViewController : ZJBaseViewController

@property(nonatomic, weak)id<selectedClassityDelegate>delegate;

@property (nonatomic, weak) NSString* model;//NEIGHBOR_INTERACTION 交互 NEIGHBOR_ACTIVITY 活动

@property(nonatomic,assign) BOOL  typeFromViewController;
@property(nonatomic,assign) NSInteger tag;

@end
