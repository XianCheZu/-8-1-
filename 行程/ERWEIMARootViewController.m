
//
//  TempViewController.m
//  QRCode_Demo
//
//  Created by 沈红榜 on 15/11/17.
//  Copyright © 2015年 沈红榜. All rights reserved.
//

#import "ERWEIMARootViewController.h"
#import "SHBQRView.h"
#import "AllPages.pch"
@interface ERWEIMARootViewController ()<SHBQRViewDelegate>
{
    SHBQRView *qrView;
}
@end

@implementation ERWEIMARootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    qrView = [[SHBQRView alloc] initWithFrame:self.view.bounds];
    qrView.delegate = self;
    [self.view addSubview:qrView];
    
    UIButton* btnn=[UIButton buttonWithType:UIButtonTypeCustom];
    btnn.backgroundColor=Color(18, 152, 233)//蓝
    btnn.titleLabel.font=[UIFont systemFontOfSize:Height(14)];
    btnn.layer.cornerRadius=3;
    [btnn setTitle:@"取消" forState:UIControlStateNormal];
    btnn.frame=CGRectMake(ScreenWidth/2-Height(150)/2, ScreenHeight-3*Height(30), Height(150), Height(35));
    [btnn addTarget:self action:@selector(cente:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnn];
    
}
-(void)cente:(UIButton *)view
{
    [self qrView:qrView ScanResult:nil];
}

- (void)qrView:(SHBQRView *)view ScanResult:(NSString *)result {
   

    [self dismissViewControllerAnimated:YES completion:^
     {
          [view stopScan];
         
         [[NSNotificationCenter defaultCenter] postNotificationName:@"do" object:result];
         
     }];
}

@end
