//
//  ScanQRcode.m
//  xl_native_toB
//
//  Created by MAC on 2018/10/25.
//  Copyright © 2018 CMP_Ljh. All rights reserved.
//

#import "ScanQRcode.h"
#import "XLMembershipWelfareVC.h"

@interface ScanQRcode ()

@end

@implementation ScanQRcode

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"扫一扫";
    
    _device = [ AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    _input = [ AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    _output = [[ AVCaptureMetadataOutput alloc]init];
    [ _output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _session = [[ AVCaptureSession alloc]init];
    [ _session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([ _session canAddInput:self.input])
    {
        [ _session addInput:self.input];
    }
    if ([ _session canAddOutput:self.output])
    {
        [ _session addOutput:self.output];
    }
    
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    [ _output setRectOfInterest : CGRectMake (( 124 )/ ScreenHeight ,(( ScreenWidth - 220 )/ 2 )/ ScreenWidth , 220 / ScreenHeight , 220 / ScreenWidth )];
    
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.view.layer.bounds;

    [self.view.layer insertSublayer:_preview atIndex:0];
    
    //扫描框
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-(ScreenWidth-ScreenWidth*0.5f))/2,ScreenHeight*0.2f,ScreenWidth - ScreenWidth*0.5f,ScreenWidth-ScreenWidth*0.5f)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    upOrdown = NO;
    num =0;
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-(ScreenWidth-ScreenWidth*0.5f))/2,ScreenHeight*0.2f,ScreenWidth- ScreenWidth*0.5f,1)];
    
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    [ _session startRunning ];
}
#pragma mark - 上下动画
-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake((ScreenWidth-(ScreenWidth-ScreenWidth*0.5f))/2, ScreenHeight*0.2f+2*num, imageView.frame.size.width, 2);
        if (2*num > ScreenWidth-ScreenWidth*0.5f-5) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake((ScreenWidth-(ScreenWidth-ScreenWidth*0.5f))/2, ScreenHeight*0.2f+2*num, imageView.frame.size.width, 2);
        if (num == 2) {
            upOrdown = NO;
        }
    }
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:( AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] > 0 )
    {
        [ _session stopRunning ];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        _line.hidden = YES;
        
        [self loadData:stringValue];
    }
}

- (void)loadData:(NSString *)stringValue
{
    NSData *jsonData = [stringValue dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    NetWork_voucherMessage *request = [[NetWork_voucherMessage alloc] init];
    request.token = [GlobalData sharedInstance].adminLoginDataModel.token;
    request.voucher_ReceiveId = dict[@"voucherReceiveId"];
    
    [request startPostWithBlock:^(VoucherMessageRespone *result, NSString *msg, BOOL finished) {
        if (finished) {
            VoucherMessageModel *model = result.data;

            XLMembershipWelfareVC *vc = [[XLMembershipWelfareVC alloc] init];
            vc.model = model;
            vc.voucherReceiveId = dict[@"voucherReceiveId"];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:msg];
            [ _session startRunning ];
        }
    }];
}


@end
