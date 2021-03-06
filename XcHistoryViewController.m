//
//  XingchengController.m
//  ZuChe
//
//  Created by apple  on 16/11/7.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "XcHistoryViewController.h"
#import "Header.h"
#import "XcHistoryTableViewCell.h"
#import "ZCUserData.h"
#import "HttpManager.h"
#import "MBProgressHUD.h"
#import "XcHistoryDetailsViewController.h"


//
//http://wx.leisurecarlease.com/tc.php?op=indent_list
//
//请求参数：
//$_POST[userid]     //用户userid
//返回参数：
//{
//    msg      --- 返回消息
//    error    --- 0成功 | | 1失败
//    list     --- 数组
//    
//}

#define CHEZHU_URL @"http://wx.leisurecarlease.com/tc.php?op=indent_list"

@interface XcHistoryViewController()<UITableViewDelegate,UITableViewDataSource>{
   
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@end

@implementation XcHistoryViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    if ([ZCUserData share].isLogin == YES) {
        
        [self initData];
        
    }
   
}
-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = NO;
    // [leftTableView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray new];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title  = @"历史订单";
    
    UIButton *fanhui = [UIButton buttonWithType:UIButtonTypeCustom];
    fanhui.frame = CGRectMake(0, 0, 25, 25);
    [fanhui setBackgroundImage:[UIImage imageNamed:@"返回11"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhuile) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:fanhui];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
    
//    
//    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"没有订单(1).png"]];
//    
//    image.frame =  CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-44-64-64);
//    
//    [self.view addSubview:image];
    [self createTableView];
}
- (void)fanhuile{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)initData {
    
    [MBProgressHUD showHUDAddedTo:_tableView animated:YES];
    
    NSDictionary *dict = @{@"userid": [ZCUserData share].userId};
    
    [HttpManager postData:dict andUrl:CHEZHU_URL success:^(NSDictionary *fanhuicanshu) {
        
        if ([fanhuicanshu[@"list"] isKindOfClass:[NSNull class]]) {
            
        }else {
            NSArray *arr = fanhuicanshu[@"list"];
            [_dataArray removeAllObjects];
            [_dataArray addObjectsFromArray:arr];
            
            if (_dataArray.count == 0) {
                _tableView.frame = CGRectMake(0, 64, ScreenWidth, self.view.frame.size.height-64-ScreenWidth*0.14);
                UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 2000)];
                imageView.clipsToBounds = YES;
                imageView.image = [[UIImage imageNamed:@"没有订单(1).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
               // imageView.backgroundColor = [UIColor redColor];
                _tableView.backgroundView = imageView;
              //  _tableView.backgroundColor = [UIColor greenColor];
            }else {
                _tableView.frame = CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height);
                UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
                //            imageView.image=[UIImage imageNamed:@"11.jpg"];
                [_tableView setBackgroundView:imageView];
            }
            [_tableView reloadData];
            
        }
        [MBProgressHUD hideHUDForView:_tableView animated:NO];
    } Error:^(NSString *cuowuxingxi) {
        
    }];
    
}
#pragma mark - create TableView
- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height)];
    //leftTableView.backgroundColor = [UIColor redColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tag = 1000;
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshClick:refreshControl];
    
}
-(void)refreshClick:(UIRefreshControl *)refreshControl {
    NSLog(@"refreshClick: -- 刷新触发");
    if (refreshControl.tag == 1000) {
        // 此处添加刷新tableView数据的代码
        [refreshControl endRefreshing];
        [self initData];
        // [_leftTableView reloadData];// 刷新tableView即可
    }
}
#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ScreenWidth*0.6;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *stack = @"stack";
    XcHistoryTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:stack];
    if (!cell) {
        
        cell = [[XcHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:stack];
        
       
    }
    cell.dict = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XcHistoryDetailsViewController *view = [XcHistoryDetailsViewController new];
    view.postIdString = _dataArray[indexPath.row][@"id"];
    [self.navigationController pushViewController:view animated:YES];
  
}

@end

