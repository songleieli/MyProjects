//
//  CLPlayerMaskView.h
//  CLPlayerDemo
//
//  Created by JmoVxia on 2017/2/24.
//  Copyright © 2017年 JmoVxia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetWork_findAllTagList.h"



@interface SwitchPlayerSelectTagView : UIView

/*滚动条*/
@property(nonatomic,strong) UIScrollView * scrollView;

/**数据源*/
@property (strong, nonatomic) NSMutableArray *source;

/*初始化方法*/
-(instancetype)initWithFrame:(CGRect)frame;

/*加载数据*/
-(void)reloadWithSource:(NSMutableArray*)source selectModel:(FindAllTagDataModel *)selectModel;

/* Block 应该声明成 weak，声明成Strong 或者 copy 会导致循环引用， SwitchPlayerViewController 中的dealloc 不被调用*/
@property(nonatomic,copy) void (^selectBlockClcik)(FindAllTagDataModel *item);

@end
