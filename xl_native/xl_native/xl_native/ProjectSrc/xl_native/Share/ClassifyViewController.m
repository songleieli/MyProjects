
//
//  FenLeiViewController.m
//  CMPLjhMobile
//
//  Created by qianfeng on 16/5/29.
//  Copyright © 2016年 CMP_Ljh. All rights reserved.
//

#import "ClassifyViewController.h"

#import "NetWork_findAllTagList.h"

@interface ClassifyViewController ()

@property(nonatomic,strong) NSMutableArray * titelArrayActivity;

@property(nonatomic,strong) NSMutableArray * titelArrayTopic;

@property(nonatomic,strong) UIScrollView *scrollBg;
@property (nonatomic,strong) UIButton * btnSelected;



@end

@implementation ClassifyViewController

-(NSMutableArray *)titelArrayActivity{
    
    if (_titelArrayActivity == nil) {
        
        _titelArrayActivity = [[NSMutableArray alloc]init];
        
    }
    return _titelArrayActivity;
}

-(NSMutableArray *)titelArrayTopic{
    
    if (_titelArrayTopic == nil) {
        _titelArrayTopic = [[NSMutableArray alloc]init];
    }
    return _titelArrayTopic;
}

-(void)initNavTitle{
    self.isNavBackGroundHiden  = NO;
    self.title = @"分类";
    self.navBackGround.backgroundColor = [UIColor whiteColor];
    
    [self.btnLeft setImage:[UIImage imageNamed:@"gray_back"] forState:UIControlStateNormal];

    
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBackGround.height-1, ScreenWidth, 1)];
    lineView.backgroundColor = RGBFromColor(0xd4d4d4);
    [self.navBackGround addSubview:lineView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self  initRequest];
    
    
    
    self.scrollBg = [[UIScrollView alloc]init];
    self.scrollBg.size = self.view.bounds.size;
    self.scrollBg.origin = [UIView getPoint_x:0 y:self.navBackGround.bottom];
    self.scrollBg.contentSize = CGSizeMake(self.scrollBg.width, 1000);
    
    [self.view addSubview:self.scrollBg];
    
    
}
-(void)initRequest{
    
    NetWork_findAllTagList * findAllTagList = [[NetWork_findAllTagList alloc]init];
    findAllTagList.model = self.model;
    [findAllTagList startPostWithBlock:^(FindAllTagListResponse * result, NSString *msg, BOOL finished) {
        
        if (finished) {
            
            for (FindAllTagDataModel * findAllTagDataModel  in result.data) {
                
                if ([findAllTagDataModel.belongModel.trim isEqualToString:@"NEIGHBOR_ACTIVITY"]) {
                    
                    [self.titelArrayActivity addObject:findAllTagDataModel];
                    
                }
                if ([findAllTagDataModel.belongModel.trim isEqualToString:@"NEIGHBOR_INTERACTION"]) {
                    
                    [self.titelArrayTopic addObject:findAllTagDataModel];
                }
            }
            if (self.typeFromViewController) {
                [self createUIWith:self.titelArrayActivity];
            }else{
                [self createUIWith:self.titelArrayTopic];
            }
        }
    }];
}

-(void)createUIWith:(NSMutableArray *)arr{
    
    //计算当前页的高度
    NSInteger rowCount = 3;
    NSInteger modular = arr.count%rowCount;
    NSInteger row = arr.count/rowCount;
    
    //计算当前页的高度
    CGFloat with = self.view.width/rowCount; //正方形，高等于宽
    CGFloat height = sizeScale(45);
    
    if(modular > 0){
        row = row+1;
    }
    
    for(int i=0; i<row;i++){
        for(int j=0;j<rowCount;j++){
            
            if((i*rowCount + j) < arr.count){
                UIView *viewSub = [[UIView alloc]init];
                viewSub.size = [UIView getSize_width:with height:height];
                viewSub.origin = [UIView getPoint_x:j*with y:i*height];
                [self.scrollBg addSubview:viewSub];
                
                
                UIButton *btnMark = [UIButton buttonWithType:UIButtonTypeCustom];
                btnMark.tag = i*rowCount + j + 1;
                btnMark.size = [UIView getScaleSize_width:70 height:28];
                btnMark.origin = [UIView getPoint_x:(viewSub.width - btnMark.width)/2
                                                  y:(viewSub.height - btnMark.height)/2];
                [btnMark.layer setMasksToBounds:YES];
                [btnMark.layer setCornerRadius:4.0]; //设置矩形四个圆角半径
                [btnMark.layer setBorderWidth:1.0]; //边框宽度
                [btnMark setTitleColor:RGBFromColor(0x9294a5) forState:UIControlStateNormal];
                [btnMark setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                btnMark.layer.borderColor=RGBFromColor(0x9294a5).CGColor;

                if (btnMark.tag == self.tag) {
                    btnMark.selected = YES;
                    btnMark.layer.borderColor = [UIColor redColor].CGColor;
                    _btnSelected = btnMark;
                }
                [btnMark setTitle:[arr[i*rowCount + j] tagName] forState:UIControlStateNormal];
                btnMark.titleLabel.font = [UIFont systemFontOfSize:12];
                
                [btnMark addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                [viewSub addSubview:btnMark];
                
                
                
            }
        }
        
    }
    self.scrollBg.contentSize = CGSizeMake(self.scrollBg.width, row * sizeScale(50));

    
    
}

-(void)btnClick:(UIButton *)btn {
//    [GlobalFunc event:@"event_click_type_item"];
    btn.layer.borderColor = [UIColor redColor].CGColor;

        if (_btnSelected == btn) {
            
            btn.selected = !btn.isSelected;
            if (!btn.selected) {
                btn.borderColor = RGBFromColor(0x9294a5);
            }else{
                btn.borderColor = [UIColor redColor];
            }

        }else{

            btn.selected = YES;
            _btnSelected.selected = NO;
            _btnSelected.borderColor = RGBFromColor(0x9294a5);
            btn.borderColor = [UIColor redColor];
            _btnSelected = btn;

           
        }
    
    if (self.typeFromViewController) {
        
       FindAllTagDataModel * findAllTagDataModel = [self.titelArrayActivity objectAtIndex:btn.tag - 1];
        NSLog(@"%ld",(long)btn.tag);
        NSLog(@"%@",findAllTagDataModel.id);
        if ([self.delegate respondsToSelector:@selector(selectedClassityDelegate:and:andTag:)]) {
            
            if (_btnSelected.selected) {
                [ self.delegate selectedClassityDelegate:btn.titleLabel.text and:findAllTagDataModel.id andTag:btn.tag];
            }else{
                [ self.delegate selectedClassityDelegate:nil and:nil andTag:0];
            }

//            [ self.delegate selectedClassityDelegate:btn.titleLabel.text and:findAllTagDataModel.id andTag:_btnSelected.tag];
        
        }
//        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        FindAllTagDataModel * findAllTagDataModel = [self.titelArrayTopic objectAtIndex:btn.tag - 1];
        if ([self.delegate respondsToSelector:@selector(selectedClassityDelegate:and:andTag:)]) {
            if (_btnSelected.selected) {
                [ self.delegate selectedClassityDelegate:btn.titleLabel.text and:findAllTagDataModel.id andTag:btn.tag];
            }else{
                [ self.delegate selectedClassityDelegate:nil and:nil andTag:0];
            }
        }
    }
    [self.navigationController popViewControllerAnimated:YES];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
