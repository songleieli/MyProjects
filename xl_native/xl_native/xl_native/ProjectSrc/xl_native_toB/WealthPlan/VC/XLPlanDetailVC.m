//
//  XLPlanDetailVC.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/25.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "XLPlanDetailVC.h"

@interface XLPlanDetailVC ()

@property (strong, nonatomic) PlantingPlanModel *plantingPlanModel;

@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondViewH;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *familyInfo;
@property (weak, nonatomic) IBOutlet UILabel *landArea;
@property (weak, nonatomic) IBOutlet UILabel *mainCrop;
@property (weak, nonatomic) IBOutlet UILabel *houseArea;
@property (weak, nonatomic) IBOutlet UILabel *buildYear;
@property (weak, nonatomic) IBOutlet UILabel *depositBank;
@property (weak, nonatomic) IBOutlet UILabel *depositAmount;
@property (weak, nonatomic) IBOutlet UILabel *isLoan;
@property (weak, nonatomic) IBOutlet UILabel *classify;
@property (weak, nonatomic) IBOutlet UILabel *muarea;
@property (weak, nonatomic) IBOutlet UILabel *machineCost;
@property (weak, nonatomic) IBOutlet UILabel *pesticideCost;
@property (weak, nonatomic) IBOutlet UILabel *seedlingsCost;
@property (weak, nonatomic) IBOutlet UILabel *bakeCost;
@property (weak, nonatomic) IBOutlet UILabel *fertilizerCost;
@property (weak, nonatomic) IBOutlet UILabel *landCost;
@property (weak, nonatomic) IBOutlet UILabel *cost;
@property (weak, nonatomic) IBOutlet UILabel *netincome;
@property (weak, nonatomic) IBOutlet UILabel *totalincome;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@end

@implementation XLPlanDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"计划详情";
    self.top.constant = CGRectGetMaxY(self.navBackGround.frame) + KViewStartTopOffset_New;
    
    [self loadData];
}
- (void)loadData
{
    NetWork_plantingPlan *request = [[NetWork_plantingPlan alloc] init];
    request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
    request.id = self.planId;
    request.type = self.type;
    [request startPostWithBlock:^(PlantingPlanRespone *result, NSString *msg, BOOL finished) {
        if (finished) {
            PlantingPlanModel *model = result.data;
            [self setupUI:model];
        }
    }];
}
- (void)setupUI:(PlantingPlanModel *)model
{
    self.plantingPlanModel = model;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.image]];

    NSArray *familyInfo = [model.familyInfo componentsSeparatedByString:@"，"];
    self.name.text = [familyInfo firstObject];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:familyInfo];
    [arr removeObjectAtIndex:0];
    self.familyInfo.text = [arr componentsJoinedByString:@"，"];
    
    self.landArea.text = [NSString stringWithFormat:@"自有土地：%@",model.property.landArea];
    self.mainCrop.text = [NSString stringWithFormat:@"种植种类：%@",model.property.mainCrop];
    self.houseArea.text = [NSString stringWithFormat:@"房屋面积：%@",model.property.houseArea] ;
    self.buildYear.text = [NSString stringWithFormat:@"建造年份：%ld",(long)model.property.buildYear];
    self.depositAmount.text = [NSString stringWithFormat:@"存款金额：%@",model.property.depositAmount];
    self.isLoan.text = [NSString stringWithFormat:@"贷款情况：%@",model.property.isLoan];
    self.depositBank.text = [NSString stringWithFormat:@"存款银行：%@",model.property.depositBank];
    
    
    if (self.type == 3) {
        self.secondViewH.constant = 10;
        self.secondView.alpha = 0;
    } else {
        self.classify.text = [NSString stringWithFormat:@"种植种类：%@",model.mplan.classify];
        self.muarea.text = [NSString stringWithFormat:@"预计承包种类：%@",model.mplan.muarea];
        self.machineCost.text = [NSString stringWithFormat:@"机械投入：%ld万元",(long)model.cost.machineCost];
        self.pesticideCost.text = [NSString stringWithFormat:@"农药投入：%ld万元",(long)model.cost.pesticideCost];
        self.seedlingsCost.text = [NSString stringWithFormat:@"育苗投入：%ld万元",(long)model.cost.seedlingsCost];
        self.bakeCost.text = [NSString stringWithFormat:@"烘烤投入：%ld万元",(long)model.cost.bakeCost];
        self.fertilizerCost.text = [NSString stringWithFormat:@"肥料地膜投入：%ld万元",(long)model.cost.fertilizerCost];
        self.landCost.text = [NSString stringWithFormat:@"土地流转投入：%ld万元",(long)model.cost.landCost];
        self.cost.text = [NSString stringWithFormat:@"年成本：%@",model.cplan.cost] ;
        self.netincome.text = [NSString stringWithFormat:@"年净收入：%@",model.cplan.netincome];
        self.totalincome.text = [NSString stringWithFormat:@"预计年收入：%@",model.cplan.totalincome];
    }
    [self.phoneBtn setTitle:[NSString stringWithFormat:@" %ld",(long)model.mobile] forState:UIControlStateNormal];
}
- (IBAction)phoneClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%ld",(long)self.plantingPlanModel.mobile]]];
}


@end
