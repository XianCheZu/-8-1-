//
//  LDCalendarView.h
//
//  Created by lidi on 15/9/1.
//  Copyright (c) 2015年 lidi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_RAT (SCREEN_WIDTH/320.0f)
#define INTTOSTR(intNum)         [@(intNum) stringValue]
#define Height(H) (H)/320.0*SCREEN_WIDTH
typedef void(^ParttimeComplete)(NSArray *result);

@interface LDCalendarView : UIView
@property (nonatomic, strong) NSArray        *defaultDates;
@property (nonatomic, copy) ParttimeComplete complete;
@property (nonatomic, strong)UIView  *contentBgView;
@property (nonatomic, strong)UILabel *titleLab;//标题
- (id)initWithFrame:(CGRect)frame;
- (void)show;
- (void)hide;
@end
