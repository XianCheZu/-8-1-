//
//  NoOrderViewController.m
//  ZuChe
//
//  Created by 佐途 on 15/11/18.
//  Copyright © 2015年 佐途. All rights reserved.
//
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size) : NO)
#import "NoOrderViewController.h"
#import "AllPages.pch"
#import "MyUtil.h"
#import "ItineraryViewController.h"

@interface NoOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
}

@end

@implementation NoOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithTitle:@"行程"];
    self.view.backgroundColor=[UIColor whiteColor];
    [self Tableview];
    
    if (iPhone4s) {
        _tableview.scrollEnabled=YES;
    }else
    {
        _tableview.scrollEnabled=NO;
    }
}
-(void)Tableview
{
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-100) style:UITableViewStyleGrouped];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    _tableview.backgroundColor=[UIColor whiteColor];
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CGFloat num=0;
    if (section==0) {
        
        num=4;
    }else
    {
        num=1;
    }
    return num;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat num=0.0f;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            num=ScreenWidth*0.39;
        }else{
            num=ScreenWidth*0.234;
        }
    }if (indexPath.section==1) {
        num=Height(100);
    }
    return num;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 9.9;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ziliaocell=@"shanem";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ziliaocell];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ziliaocell];
    }
    else
    {
        for (UIView *sub in cell.contentView.subviews) {
            [sub removeFromSuperview];
        }
    }
    UIColor *bigcolor=Color(155, 155, 155)
    UIColor *smcolor=Color(155, 155, 155)
    UIColor *smcolor1=Color(234, 234, 234)
   UIImageView *XQ=[MyUtil createImageViewFrame:CGRectMake(ScreenWidth-ScreenWidth*0.03125-ScreenWidth*0.01875, (ScreenWidth*0.234-Height(9))/2, Height(4), Height(9)) imageName:@"XQ"];
    UILabel *xian=[[UILabel alloc] initWithFrame:CGRectMake(0, ScreenWidth*0.234-0.3, ScreenWidth, 0.3)];
    xian.backgroundColor=smcolor1;
    UILabel *xian1=[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.234-0.3, ScreenWidth, 0.3)];
    xian1.backgroundColor=smcolor1;
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            UIImageView *imageview=[MyUtil createImageViewFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.39) imageName:@"行程图"];
            [cell.contentView addSubview:imageview];
        }
     
        if (indexPath.row==1) {
            UIImageView *imageIcon=[MyUtil createImageViewFrame:CGRectMake(ScreenWidth*0.04, (ScreenWidth*0.234-ScreenWidth*0.09)/2, ScreenWidth*0.09, ScreenWidth*0.09) imageName:@"1(1)"];
            [cell.contentView addSubview:imageIcon];
            
            UILabel *Bigtitle=[MyUtil createLabelFrame:CGRectMake(ScreenWidth*0.059+ScreenWidth*0.075+ScreenWidth*0.03125, ScreenWidth*0.0343, ScreenWidth, ScreenWidth*0.0468) title:@"如何租车" textAlignment:NSTextAlignmentLeft font:[UIFont boldSystemFontOfSize:ScreenWidth*0.0437] color:bigcolor];
            
            UILabel *smtitle=[MyUtil createLabelFrame:CGRectMake(ScreenWidth*0.059+ScreenWidth*0.075+ScreenWidth*0.03125, ScreenWidth*0.03125+ScreenWidth*0.0468, ScreenWidth*0.75, ScreenWidth*0.125) title:@"提交订单---车主接受---支付订金---服务用车---支付尾款---服务评价" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:ScreenWidth*0.03338] color:smcolor];
            smtitle.numberOfLines=0;
            [cell.contentView addSubview:Bigtitle];
            [cell.contentView addSubview:smtitle];
            [cell.contentView addSubview:XQ];
            [cell.contentView addSubview:xian];
        }
        
        if (indexPath.row==2) {
            UIImageView *imageIcon=[MyUtil createImageViewFrame:CGRectMake(ScreenWidth*0.04, (ScreenWidth*0.234-ScreenWidth*0.1)/2, ScreenWidth*0.1, ScreenWidth*0.1) imageName:@"2"];
            [cell.contentView addSubview:imageIcon];
            
            UILabel *Bigtitle=[MyUtil createLabelFrame:CGRectMake(ScreenWidth*0.059+ScreenWidth*0.075+ScreenWidth*0.03125, ScreenWidth*0.0343, ScreenWidth, ScreenWidth*0.0468) title:@"支付押金" textAlignment:NSTextAlignmentLeft font:[UIFont boldSystemFontOfSize:ScreenWidth*0.0437 ] color:bigcolor];
            
            UILabel *smtitle=[MyUtil createLabelFrame:CGRectMake(ScreenWidth*0.059+ScreenWidth*0.075+ScreenWidth*0.03125, ScreenWidth*0.03125+ScreenWidth*0.0468, ScreenWidth*0.75, ScreenWidth*0.125) title:@"支持微信支付、支付宝支付。" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:ScreenWidth*0.03338] color:smcolor];
            smtitle.numberOfLines=0;
            [cell.contentView addSubview:Bigtitle];
            [cell.contentView addSubview:smtitle];
            [cell.contentView addSubview:XQ];
            [cell.contentView addSubview:xian1];
        }
        
        
        
        if (indexPath.row==3) {
            
            UIImageView *imageIcon=[MyUtil createImageViewFrame:CGRectMake(ScreenWidth*0.04, (ScreenWidth*0.234-ScreenWidth*0.1)/2, ScreenWidth*0.1, ScreenWidth*0.1) imageName:@"3"];
            [cell.contentView addSubview:imageIcon];
            
            UILabel *Bigtitle=[MyUtil createLabelFrame:CGRectMake(ScreenWidth*0.059+ScreenWidth*0.075+ScreenWidth*0.03125, ScreenWidth*0.0343, ScreenWidth, ScreenWidth*0.0468) title:@"保险理赔" textAlignment:NSTextAlignmentLeft font:[UIFont boldSystemFontOfSize:ScreenWidth*0.0437] color:bigcolor];
            
            UILabel *smtitle=[MyUtil createLabelFrame:CGRectMake(ScreenWidth*0.059+ScreenWidth*0.075+ScreenWidth*0.03125, ScreenWidth*0.03125+ScreenWidth*0.0468, ScreenWidth*0.75, ScreenWidth*0.125) title:@"车辆缺席，迟到，事故。平台将无条件安排相同或更高级别车辆，并免除相应费用。" textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:ScreenWidth*0.03338] color:smcolor];
            smtitle.numberOfLines=0;
            [cell.contentView addSubview:Bigtitle];
            [cell.contentView addSubview:smtitle];
            [cell.contentView addSubview:XQ];
            [cell.contentView addSubview:xian];
        }
        
 
        
       
       
        
    }if (indexPath.section==1) {
        UIButton *fabu=[MyUtil createBtnFrame:CGRectMake((ScreenWidth-ScreenWidth*0.666)/2,Height(100)-2*ScreenWidth*0.109, ScreenWidth*0.666, ScreenWidth*0.109) image:nil selectedImage:nil target:self action:@selector(fabuanniu:)];
        UIColor *dianhuacolor=Color(18, 152, 233)//蓝
        fabu.backgroundColor=dianhuacolor;
        fabu.layer.cornerRadius=3;
        fabu.titleLabel.font=Font(14);
        [fabu setTitle:@"开始租车" forState:UIControlStateNormal];
        cell.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:fabu];
        
    }else
    {
        cell.backgroundColor=[UIColor whiteColor];
    }
    
    
    
    return cell;
}
-(void)fabuanniu:(UIButton *)sender
{
    NSLog(@"发布车辆");
 
    if ([ZCUserData share].isLogin==YES) {
        if (_Firstblock) {
            _Firstblock(sender);
        }
        
    }else
    {
        LoginView *login=[[LoginView alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }
   
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
