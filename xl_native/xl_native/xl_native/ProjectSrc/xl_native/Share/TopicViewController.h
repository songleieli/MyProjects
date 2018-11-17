//
//  TopicViewController.h
//  CMPLjhMobile
//
//  Created by iOS开发 on 16/5/26.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "BaseTableMJViewController.h"
#import "ZJCustomTabBarLjhTableViewController.h"

#import "NetWork_addFollow.h"
#import "XLFlollowUserView.h"

#import "MyFansViewController.h"
#import "MyAttentionViewController.h"
#import "InvitationViewController.h"


typedef enum : NSUInteger {
    TopicViewControllerTypeDefault = 0,
    TopicViewControllerTypeUserInfo = 5, // 个人信息页面
    TopicViewControllerTypeHotTopic = 6 // 热门话题页面
    
} TopicViewControllerType;

@interface TopicViewController : ZJCustomTabBarLjhTableViewController

@property (copy, nonatomic) NSString *userId;///< 个人信息id
@property (copy, nonatomic) NSString *hotTopicId;///< 热门话题id
@property (assign, nonatomic) TopicViewControllerType topicViewControllerType;

@property (copy, nonatomic) NSString *topicType; ///< 个人信息id

/*
 关注用户
 */
@property (copy, nonatomic) UIButton *maskView;  //关注背景
@property (copy, nonatomic) XLFlollowUserView *flollowUserView;  //关注背景


-(void)loadNewData;
- (void)publish;//发布页面

@end
