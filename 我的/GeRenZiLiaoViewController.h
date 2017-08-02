//
//  GeRenZiLiaoViewController.h
//  ZuChe
//
//  Created by 佐途 on 16/1/27.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "ParentsViewController.h"

@protocol SendStrDelegate <NSObject>

- (void)sendStr:(NSString *)str;
- (void)sendIMg:(UIImage *)img;

@end

@interface GeRenZiLiaoViewController : ParentsViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic ,copy)UITextField *ziliao;
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)UIImage *touxiangImage;
@property (nonatomic ,assign)id <SendStrDelegate>delegate;
@property (nonatomic , copy)NSMutableString *phones;
 
@end
