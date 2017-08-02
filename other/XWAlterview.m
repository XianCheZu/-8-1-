//
//  XWAlterview.m
//  new
//
//  Created by chinat2t on 14-11-6.
//  Copyright (c) 2014年 chinat2t. All rights reserved.
//

#import "XWAlterview.h"
// 设置警告框的长和宽

#define Alertwidth 280.0f
#define Alertheigth 160.0f
#define XWtitlegap 15.0f
#define XWtitleofheigth 25.0f
#define XWSinglebuttonWidth 160.0f
//        单个按钮时的宽度
#define XWdoublebuttonWidth 70.0f
//        双个按钮的宽度
#define XWbuttonHeigth 30.0f
//        按钮的高度
#define XWbuttonbttomgap 10.0f
//        设置按钮距离底部的边距


@interface XWAlterview ()
{
    BOOL _leftLeave;
}

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIButton *leftbtn;
@property (nonatomic, strong) UIButton *rightbtn;
@property (nonatomic, strong) UIButton *backimageView;

@end

@implementation XWAlterview



+ (CGFloat)alertWidth
{
    return Alertwidth;
}

+ (CGFloat)alertHeight
{
    return Alertheigth;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(XWAlterview*)showmessage:(NSString *)message subtitle:(NSString *)subtitle cancelbutton:(NSString *)cancle
{
    XWAlterview *alert = [[XWAlterview alloc] initWithTitle:message contentText:subtitle leftButtonTitle:nil rightButtonTitle:cancle];
    [alert show];
    alert.rightBlock = ^() {
        NSLog(@"right button clicked");
    };
    alert.dismissBlock = ^() {
        NSLog(@"cancel button clicked");
    };
    return alert;
}


- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
{
    if (self = [super init]) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, XWtitlegap, Alertwidth, XWtitleofheigth)];
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        self.alertTitleLabel.textColor=[UIColor blackColor];
        [self addSubview:self.alertTitleLabel];
        
        CGFloat contentLabelWidth = Alertwidth - 16-20;
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake((Alertwidth - contentLabelWidth) * 0.5, XWtitlegap, contentLabelWidth, 100)];
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1];
        self.alertContentLabel.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:self.alertContentLabel];
        //        设置对齐方式
        self.alertContentLabel.textAlignment = self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        CGRect leftbtnFrame;
        CGRect rightbtnFrame;
        
        if (!leftTitle) {
            rightbtnFrame = CGRectMake((Alertwidth - XWSinglebuttonWidth) * 0.5, Alertheigth - XWbuttonbttomgap - XWbuttonHeigth, XWSinglebuttonWidth, XWbuttonHeigth);
            self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightbtn.frame = rightbtnFrame;
            
        }else {
            leftbtnFrame = CGRectMake((Alertwidth - 2 * XWdoublebuttonWidth - XWbuttonbttomgap) * 0.5, Alertheigth - XWbuttonbttomgap - XWbuttonHeigth, XWdoublebuttonWidth, XWbuttonHeigth);
            
            rightbtnFrame = CGRectMake(CGRectGetMaxX(leftbtnFrame) + XWbuttonbttomgap, Alertheigth - XWbuttonbttomgap - XWbuttonHeigth, XWdoublebuttonWidth, XWbuttonHeigth);
            self.leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftbtn.frame = leftbtnFrame;
            self.rightbtn.frame = rightbtnFrame;
        }
        
        
        [self.rightbtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftbtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftbtn.titleLabel.font = self.rightbtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.leftbtn setTitleColor:[UIColor colorWithRed:249/255.0 green:98/255.0 blue:104/255.0 alpha:1] forState:UIControlStateNormal];
        [self.rightbtn setTitleColor:[UIColor colorWithRed:82/255.0 green:203/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
        [self.leftbtn addTarget:self action:@selector(leftbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightbtn addTarget:self action:@selector(rightbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftbtn.layer.masksToBounds = self.rightbtn.layer.masksToBounds = YES;
        self.leftbtn.layer.cornerRadius = self.rightbtn.layer.cornerRadius = 3.0;
        self.leftbtn.layer.borderWidth=self.rightbtn.layer.borderWidth=1.0f;
        self.leftbtn.layer.borderColor=[UIColor colorWithRed:249/255.0 green:98/255.0 blue:104/255.0 alpha:1].CGColor;
        self.rightbtn.layer.borderColor=[UIColor colorWithRed:82/255.0 green:203/255.0 blue:255/255.0 alpha:1].CGColor;
        [self addSubview:self.leftbtn];
        [self addSubview:self.rightbtn];
        self.alertTitleLabel.text = title;
        self.alertContentLabel.text = content;
        //        UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [xButton setImage:[UIImage imageNamed:@"btn_close_normal.png"] forState:UIControlStateNormal];
        //        xButton.frame = CGRectMake(Alertwidth - 25, 0, 25, 25);
        //        [self addSubview:xButton];
        //        [xButton addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}
- (void)leftbtnclicked:(id)sender
{
    
    if (self.leftBlock) {
        self.leftBlock();
    }
    [self dismissAlert];
}

- (void)rightbtnclicked:(id)sender
{
    
    if (self.rightBlock) {
        self.rightBlock();
    }
    [self dismissAlert];
}
- (void)show
{   //获取第一响应视图视图
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5-50, Alertwidth, Alertheigth);
    self.alpha=0;
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (UIViewController *)appRootViewController
{
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperview
{
    [self.backimageView removeFromSuperview];
    self.backimageView = nil;
    UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5+50, Alertwidth, Alertheigth);
    
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        self.alpha=0;
    } completion:^(BOOL finished) {
        
        [super removeFromSuperview];
    }];
}
//添加新视图时调用（在一个子视图将要被添加到另一个视图的时候发送此消息）
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    //     获取根控制器
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backimageView) {
        self.backimageView = [[UIButton alloc] initWithFrame:topVC.view.bounds];
        self.backimageView.backgroundColor = [UIColor blackColor];
        self.backimageView.alpha = 0.4f;
        self.backimageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.backimageView addTarget:self action:@selector(backBtnn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //    加载背景背景图,防止重复点击
    [topVC.view addSubview:self.backimageView];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5, Alertwidth, Alertheigth);
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = afterFrame;
        self.alpha=1;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}
-(void)backBtnn
{
    [self dismissAlert];
}
@end


