//
//  LaunchViewController.m
//  寒假项目
//
//  Created by 韩天旭 on 16/2/19.
//  Copyright © 2016年 韩天旭. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()
{
    UIImageView *_FirstImageV;
    UIImageView *_SecondImageV;
}
@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatImageV];
    [self Animation];
}
- (void)creatImageV{
    _SecondImageV = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _SecondImageV.contentMode = UIViewContentModeScaleAspectFill;
    _SecondImageV.image = [UIImage imageNamed:@"开始页2"];
    [self.view addSubview:_SecondImageV];
    
    _FirstImageV = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _FirstImageV.contentMode = UIViewContentModeScaleAspectFill;
    _FirstImageV.image = [UIImage imageNamed:@"首页动画"];
    [self.view addSubview:_FirstImageV];
}
- (void)Animation{
    [UIView animateWithDuration:2.f animations:^{
        _FirstImageV.alpha = 0.f;
        _SecondImageV.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [_FirstImageV removeFromSuperview];
         [UIView animateWithDuration:0.5f animations:^{
             _SecondImageV.alpha = 0.f;
         } completion:^(BOOL finished) {
             [_SecondImageV removeFromSuperview];
             [self.view removeFromSuperview];
         }];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
