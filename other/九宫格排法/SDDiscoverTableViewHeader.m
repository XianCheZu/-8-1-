//
//  SDDiscoverTableViewHeader.m
//  GSD_ZHIFUBAO
//
//  Created by aier on 15-6-5.
//  Copyright (c) 2015年 GSD. All rights reserved.
//


#define ScreenWidth self.frame.size.width

#import "SDDiscoverTableViewHeader.h"
#import "SDDiscoverTableViewHeaderItemButton.h"




@implementation SDDiscoverTableViewHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setSd_height:(CGFloat)sd_height
{
    CGRect temp = self.frame;
    temp.size.height = sd_height;
    self.frame = temp;
}
-(void)setSd_width:(CGFloat)sd_width
{
    CGRect temp = self.frame;
    temp.size.width = sd_width;
    self.frame = temp;
}
- (void)setHeaderItemModelsArray:(NSArray *)headerItemModelsArray
{
    _headerItemModelsArray = headerItemModelsArray;
    
    [headerItemModelsArray enumerateObjectsUsingBlock:^(SDDiscoverTableViewHeaderItemModel *model, NSUInteger idx, BOOL *stop) {
        SDDiscoverTableViewHeaderItemButton *button = [[SDDiscoverTableViewHeaderItemButton alloc] init];
        button.tag = idx;
        button.title = model.title;
        button.imageName = model.imageName;
        [button addTarget:self action:@selector(buttonClickd:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.subviews.count == 0) return;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView *button, NSUInteger idx, BOOL *stop) {
    
        button.frame=CGRectMake(ScreenWidth*0.03+idx%4*(ScreenWidth*0.21+ScreenWidth*0.03),idx/4*(ScreenWidth*0.1+ScreenWidth*0.03), ScreenWidth*0.21, ScreenWidth*0.13);
        
    }];
}

- (void)buttonClickd:(SDDiscoverTableViewHeaderItemButton *)button
{
    if (self.buttonClickedOperationBlock) {
        self.buttonClickedOperationBlock(button.tag);
    }
}

@end


@implementation SDDiscoverTableViewHeaderItemModel

+ (instancetype)modelWithTitle:(NSString *)title imageName:(NSString *)imageName destinationControllerClass:(Class)destinationControllerClass
{
    SDDiscoverTableViewHeaderItemModel *model = [[SDDiscoverTableViewHeaderItemModel alloc] init];
    model.title = title;
    model.imageName = imageName;
    model.destinationControllerClass = destinationControllerClass;
    return model;
}

@end