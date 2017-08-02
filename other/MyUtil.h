//
//  MyUtil.h

//
//  Created by jiaxianyue on 15/7/28.
//  Copyright (c) 2015年 jiaxianyue. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface MyUtil : NSObject
//创建按钮的方法
+ (UIButton *)createBtnFrame:(CGRect)frame image:(NSString *)imageName selectedImage:(NSString *)selectedImageName target:(id)target action:(SEL)action;

//创建label的方法
+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font color:(UIColor *)color;

//创建UIImageView的方法
+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName;

//创建文本输入框
+ (UITextField *)createTextFieldFrame:(CGRect)frame placeHolder:(NSString *)placeHolder;
@end
