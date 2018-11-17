//
//  NeighboursLabelView.m
//  CMPLjhMobile
//
//  Created by Liyanjun on 2017/8/14.
//  Copyright © 2017年 CMP_Ljh. All rights reserved.
//

#import "XLFlollowUserView.h"

@implementation LableFlollowModel


@end


@interface XLFlollowUserView()


@property (nonatomic, strong)UIButton *doneBtn;//完成按钮
@property (nonatomic ,strong)NSMutableArray *dataSource; //数据源
@property (nonatomic ,strong)NSMutableArray *selectArray; //选择的tag

@property (nonatomic, strong)UIView *headView;//完成按钮
@property (nonatomic, strong)UIScrollView *scrollView;//滚动调

@end

@implementation XLFlollowUserView


- (UIView *)headView{
    
    if (!_headView) {
        _headView = [UIButton buttonWithType:UIButtonTypeCustom];
        _headView.top = 0;
        _headView.left = 0.0;
        _headView.width = self.width;
        _headView.height = 90;
        _headView.backgroundColor = [UIColor clearColor];
        
        /** 添加关注 */
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.font = [UIFont defaultFontWithSize:17];
        titleLable.textColor = XLColorMainLableAndTitle;
        titleLable.left = 15;
        titleLable.top = 21;
        titleLable.height = 20;
        titleLable.width = 150;
        titleLable.text = @"添加关注";
        [_headView addSubview:titleLable];
        
        /** 时间 */
        UILabel *titleTwoLabel = [[UILabel alloc] init];
        titleTwoLabel.font = [UIFont systemFontOfSize:15];
        titleTwoLabel.textColor = XLColorMainClassTwoTitle;
        titleTwoLabel.left = titleLable.left;
        titleTwoLabel.top = titleLable.bottom + 15;
        titleTwoLabel.height= 12;
        titleTwoLabel.width = 150;
        titleTwoLabel.text = @"关注好友 更多精彩";
        [_headView addSubview:titleTwoLabel];
        
        UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0,_headView.height - 0.7 , _headView.width, 0.7)];
        lineView.backgroundColor = XLColorCutLine;
        [_headView addSubview:lineView];
    }
    return _headView;
}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.top = _headView.bottom;
        _scrollView.left = 0.0;
        _scrollView.width = self.width;
        _scrollView.height = self.height - _headView.height*2;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.scrollEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;


    }
    return _scrollView;
}

- (UIView *)doneBtn{
    
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneBtn.size = [UIView getSize_width:self.width - 80 height:50];
        _doneBtn.top = self.scrollView.bottom+20;
        _doneBtn.left = 40;
        _doneBtn.layer.cornerRadius = _doneBtn.height/2;
        _doneBtn.layer.masksToBounds = YES;
        _doneBtn.titleLabel.font=[UIFont defaultFontWithSize:16];
        [_doneBtn setTitle:@"我选好了" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_doneBtn setBackgroundColor:XLColorMainPart forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(btnDoneClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}


- (NSMutableArray *)selectArray{

    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc] init];
    }
    return _selectArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.headView];
        [self addSubview:self.scrollView];
        [self addSubview:self.doneBtn];
    }
    return self;
}


#pragma mark - 加载数据

-(void)dataBind:(NSMutableArray*)dataSource{
    if (dataSource.count == 0) {
        return;
    }
    
    [self.selectArray removeAllObjects];
    self.dataSource = dataSource;
    [self.scrollView removeAllSubviews];

    CGFloat top = 0.0f; //初始top位置
    for(int i=0; i<self.dataSource.count;i++){

        UserModel *model = [self.dataSource objectAtIndex:i];
        
        UIView *viewCell = [[UIView alloc] init];
        viewCell.frame = CGRectMake(0,top,self.width,66);
        viewCell.alpha = 1;
        [self.scrollView addSubview:viewCell];
        
        UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0,viewCell.height - 0.7 , viewCell.width, 0.7)];
        lineView.backgroundColor = XLColorCutLine;
        [viewCell addSubview:lineView];
        
        //icon
        UIImageView *imageIconView = [[UIImageView alloc]init];
        imageIconView.size = [UIView getSize_width:45 height:45];
        imageIconView.origin = [UIView getPoint_x:15 y:(viewCell.height - imageIconView.height)/2];
        imageIconView.contentMode =  UIViewContentModeScaleAspectFill;
        [imageIconView sd_setImageWithURL:[NSURL URLWithString:model.userIcon] placeholderImage:[UIImage imageNamed:@"actitvtiyDefout"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSLog(@"error 是%ld",(long)error.code);
        }];
        imageIconView.layer.masksToBounds = YES;
        imageIconView.layer.cornerRadius = 4.0f;
        imageIconView.userInteractionEnabled = YES;
        [viewCell addSubview:imageIconView];
        
        
        /** 姓名 */
        UIButton *btnLable = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLable.tag = 90;
        btnLable.titleLabel.font = [UIFont defaultFontWithSize:16];
        btnLable.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btnLable.left = imageIconView.right + 15;
        btnLable.height = viewCell.height/2 - 10;
        btnLable.width = 150;
        btnLable.top = viewCell.height/2 - btnLable.height;
        [btnLable setTitle:model.nickName forState:UIControlStateNormal];
        [btnLable setTitleColor:XLColorMainLableAndTitle forState:UIControlStateNormal];
        [btnLable setTitleColor:XLColorMainPart forState:UIControlStateSelected];
        [viewCell addSubview:btnLable];
        
        /** 所在村 */
        UIButton *btnTwoLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        btnTwoLabel.tag = 91;
        btnTwoLabel.titleLabel.font = [UIFont defaultFontWithSize:14];
        btnTwoLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btnTwoLabel.left = btnLable.left;
        btnTwoLabel.top = btnLable.bottom;
        btnTwoLabel.height= btnLable.height;
        btnTwoLabel.width = 150;
        [btnTwoLabel setTitleColor:XLColorMainLableAndTitle forState:UIControlStateNormal];
        [btnTwoLabel setTitleColor:XLColorMainPart forState:UIControlStateSelected];
        [btnTwoLabel setTitle:model.communityName forState:UIControlStateNormal];
        [viewCell addSubview:btnTwoLabel];
        
        /** 赞按钮 */
        UIButton *btnChoose = [UIButton buttonWithType:UIButtonTypeCustom];
        btnChoose.tag = i;
        btnChoose.size = [UIView getSize_width:24 height:24];
        btnChoose.top = (viewCell.height-btnChoose.height)/2;
        btnChoose.left = viewCell.width - btnChoose.width - 15;
        [btnChoose setImage:[BundleUtil getCurrentBundleImageByName:@"user_follow_unselected"] forState:UIControlStateNormal];
        [btnChoose setImage:[BundleUtil getCurrentBundleImageByName:@"user_follow_selected"] forState:UIControlStateHighlighted];
        [btnChoose setImage:[BundleUtil getCurrentBundleImageByName:@"user_follow_selected"] forState:UIControlStateSelected];
        
        [btnChoose addTarget:self action:@selector(btnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [viewCell addSubview:btnChoose];

        //下一个cell的top
        top = top+viewCell.height;
    }
    
    CGFloat content = top;
    if(self.scrollView.height >= top ){
        content = self.scrollView.height+1;
    }
    self.scrollView.contentSize = [UIView getSize_width:self.width height:content];
}


-(void)btnSelectClick:(UIButton*)btn{
    
    btn.selected = !btn.selected;
    
    
    UIView *viewCell = [btn superview];
    UIButton *btnLable = [viewCell viewWithTag:90];
    UIButton *btnTwoLabel = [viewCell viewWithTag:91];
    
    btnLable.selected = btn.selected;
    btnTwoLabel.selected = btn.selected;

    
    UserModel *model = [self.dataSource objectAtIndex:btn.tag];
    if(btn.selected){
        [self.selectArray addObject:model];
    }
    else{
        [self.selectArray removeObject:model];
    }
}

-(void)btnDoneClick:(UIButton*)btn{
    
    if(self.didSelectUserBlock){
        //self.did
        
        self.didSelectUserBlock(self.selectArray);
    }
    
    
    NSLog(@"-------------");
}



@end
