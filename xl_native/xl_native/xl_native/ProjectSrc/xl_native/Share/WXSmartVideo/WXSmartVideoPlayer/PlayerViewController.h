//
//  MBPlaySmartVideoViewController.h
//  SmartVideo
//
//  Created by yindongbo on 17/1/5.
//  Copyright © 2017年 Nxin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CLPlayerView.h"
#import "UIView+CLSetRect.h"


@interface PlayerViewController : UIViewController


@property (nonatomic, copy) NSString *videoUrlString;
@property (nonatomic,weak) CLPlayerView *playerView;


@end
