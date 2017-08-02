//
//  NoOrderViewController.h
//  ZuChe
//
//  Created by 佐途 on 15/11/18.
//  Copyright © 2015年 佐途. All rights reserved.
//

#import "ParentsViewController.h"

typedef void(^jiablock)(UIButton *result);


@interface NoOrderViewController : ParentsViewController

@property (nonatomic,copy)jiablock Firstblock;

@end
