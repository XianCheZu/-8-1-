//
//  ZMCalendarCell.m
//  ZMCalendarPicker
//
//  Created by 朱敏 on 15/11/9.
//  Copyright © 2015年 Arron Zhu. All rights reserved.
//

#import "ZMCalendarCell.h"
#import "AllPages.pch"
@implementation ZMCalendarCell
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        UILabel *label = [[UILabel alloc] init];
        _dateLabel = label;
        CGFloat width = self.bounds.size.width;
        _dateLabel.layer.cornerRadius =4*width/5/2;
        _dateLabel.clipsToBounds = YES;
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
        [_dateLabel setFont:Font(13)];
        [self addSubview:_dateLabel];
    }
    return _dateLabel;
}

- (void)layoutSubviews {
    
    CGFloat width = self.bounds.size.width;
    //    CGFloat heigth = self.bounds.size.height;
    _dateLabel.frame = CGRectMake( 0,0, 4*width/5, 4*width/5 );
    [self creat];
}


- (void)creat{
    if (self.dateLabel == nil)
    {
        self.dateLabel.backgroundColor=[UIColor colorWithRed:0.77 green:0.77 blue:0.77 alpha:1.];
        self.dateLabel.textColor=[UIColor colorWithRed:0.52 green:0.52 blue:0.52 alpha:1.];
        
    }
}



- (void)setChecked:(BOOL)checked{
    if (checked)
    {
        self.dateLabel.backgroundColor=[UIColor colorWithRed:0.77 green:0.77 blue:0.77 alpha:1.];
        self.dateLabel.textColor=[UIColor colorWithRed:0.52 green:0.52 blue:0.52 alpha:1.];
    }
    else
    {
        self.dateLabel.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1.];
        self.dateLabel.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1.];
        
    }
    m_checked = checked;
    
    
}

@end
