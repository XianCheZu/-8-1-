
//  Created by aier on 15-6-5.
//  Copyright (c) 2015年 j.x.y. All rights reserved.
//

#import "SDDiscoverTableViewHeaderItemButton.h"
#import "AllPages.pch"
@implementation SDDiscoverTableViewHeaderItemButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = Font(12);
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = contentRect.size.width * 0.35;
    CGFloat y = 0;
    CGFloat w = contentRect.size.width - x * 2;
    CGFloat h = contentRect.size.height * 0.5;
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectMake(0, contentRect.size.height * 0.5+5, contentRect.size.width, contentRect.size.height * 0.3);
    return rect;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}



@end
