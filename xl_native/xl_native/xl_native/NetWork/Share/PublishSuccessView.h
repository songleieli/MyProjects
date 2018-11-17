//
//  PublishSuccessView.h
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/8/4.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    PublishSuccessHasintegral = 1,
    PublishSuccessNointegral=2,
    PublishSuccessNotitle=3
    
}  PublishSuccessType ;


@interface PublishSuccessViewModel : NSObject

@property (nonatomic,copy)NSString* integral;

@property (nonatomic,copy)NSString* title;

@property (nonatomic,assign)PublishSuccessType publishSuccessType;



@end

@interface PublishSuccessView : UIView


- (void)dataBind:(PublishSuccessViewModel*)model;
@end
