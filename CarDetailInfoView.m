//
//  CarDetailInfoView.m
//  ZuChe
//
//  Created by apple  on 16/12/23.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "CarDetailInfoView.h"
#import "Header.h"
#import "HttpManager.h"
#import "MyScrollView.h"
#import "CustomOrderView.h"
#import "CarDetailInfoCell.h"

#import "AboutUsViewController.h"

#import "UIViewController+YSLTransition.h"
#import "YSLTransitionAnimator.h"
#import "GiFHUD.h"
#import "UIImageView+WebCache.h"
#import "ChangzuView.h"
#import "ChangBaoView.h"
#import "ZCUserData.h"

#import "XieYiViewController.h"
#import "RiliViewController.h"

#define CarDetailInfo @"http://wx.leisurecarlease.com/api.php?op=api_cartypexq"

@interface CarDetailInfoView()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,YSLTransitionAnimatorDataSource,CarDetailDelegate>{
    
    BOOL _isClick1;
    CGFloat width;
    CGFloat height;
    UITableView *_tableView;
    NSDictionary *dicta;
    NSDictionary *dicta2;
    NSString *url;
    
    NSString *_typeCar;
    
    NSString *_color;
    
    NSMutableArray *likeArray;
    NSMutableArray *imgArray;
    NSMutableArray *priceArray;
    NSMutableArray *pjArray;
    NSMutableArray *typeArray;
    NSMutableArray *plateArray;
    NSMutableArray *iconArray;
    NSMutableArray *colorArray;
    NSMutableArray *nameArray;
    NSMutableArray *starArray;
    
    BOOL  isPOISearch[4];
    bool isGeoSearch;
    
    UIImageView *_chuanImage;
}
@property (nonatomic , strong) MyScrollView *bannerView;
@property (nonatomic , retain)UIImageView *carImageView;

@end

@implementation CarDetailInfoView

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationController.navigationBar.translucent = NO;
    [self downLoadData];
    
    [self searchCollection];
}
- (void)searchCollection{
    
    UIButton *timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame = CGRectMake(0, 0, 25, 25);
//    [timeBtn setBackgroundImage:[UIImage imageNamed:@"收藏(1).png"] forState:UIControlStateNormal];
    
    [timeBtn addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barTimeBtn=[[UIBarButtonItem alloc]initWithCustomView:timeBtn];
    self.navigationItem.rightBarButtonItem = barTimeBtn;
    NSDictionary *dictionary = @{@"userid":[ZCUserData share].userId,@"carid":self.carid,@"model":@"select",@"cartype":self.cartype};
    
    [HttpManager postData:dictionary andUrl:@"http://wx.leisurecarlease.com/api.php?op=shoucang" success:^(NSDictionary *fanhuicanshu) {
        
        if ([fanhuicanshu[@"error"] isEqualToString:@"1"]) {
            
            timeBtn.selected = NO;
            [timeBtn setBackgroundImage:[UIImage imageNamed:@"收藏(1).png"] forState:UIControlStateNormal];
        }else{
            
            timeBtn.selected = YES;
            [timeBtn setBackgroundImage:[UIImage imageNamed:@"收藏333.png"] forState:UIControlStateNormal];
        }
    } Error:^(NSString *cuowuxingxi) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    
   // [super viewDidAppear:animated];
    [self ysl_addTransitionDelegate:self];
    // pop
    [self ysl_popTransitionAnimationWithCurrentScrollView:nil
                                    cancelAnimationPointY:0
                                        animationDuration:0.3
                                  isInteractiveTransition:YES];
}
- (void)downLoadData{
    
    NSDictionary *dic = @{@"carid":self.carid,@"type":self.cartype};
    
    [HttpManager postData:dic andUrl:CarDetailInfo success:^(NSDictionary *fanhuicanshu) {
        
        NSLog(@"---%@",fanhuicanshu);
        dicta = fanhuicanshu[@"carinfo"];
        dicta2 = fanhuicanshu;
        
        _carPrice = dicta[@"jiage1"];
        _color = dicta[@"color"];
        likeArray = fanhuicanshu[@"xscarlist"];
        _typeCar = dicta[@"cartype"];
        _carid = fanhuicanshu[@"state"][@"carid"];
        
        UIView *view = [GiFHUD new];
        [GiFHUD setGifWithImageName:@"动态gif.gif"];
        [GiFHUD show];
        _tableView.scrollEnabled = NO;
        
        [self performSelector:@selector(stopit) withObject:view afterDelay:0.5];
        
    } Error:^(NSString *cuowuxingxi) {
        
        NSLog(@"%@",cuowuxingxi);
    }];
}
- (void)stopit{
    
    [GiFHUD dismiss];
    
    [self createScrollView];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    [self ysl_removeTransitionDelegate];
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.title = @"车辆信息";
    _isClick1 = YES;
    dicta = [NSDictionary dictionary];
    url = [NSString string];
    width  = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    likeArray  = [NSMutableArray array];
    imgArray   = [NSMutableArray array];
    priceArray = [NSMutableArray array];
    pjArray    = [NSMutableArray array];
    typeArray  = [NSMutableArray array];
    plateArray = [NSMutableArray array];
    iconArray  = [NSMutableArray array];
    colorArray = [NSMutableArray array];
    nameArray  = [NSMutableArray array];
    starArray  = [NSMutableArray array];
    _chuanImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, ScreenWidth, ScreenWidth*2/3)];
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
//    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    searchBtn.frame = CGRectMake(0, 0, 25, 25);
//    [searchBtn setBackgroundImage :[UIImage imageNamed:@"分享1.png"] forState:UIControlStateNormal];
//    [searchBtn addTarget:self action:@selector(fenxiang:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame = CGRectMake(0, 0, 25, 25);
    [timeBtn setBackgroundImage:[UIImage imageNamed:@"收藏(1).png"] forState:UIControlStateNormal];
    timeBtn.selected = NO;
    [timeBtn addTarget:self action:@selector(shoucang:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barTimeBtn=[[UIBarButtonItem alloc]initWithCustomView:timeBtn];
    self.navigationItem.rightBarButtonItem = barTimeBtn;
//    UIBarButtonItem *barSearchBtn=[[UIBarButtonItem alloc]initWithCustomView:searchBtn];
//    NSArray *rightBtns=[NSArray arrayWithObjects:barTimeBtn,barSearchBtn, nil];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *xiadingdan = [UIButton buttonWithType:UIButtonTypeCustom];
    xiadingdan.frame = CGRectMake(0, height-width*0.1-64, width, width*0.1);
    xiadingdan.backgroundColor = Color(7, 187, 177);
    [xiadingdan setTitle:@"立即预定" forState:UIControlStateNormal];
    [xiadingdan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [xiadingdan addTarget:self action:@selector(xiaDingDan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xiadingdan];
    
    // 大图
//    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
//    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    self.carImageView = [[UIImageView alloc]init];
    self.carImageView.frame =  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*2/3);
    [self.view addSubview:self.carImageView];
    
    
}
- (void)xiaDingDan{
    
    NSString *type1 = dicta2[@"state"][@"type"];
    
    if ([type1 intValue] == 4) {
        
        ChangzuView *view = [[ChangzuView alloc] init];
        view.cartype = dicta2[@"carinfo"][@"cartype"];
        view.carprice = dicta2[@"carinfo"][@"jiage1"];
        view.chaochu1 = dicta2[@"carinfo"][@"jiage3"];
        view.chaochu2 = dicta2[@"carinfo"][@"jiage2"];
        view.carid = dicta2[@"state"][@"carid"];
        view.jiedan = dicta[@"jiedan"];
        [self.navigationController pushViewController:view animated:YES];
    }
    else if ([type1 intValue] == 5) {
        
        ChangBaoView *view = [[ChangBaoView alloc] init];
        view.cartype = dicta2[@"carinfo"][@"cartype"];
        view.carprice = dicta2[@"carinfo"][@"jiage1"];
        view.chaochu1 = dicta2[@"carinfo"][@"jiage3"];
        view.carid = dicta2[@"state"][@"carid"];
        view.jiedan = dicta[@"jiedan"];
        [self.navigationController pushViewController:view animated:YES];
    }else{
        
        CustomOrderView *view = [[CustomOrderView alloc] init];
        
        view.carType = _typeCar;
        view.carPrice = _carPrice;
        view.chao1= _carPrice1;
        view.chao2 = _carPrice2;
        view.carURL = dicta2[@"carinfo"][@"cartu1"];
        view.userName = _username;
        view.jiedan = dicta[@"jiedan"];
        view.carPaizhao = dicta2[@"carinfo"][@"plate"];
        view.carColor = dicta2[@"carinfo"][@"color"];
        view.phoneNUM = dicta2[@"carinfo"][@"phone"];
        view.carid = dicta2[@"state"][@"carid"];
        view.xingxing = dicta[@"fwxing"];
        
        [self.navigationController pushViewController:view animated:YES];
    }
}

- (void)createScrollView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height-width*0.1-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = YES;
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView = [UIView new];
    // header
    _tableView.tableHeaderView = self.carImageView;
    _tableView.separatorStyle = 0;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([dicta2[@"state"][@"type"] intValue] == 4) {
        
        return width*5-width*0.02-width/3*2-width*0.1-64;
    }else{
        return width*5-width*0.02-width/3*2-width*0.2-64;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *stac = @"stav";
    
    CarDetailInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        
        cell = [[CarDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stac];
    }
    
    cell.model = dicta2;
    cell.dicDelegate = self;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - 进入提交订单界面
- (void)sendCarId:(NSString *)carID sendPSG:(NSString *)sender{
    
    CarDetailInfoView *view = [[CarDetailInfoView alloc] init];
    
    [_chuanImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.leisurecarlease.com%@",sender]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    view.cartype = self.cartype;
    view.carPrice = _carPrice;
    view.carPrice1= _carPrice1;
    view.carPrice2 = _carPrice2;
    view.carImageView = _carImageView;
    view.username = _username;
    view.carid = carID;
//    view.xingxing = dicta[@"fwxing"];
    
    [self.navigationController pushViewController:view animated:YES];
}
- (void)sendPSG:(NSDictionary *)sender{
    
    NSLog(@"sender === %@",sender);
}
#pragma mark - 服务协议,平台规则
- (void)fuwuUserID{
    
    XieYiViewController *view = [[XieYiViewController alloc] init];
    view.xieyititle = @"平台规则";
    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark - 查看日历
- (void)riliSend:(NSString *)userID bukezuTime:(NSString *)bukezu{
    
    RiliViewController *view = [[RiliViewController alloc] init];
    
    view.carid = userID;
    view.bukezuTime = bukezu;
    
    [self.navigationController pushViewController:view animated:YES];
}

//#pragma mark - 二维码
//- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
//    
//    CGRect extent = CGRectIntegral(image.extent);
//    
//    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
//    
//    // 创建bitmap;
//    
//    size_t width11 = CGRectGetWidth(extent) * scale;
//    
//    size_t height11 = CGRectGetHeight(extent) * scale;
//    
//    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
//    
//    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width11, height11, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
//    
//    CIContext *context = [CIContext contextWithOptions:nil];
//    
//    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
//    
//    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
//    
//    CGContextScaleCTM(bitmapRef, scale, scale);
//    
//    CGContextDrawImage(bitmapRef, extent, bitmapImage);
//    
//    // 保存bitmap到图片
//    
//    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
//    
//    CGContextRelease(bitmapRef);
//    
//    CGImageRelease(bitmapImage);
//    
//    return [UIImage imageWithCGImage:scaledImage];
//    
//}
#pragma mark - fanhui
- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - shoucang
- (void)shoucang:(UIButton *)sender{
    
//    if (_isClick1) {
//        
//        
//    }else{
//        
//        [sender setBackgroundImage:[UIImage imageNamed:@"收藏.png"] forState:UIControlStateNormal];
//    }
    
    if (sender.selected == NO) {
        
        sender.selected = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"收藏333.png"] forState:UIControlStateNormal];
        
        NSDictionary *dictionary = @{@"userid":[ZCUserData share].userId,@"carid":self.carid,@"model":@"insert",@"cartype":self.cartype};
        
        [HttpManager postData:dictionary andUrl:@"http://wx.leisurecarlease.com/api.php?op=shoucang" success:^(NSDictionary *fanhuicanshu) {
            
            NSLog(@"tainjia --- %@",fanhuicanshu);
        } Error:^(NSString *cuowuxingxi) {
            
        }];
    }else if (sender.selected == YES) {
        
        sender.selected = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"收藏(1).png"] forState:UIControlStateNormal];
        
        NSDictionary *dictionary = @{@"userid":[ZCUserData share].userId,@"carid":self.carid,@"model":@"delete",@"cartype":self.cartype};
        
        [HttpManager postData:dictionary andUrl:@"http://wx.leisurecarlease.com/api.php?op=shoucang" success:^(NSDictionary *fanhuicanshu) {
            
            NSLog(@"quxiao --- %@",fanhuicanshu);
        } Error:^(NSString *cuowuxingxi) {
            
        }];
    }
}

#pragma mark -- YSLTransitionAnimatorDataSource
- (UIImageView *)popTransitionImageView
{
    return self.carImageView;
}

- (UIImageView *)pushTransitionImageView
{
    return _chuanImage;
}


#pragma mark - fenxiang
- (void)fenxiang:(UIButton *)sender{
    
//    NSString *shareText = @"这是我心中的车";
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:dicta[@"cartu1"]]];
//    UIImage *shareImage = [UIImage imageWithData:data];
    
//    NSArray *arr = [NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone, nil];
//    [UMSocialData defaultData].extConfig.qqData.title = @"我喜欢这辆车，你呢？";
//    [UMSocialData defaultData].extConfig.qzoneData.title = @"我喜欢这辆车，你呢？";
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"我喜欢这辆车，你呢？";
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"我喜欢这辆车，你呢？";
//    
//    [UMSocialData defaultData].extConfig.qqData.url = url;
//    [UMSocialData defaultData].extConfig.qzoneData.url = url;
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
//    
//    [UMSocialSnsService presentSnsController:self appKey:@"56ea243767e58e883800110d" shareText:shareText shareImage:shareImage shareToSnsNames:arr delegate:self];
//    [UMSocialData openLog:YES];
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
//    
//    userLocation.title = @"";
//    userLocation.subtitle = @"";
//    [self.mapView updateLocationData:userLocation];
//    //展示定位
//    self.mapView.showsUserLocation = YES;
//    //更新位置数据
//    [self.mapView updateLocationData:userLocation];
//    //获取用户的坐标  设置中心点的坐标
//    self.mapView.centerCoordinate = userLocation.location.coordinate;
//}


@end
