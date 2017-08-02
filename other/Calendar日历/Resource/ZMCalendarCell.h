//
//  ZMCalendarCell.h
//  ZMCalendarPicker
//
//  Created by 朱敏 on 15/11/9.
//  Copyright © 2015年 Arron Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCalendarCell : UICollectionViewCell
{
    BOOL			m_checked;
}
@property (nonatomic , weak) UILabel *dateLabel;
- (void)setChecked:(BOOL)checked;
@end
