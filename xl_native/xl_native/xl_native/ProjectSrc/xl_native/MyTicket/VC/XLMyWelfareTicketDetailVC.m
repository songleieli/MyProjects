//
//  XLMyWelfareTicketDetailVC.m
//  xl_native
//
//  Created by MAC on 2018/10/19.
//  Copyright © 2018年 CMP_Ljh. All rights reserved.
//

#import "XLMyWelfareTicketDetailVC.h"
#import <CoreImage/CoreImage.h>

@interface XLMyWelfareTicketDetailVC ()

@property (weak, nonatomic) IBOutlet UIImageView *qrCode;
@property (weak, nonatomic) IBOutlet UIView *circel1;
@property (weak, nonatomic) IBOutlet UIView *circel2;
@property (weak, nonatomic) IBOutlet UIView *circel3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet UILabel *useCondition;
@property (weak, nonatomic) IBOutlet UILabel *useTime;
@property (weak, nonatomic) IBOutlet UILabel *usePlat;
@property (weak, nonatomic) IBOutlet UILabel *instruction;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@end

@implementation XLMyWelfareTicketDetailVC


-(void)initNavTitle{
    [super initNavTitle];
    self.title = @"我的福利券";
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.title = @"我的福利券";
    [self setupUI];
    
    [self QRcode];
}
- (void)setupUI
{
    viewBorderRadius(self.circel1, 4, 0, [UIColor clearColor]);
    viewBorderRadius(self.circel2, 4, 0, [UIColor clearColor]);
    viewBorderRadius(self.circel3, 4, 0, [UIColor clearColor]);

    self.top.constant = CGRectGetMaxY(self.navBackGround.frame) + KViewStartTopOffset_New;

    self.useCondition.text = self.model.useLimit;
    self.useTime.text = [NSString stringWithFormat:@"%@至%@",self.model.startDate,self.model.limitDate];
    self.usePlat.text = [NSString stringWithFormat:@"适用平台：%@",self.model.usePlat];
    self.instruction.text = [NSString stringWithFormat:@"使用方法：%@",self.model.useWay] ;
    self.detail.text = [NSString stringWithFormat:@"详细说明：%@",self.model.useDesc] ;
}

- (void)QRcode
{
    //二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    [filter setDefaults];
    
    NSString *string = self.model.barCode;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    [filter setValue:data forKey:@"inputMessage"];
    //获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    //将CIImage转换成UIImage,并放大显示
    self.qrCode.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:100.0];
    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
    self.qrCode.layer.shadowOffset = CGSizeMake(0, 0.5);//设置阴影的偏移量
    self.qrCode.layer.shadowRadius = 1;//设置阴影的半径
    self.qrCode.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影的颜色为黑色
    self.qrCode.layer.shadowOpacity = 0.3;
}

//改变二维码大小
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

@end
