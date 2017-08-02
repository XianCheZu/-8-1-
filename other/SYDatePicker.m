//
//  SYDatePicker.m
//  DatePickerDemo
//
//  Created by Apple on 16/3/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SYDatePicker.h"

@implementation SYDatePicker

- (void)showInView:(UIView *)view withFrame:(CGRect)frame andDatePickerMode:(UIDatePickerMode)mode{
    self.frame = frame;
    self.backgroundColor = [UIColor whiteColor];
    
    if(!self.picker){
        self.picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 30)];
    }
    
    self.picker.datePickerMode = mode;
    [self.picker addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.picker];
    
     btnDone = [UIButton buttonWithType:UIButtonTypeSystem];
    btnDone.frame = CGRectMake(frame.size.width-100-10,frame.size.height-30-10, 100, 30);
    [btnDone setTitle:@"时间筛选" forState:UIControlStateNormal];
//     btnDone.tintAdjustmentMode=NSTextAlignmentRight;
    [btnDone addTarget:self action:@selector(pickDone) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnDone];
    
     all_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    all_btn.frame = CGRectMake(10,frame.size.height-30-10, 100, 30);
//    all_btn.tintAdjustmentMode=NSTextAlignmentLeft;
    [all_btn setTitle:@"显示全部车辆" forState:UIControlStateNormal];
    [all_btn addTarget:self action:@selector(ALL) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:all_btn];
    
    [view addSubview:self];
    
    self.frame = CGRectMake(0,-kScreen_Width, kScreen_Width, 0);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = frame;
    }];
}
-(void)ALL
{
    if (![self.picker respondsToSelector:@selector(valueChanged:)]) {
        
        [self.delegate picker:self.picker ValueChanged:nil];
        
    }
     [btnDone removeFromSuperview];
     [all_btn removeFromSuperview];
    
    [self dismiss];
}
- (void)pickDone {
    
    
    if (![self.picker respondsToSelector:@selector(valueChanged:)]) {
        [self.delegate picker:self.picker ValueChanged:self.picker.date];
       
    }
    [btnDone removeFromSuperview];
    [all_btn removeFromSuperview];
    
    [self dismiss];
}

- (void)dismiss{
    [UIView animateWithDuration:0.4 animations:^{
         self.frame = CGRectMake(0, -kScreen_Width, kScreen_Width, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)valueChanged:(UIDatePicker *)picker{
    if([self.delegate respondsToSelector:@selector(picker:ValueChanged:)]){
//        [self.delegate picker:picker ValueChanged:picker.date];
    }
}

@end
