//
//  NewProjectView.h
//  JrLoanMobile
//
//  Created by admin on 16/1/19.
//  Copyright © 2016年 Junrongdai. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum
{
    XLGC_ChildrenPark = 0,
    XLGC_SmallShop = 1,
    XLGC_LocalFood= 2,
    XLGC_CountryMovie = 3
} XLGC_Type;


@interface GCItemModel : IObjcJsonBase

@property (nonatomic, copy) NSString *itemIcon;//功能图标
@property (nonatomic, copy) NSString *itemTitle;//功能名称
@property (nonatomic, copy) NSString *itemContent;//功能描述
@property (nonatomic, assign) XLGC_Type gcType;//是否校验登录



@end



@interface XLGCBodyView : UIView

-(void)reloadWithSource:(NSArray*)source;



@property(nonatomic,strong) void (^blockClcik)(GCItemModel *item);


@end
