//
//  OderManagementViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/6.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "OderManagementViewController.h"
#import "Header.h"
@interface OderManagementViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,retain)UITableView *tableView;
@end

@implementation OderManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithTitle:@"订单管理"];
    [self tableViews];
    
    self.view.backgroundColor =Color(245, 245, 249);
}
- (void)tableViews
{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.delegate= self;
    self.tableView.dataSource= self;
    self.tableView.backgroundColor=Color(245, 245, 245);
    //    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }else{
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    if (indexPath.row==0)
    {
        UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth *0.12/2-ScreenWidth*0.06/2, ScreenWidth*0.6, ScreenWidth*0.06)];
        //        label.backgroundColor =[UIColor yellowColor];
        label.text  =@"订单号: 125487564585784";
        [self label:label isBold:NO isFont:14.0f];
        [cell.contentView addSubview:label];
    }
    if (indexPath.row ==1)
    {
        UILabel * yongTime =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.025, ScreenWidth*0.6, ScreenWidth*0.05)];
        yongTime.text =[NSString stringWithFormat:@"用车时间 : 2015-11-01 9:00"];
        //        yongTime.backgroundColor =[UIColor yellowColor];
        [self  label:yongTime  isBold:NO isFont:13.0f];
        yongTime.textColor = Color(100, 100, 100);
        [cell.contentView addSubview:yongTime];
        
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*(0.03+0.05+0.025), ScreenWidth*0.04, ScreenWidth*0.04)];
        imageView.image =[UIImage imageNamed:@"地址.png"];
        [cell.contentView addSubview:imageView];
        
        UILabel *adress= [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.08, ScreenWidth*(0.03+0.05+0.02), ScreenWidth*0.85, ScreenWidth*0.05)];
        adress.text =@"上海市普陀区武宁路曹杨路联合大厦";
        [self  label:adress  isBold:NO isFont:13.0f];
        adress.textColor = Color(100, 100, 100);
        [cell.contentView addSubview:adress];
        
        
        UILabel *yuanyin =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*(0.03+0.05+0.03+0.03+0.03), ScreenWidth*0.5, ScreenWidth*0.05)];
        //        yuanyin.backgroundColor =[UIColor redColor];
        yuanyin.text =@"超时未确认";
        [self  label:yuanyin  isBold:NO isFont:13.0f];
        yuanyin.textColor = Color(100, 100, 100);
        [cell.contentView addSubview:yuanyin];
        
        
        UILabel *time =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*(0.4+0.03), ScreenWidth*(0.03+0.05+0.03+0.03+0.04), ScreenWidth*0.4, ScreenWidth*0.03)];
        time.text =@"2015-10-29 15:01:20";
        [self  label:time  isBold:NO isFont:11.0f];
        time.textColor = Color(100, 100, 100);
        time.textAlignment =NSTextAlignmentRight;
        [cell.contentView addSubview:time];
        
        
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return  ScreenWidth *0.12;
    }else
        return  ScreenWidth *0.24;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
