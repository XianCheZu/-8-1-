//
//  jiaTableViewCell.m
//  BRMultilevelMeun
//
//  Created by J.X.Y on 15/11/5.
//  Copyright © 2015年 BR. All rights reserved.
//

#import "jiaTableViewCell.h"

@implementation jiaTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setZero{
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        self.layoutMargins=UIEdgeInsetsZero;
    }
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        self.separatorInset=UIEdgeInsetsZero;
    }
    
}
@end
