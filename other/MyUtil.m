//
//  MyUtil.m
//
//  Created by jiaxianyue on 15/7/28.
//  Copyright (c) 2015年 jiaxianyue. All rights reserved.
//

#import "MyUtil.h"

@implementation MyUtil

//创建按钮
+ (UIButton *)createBtnFrame:(CGRect)frame image:(NSString *)imageName selectedImage:(NSString *)selectedImageName target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    
    if (imageName) {
        UIImage *image=[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [btn setImage:image forState:UIControlStateNormal];
    }
    
    if (selectedImageName) {
        UIImage *selectedImage=[[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [btn setImage:selectedImage forState:UIControlStateSelected];
    }
    
    if (target && action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

//创建标签
+ (UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font color:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (title) {
        label.text = title;
    }
    
    if (textAlignment) {
        label.textAlignment = textAlignment;
    }
    
    if (font) {
        label.font=font;
    }
    
    if (color) {
        label.textColor=color;
    }
    
    return label;
    
}

//创建UIImageView的方法
+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:frame];
    imageview.image = [UIImage imageNamed:imageName];
    
    //开启用户交互
    imageview.userInteractionEnabled = YES;
    
    return imageview;
    
}

//创建文本输入框
//创建UITextField的方法
+(UITextField *)createTextFieldFrame:(CGRect)frame placeHolder:(NSString *)placeHolder
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = placeHolder;
    
    return textField;
    
}

@end
