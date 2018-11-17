//
//  DeliverArticleViewController.h
//  CMPLjhMobile
//
//  Created by 刘欣 on 16/5/27.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "BaseViewController.h"
#import "TZImagePickerController.h"
#import "SDPhotoBrowser.h"
//#import "MyCommunityController.h"

@interface DeliverArticleViewController : ZJBaseViewController<UIActionSheetDelegate,SDPhotoBrowserDelegate>

//@property (nonatomic,strong) FindListModel * findListModel;

@property (nonatomic,copy) NSString * name;
@property (nonatomic, copy) NSString *videoUrll;

@property (nonatomic, copy) NSString *topicType; //主题类型，topicType：vido(视频) img(图片)
@property (nonatomic, strong) UIView *maskView;


@end
