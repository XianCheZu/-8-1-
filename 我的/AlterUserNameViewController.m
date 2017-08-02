//
//  AlterUserNameViewController.m

//
//  Created by 佐途 on 15/8/12.
//  Copyright (c) 2015年 佐途. All rights reserved.
//

#import "AlterUserNameViewController.h"
#import "AllPages.pch"
#import "ZCUserData.h"
@interface AlterUserNameViewController ()
{
    NSDictionary *_dic;
}
@end

@implementation AlterUserNameViewController
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleViewWithTitle:@"填写昵称"];
    self.view.backgroundColor =Color(234, 234, 234);
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.13)];
    view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:view];
    
    
    UIColor * grayColor =Color(153, 153, 153);
    
    UITextField* username =[[UITextField alloc]initWithFrame:CGRectMake(10,0, ScreenWidth*0.6, ScreenWidth*0.13)];
    username.text =[ZCUserData share].username;
    username.textColor =[UIColor grayColor];
    username.tag =1001;
    username.placeholder =@"请输入您的昵称";
    [username setValue:grayColor forKeyPath:@"_placeholderLabel.textColor"];
    [username setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    username.font =[UIFont systemFontOfSize:14.0f];
    [view addSubview:username];
    
    
    
    
    UIButton *rightbutton=[[UIButton alloc]initWithFrame:CGRectMake(30, 0, 30, 20)];
    rightbutton.titleLabel.font =[UIFont systemFontOfSize:15.0f];
    [rightbutton setTitle:@"确认"  forState:UIControlStateNormal];
    [rightbutton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addItemWithCustomView:@[rightbutton] isLeft:NO];
    
    
}
- (void)rightBtnClick:(UIButton *)button
{
    UITextField* username =(UITextField *)[self.view viewWithTag:1001];
    
    NSDictionary *parameter =[NSDictionary dictionaryWithObjectsAndKeys:[ZCUserData share].lianxi,@"lianxi", [ZCUserData share].userId,@"userid",username.text,@"nickname",[ZCUserData share].xueli,@"xueli",[ZCUserData share].zhiye,@"zhiye",[ZCUserData share].xingqu,@"xingqu",[ZCUserData share].descriptions,@"description",nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:[NSString stringWithFormat:@"%@api.php?op=member_update",NowUrl] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         _dic = responseObject;
         NSLog(@"%@",_dic);
         NSString  * str =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"error"]];
         if ([str isEqualToString:@"1"])
         {
             NSString * str =[NSString stringWithFormat:@"%@",[_dic objectForKey:@"msg"]];
             UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alertView.delegate = self;
             [self.view addSubview:alertView];
             [alertView show];
         }else
         {
             [self ShowMBHubWithTitleOnlyWithTitle:@"修改成功" withTime:1.0f];
             [self.navigationController popViewControllerAnimated:YES];
             [[ZCUserData share]saveUserInfoWithUserId:[ZCUserData share].userId username:[ZCUserData share].username descriptions:[ZCUserData share].descriptions mobile:[ZCUserData share].mobile fuwu:[ZCUserData share].fuwu jiedan:[ZCUserData share].jiedan lianxi:[ZCUserData share].lianxi yinxiang:[ZCUserData share].yinxiang nickname:username.text thumb:[ZCUserData share].thumb tiqian:[ZCUserData share].tiqian xing:[ZCUserData share].xing xingqu:[ZCUserData share].xingqu xueli:[ZCUserData share].xueli zhiye:[ZCUserData share].zhiye IsLogin:[ZCUserData share].isLogin];
             
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"失败信息");
         
     }];
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
