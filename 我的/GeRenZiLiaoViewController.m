//
//  GeRenZiLiaoViewController.m
//  ZuChe
//
//  Created by 佐途 on 16/1/27.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "GeRenZiLiaoViewController.h"
#import "AllPages.pch"
#import "UIButton+WebCache.h"
#import "UINavigationBar+Awesome.h"
#import "ZHPickView.h"
#import "EmergencyContactViewController.h"
#define NAVBAR_CHANGE_POINT 80

@interface GeRenZiLiaoViewController()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,ZHPickViewDelegate,UITextFieldDelegate,MBProgressHUDDelegate>

{
    UIButton *photo;
    UITextView *qianming;
    NSString *heighttextview;
    UILabel *residuetext;
    UITextField *ziliao;
    NSArray *Xueli;
    NSArray *Zhiye;
}

@property(nonatomic,strong)ZHPickView *pickview;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,retain)UITableView *tableView;
@end

@implementation GeRenZiLiaoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oldheight"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"textView.textssss"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"indexpath.row0"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"indexpath.row1"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"indexpath.row2"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"indexpath.row3"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"indexpath.row4"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"zheshi1phone"];
    Xueli=[NSArray arrayWithObjects:@"中专及以下",@"高中",@"大专",@"本科",@"研究生",@"硕士",@"博士",@"博士后", nil];
    Zhiye=[NSArray arrayWithObjects:@"服务业",@"能源·化工",@"医疗·生物",@"法律·咨询",@"广告·传媒",@"政府·机构",@"物流·贸易",@"机械·汽车",@"金融",@"文化·教育",@"房地产·建筑",@"通信·硬件",@"互联网·软件",@"快消",@"旅游",@"其他", nil];
    self.view.backgroundColor =Color(245, 245, 249);
//    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
//    [leftbutton setTitle:@"保存" forState:UIControlStateNormal];
//    leftbutton.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, -10);
//    [leftbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [leftbutton addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    leftbutton.titleLabel.font=Font(14);
//    [self addItemWithCustomView:@[leftbutton] isLeft:NO];
//    self.view.backgroundColor=[UIColor whiteColor];
    
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition];
    [self tableViews];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(30, ScreenWidth*0.1, 20, 20);
    [leftButton setImage:[UIImage imageNamed:@"返回白.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(popController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
//    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    //    leftBarbutton.accessibilityFrame = CGRectMake(30, 24, 20, 20);
//    self.navigationItem.leftBarButtonItem = leftBarbutton;
    //    [[self.navigationItem.leftBarButtonItem setTarget:self] addtargit:@selector(sendMessage:)];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightButton.frame = CGRectMake(ScreenWidth*0.8,ScreenWidth*0.1,50,20);
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    //    rightButton.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, -10);
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font=Font(16);
    [self.view addSubview:rightButton];
    //        [self addItemWithCustomView:@[rightButton] isLeft:NO];
//    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}
- (void)popController{
    
    //    UserMine *view = [[UserMine alloc] init];
    //    view.strign = _name;
//    if (_delegate && [_delegate respondsToSelector:@selector(sendMessage:)]) {
//        
//        [_delegate sendStr:_name];
//    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)sendMessage:(UIButton *)button{
    
    
}
- (void)tableViews
{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, -ScreenWidth*0.65/2, ScreenWidth, ScreenHeight+ScreenWidth*0.65/2) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource =self;
    self.tableView.backgroundColor =Color(245, 245, 249);
    
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int  num = 0;
    if (section ==0)
    {
        num  =1;
    }
    if (section ==1)
    {
        num  =5;
    }
    if (section==2) {
        
        num=1;
    }
    
    
    return num;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }else{
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04 , 0, ScreenWidth/2, ScreenWidth*0.13)];
    titleLable.textColor=[UIColor blackColor];
    [self label:titleLable isBold:NO isFont:13];
    //    titleLable.backgroundColor =[UIColor blueColor];
    //    [self label:titleLable isBold:NO isFont:14.0f];
    
    
    
    UIImageView*imageViewes =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.03-ScreenWidth*0.04, ScreenWidth*0.13/2-ScreenWidth*0.03/2, ScreenWidth*0.03, ScreenWidth*0.03)];
    imageViewes.alpha =0.6;
    imageViewes.image=[UIImage imageNamed:@"right"];
    
    ziliao =[[UITextField alloc]initWithFrame:CGRectMake(ScreenWidth-ScreenWidth*0.085-ScreenWidth*0.5, 0, ScreenWidth*0.5, ScreenWidth*0.13)];
    ziliao.font =Font(12);
    
    ziliao.textColor =Color(64 , 64, 64);
    ziliao.textAlignment=NSTextAlignmentRight;
    
    
    if (indexPath.section==0)
    {
        UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.65 )];
        image.image =[UIImage imageNamed:@"个人中心背景.jpg"];
        [cell.contentView addSubview:image];
        
        
        UIImageView *ph =[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.65-ScreenWidth*0.21/2-3, ScreenWidth*0.21+6, ScreenWidth*0.21+6)];
        ph.image =[UIImage imageNamed:@"头像背景"];
        [cell.contentView addSubview:ph];
        photo =[UIButton buttonWithType:UIButtonTypeSystem];
        
        
        //        float photoHeight =ScreenWidth*0.21;
        
        photo.frame=CGRectMake(ScreenWidth*0.04+3, ScreenWidth*0.65-ScreenWidth*0.21/2, ScreenWidth*0.21, ScreenWidth*0.21);
        photo.layer.masksToBounds =YES;
        photo.layer.cornerRadius=photo.frame.size.height/2;
        [photo setBackgroundImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
        [photo addTarget:self action:@selector(geRenZilLiaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString * srting =[NSString stringWithFormat:@"%@",[ZCUserData share].thumb];
        if ([srting isKindOfClass:[NSNull class]]||[srting isEqualToString:@""]||[srting isEqual:@""]) {
            [photo setBackgroundImage: [UIImage imageNamed:@"Big"] forState:UIControlStateNormal];
        }else
        {
            [photo sd_setBackgroundImageWithURL:[NSURL URLWithString:srting] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"头像"]];
        }
        [cell.contentView addSubview:photo];
        
        UILabel *phone =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04+ScreenWidth*0.21,ScreenWidth*0.65- ScreenWidth*0.09, ScreenWidth*0.4, ScreenWidth*0.07)];
        //            phone.backgroundColor =[UIColor yellowColor];
        phone.textAlignment =NSTextAlignmentCenter;
        phone.textColor =[UIColor whiteColor];
        //            [self label:phone isBold:NO isFont:18.0f];
        phone.font =[UIFont systemFontOfSize:18.0f];
        [cell.contentView addSubview:phone];
        if ([ZCUserData share].isLogin==NO) {
            
        }else
        {
            NSMutableString *phones =[[NSMutableString alloc]initWithString:[ZCUserData share].mobile];
            [phones deleteCharactersInRange:NSMakeRange(3, 6)];
            //  添加＊＊＊ 从第三个开始
            [phones insertString:@"******" atIndex:3];
            phone.text =phones;
        }
        
        
        
        float nowHeight =(ScreenWidth*0.9 -ScreenWidth*0.65)-ScreenWidth*0.21/2;
        NSString *oooold=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"textView.textssss"]];
        qianming =[[UITextView alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.65+ScreenWidth*0.21/2 + nowHeight/2-ScreenWidth*0.07/2, ScreenWidth-ScreenWidth*0.08, ScreenWidth*0.07)];
        NSString * string =[NSString stringWithFormat:@"%@",[ZCUserData share].descriptions];
        qianming.delegate=self;
        if ([oooold isEqualToString:@"(null)"]) {
            if (string.length==0)
            {
                qianming.text =@"您还没有填写您的个性签名。";
            }else
            {
                qianming.text=string;
                
            }
            
        }else
        {
            qianming.text=oooold;
        }
        //    [self  label:qianming isBold:NO isFont:13.0f];
        qianming.font =Font(13);
        
        qianming.textColor =Color(153, 153, 153);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:qianming.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [qianming.text length])];
        qianming.attributedText = attributedString;
        [cell.contentView addSubview:qianming];
        qianming.frame = CGRectMake ( ScreenWidth*0.04 , ScreenWidth*0.65+ScreenWidth*0.21/2 + nowHeight/2-ScreenWidth*0.07/2 , ScreenWidth -2*ScreenWidth*0.04, qianming.contentSize.height );
        
        
        residuetext=[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-Height(120), ScreenWidth*0.9-Height(40), Height(100), Height(16))];
        residuetext.text=@"0/200";
        [residuetext setTextAlignment:NSTextAlignmentRight];
        residuetext.font =Font(13);
        residuetext.adjustsFontSizeToFitWidth = YES;
        residuetext.textColor = Color(81, 81, 81);
        residuetext.alpha=0.6;
        [cell.contentView addSubview:residuetext];
    }
    
    if (indexPath.section ==1)
    {
        
        
        UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.04, ScreenWidth*0.13-1, ScreenWidth-ScreenWidth*0.08, 1)];
        xian.backgroundColor =Color(225, 225, 225);
        
        
        
        
        if (indexPath.row ==0)
        {
            titleLable.text=@"昵称";
            NSString * string =[NSString stringWithFormat:@"%@",[ZCUserData share].nickname];
            NSString *haha=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"indexpath.row0"]];
            if ([haha isEqualToString:@"(null)"]||[haha isEqualToString:@""] ) {
                ziliao.text =string;
            }else
            {
                ziliao.text =haha;
            }

            ziliao.delegate=self;
            ziliao.tag=0;
            [cell.contentView addSubview:titleLable];
            [cell.contentView addSubview:xian];
            [cell.contentView addSubview:imageViewes];
            [cell.contentView addSubview:ziliao];
            
        }
        if (indexPath.row ==1)
        {
            titleLable.text=@"学历";
            
            NSString * string =[NSString stringWithFormat:@"%@",[ZCUserData share].xueli];
            NSString *haha=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"indexpath.row1"]];
            if ([haha isEqualToString:@"(null)"]||[haha isEqualToString:@""] ) {
                ziliao.text =string;
            }else
            {
                ziliao.text =haha;
            }
            
            ziliao.userInteractionEnabled=NO;
            ziliao.tag=1;
            
            [cell.contentView addSubview:titleLable];
            [cell.contentView addSubview:xian];
            [cell.contentView addSubview:imageViewes];
            [cell.contentView addSubview:ziliao];
            
        }
        if (indexPath.row ==2)
        {
            titleLable.text=@"职业";
            NSString * string =[NSString stringWithFormat:@"%@",[ZCUserData share].zhiye];
            NSString *haha=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"indexpath.row2"]];
            if ([haha isEqualToString:@"(null)"]||[haha isEqualToString:@""] ) {
                ziliao.text =string;
            }else
            {
                ziliao.text =haha;
            }
            ziliao.userInteractionEnabled=NO;
            ziliao.tag=2;
            
            [cell.contentView addSubview:titleLable];
            [cell.contentView addSubview:xian];
            [cell.contentView addSubview:imageViewes];
            [cell.contentView addSubview:ziliao];
        }
        if (indexPath.row ==3)
        {
            titleLable.text=@"兴趣爱好";
            NSString * string =[NSString stringWithFormat:@"%@",[ZCUserData share].xingqu];
            NSString *haha=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"indexpath.row3"]];
            if ([haha isEqualToString:@"(null)"]||[haha isEqualToString:@""] ) {
                ziliao.text =string;
            }else
            {
                ziliao.text =haha;
            }
            

            ziliao.tag=3;
            ziliao.delegate=self;
            [cell.contentView addSubview:titleLable];
            [cell.contentView addSubview:xian];
            [cell.contentView addSubview:imageViewes];
            [cell.contentView addSubview:ziliao];
            
        }
        if (indexPath.row ==4)
        {
            
            
            UILabel*xian =[[UILabel alloc]initWithFrame:CGRectMake(0, ScreenWidth*0.13-1, ScreenWidth, 1)];
            xian.backgroundColor =Color(225, 225, 225);
            [cell.contentView addSubview:xian];
            
            titleLable.text=@"紧急联系人";
            NSString *lianxiren=[NSString stringWithFormat:@"%@",[ZCUserData share].lianxi];
            NSString *haha=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"zheshi1phone"]];
            if ([haha isEqualToString:@"(null)"]||[haha isEqualToString:@""] ) {
                ziliao.text =lianxiren;
            }else
            { 
                ziliao.text =haha;
            }
            
            ziliao.userInteractionEnabled=NO;
            ziliao.tag=4;
            ziliao.delegate=self;
            [cell.contentView addSubview:titleLable];
            [cell.contentView addSubview:imageViewes];
            [cell.contentView addSubview:ziliao];
            
        }
    }
    if (indexPath.section==2) {
        UILabel *tuichu=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenWidth*0.13)];
        tuichu.text=@"注销登录";
        [tuichu setTextAlignment:NSTextAlignmentCenter];
        UIColor *jiedancolor=Color(246, 99, 107)//红
        [tuichu setTextColor:jiedancolor];
        tuichu.font=Font(15);
        [cell.contentView addSubview:tuichu];
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9.9;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    NSInteger number1 = [textView.text length];
    if (number1 > 200) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于200" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        textView.text = [textView.text substringToIndex:200];
        number1 = 200;
        
    }
    
    residuetext.text = [NSString stringWithFormat:@"%ld/200",(long)number1];
    

    NSString *newheight=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"oldheight"]];
    NSString *old=[NSString stringWithFormat:@"%.0f",textView.contentSize.height];
    [[NSUserDefaults standardUserDefaults] setObject:old forKey:@"oldheight"];
    [[NSUserDefaults standardUserDefaults] setObject:textView.text forKey:@"textView.textssss"];
    float nowHeight =(ScreenWidth*0.9 -ScreenWidth*0.65)-ScreenWidth*0.21/2;
    if ([newheight isEqualToString:old]||[newheight isEqualToString:@"(null)"]) {
        
    }else
    {
        //textview坐标重新写
        qianming.frame = CGRectMake ( ScreenWidth*0.04 , ScreenWidth*0.65+ScreenWidth*0.21/2 + nowHeight/2-ScreenWidth*0.07/2 , ScreenWidth-2*ScreenWidth*0.04 , qianming.contentSize.height);
        //存起来
        NSString *gaodu=[NSString stringWithFormat:@"%.0f",qianming.frame.size.height];
        [[NSUserDefaults standardUserDefaults] setObject:gaodu forKey:@"oldheight"];
        
        //一个cell刷新
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenWidth*0.9+100;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    float myWidth;
    
    if (indexPath.section==0)
    {
        
        NSString *newheight=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"oldheight"]];
        NSString *sdfdsf=[[NSString alloc]init];
        if ([newheight isEqualToString:@"(null)"]) {
            sdfdsf=[NSString stringWithFormat:@"%.0f",qianming.frame.size.height-20];
        }else
        {
            sdfdsf=[NSString stringWithFormat:@"%.0f",[newheight floatValue]-Height(25)];
        }
        myWidth=ScreenWidth*0.9+[sdfdsf integerValue];
    }else
    {
        myWidth=ScreenWidth*0.13;
    }
    
    return  myWidth;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;

    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.tableView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_pickview remove];
    [self.view endEditing:YES];
//    [self.navigationController.navigationBar lt_reset];
    
    
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条"] forBarMetrics:UIBarMetricsDefault];
    
    
}
//滑动隐藏bar
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:66/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        NSMutableString *phones =[[NSMutableString alloc]initWithString:[ZCUserData share].mobile];
        [phones deleteCharactersInRange:NSMakeRange(3, 6)];
        //  添加＊＊＊ 从第三个开始
        [phones insertString:@"******" atIndex:3];
        
        [self addTitleViewWithTitle:phones];
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
    } else {
        [self addTitleViewWithTitle:@""];
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _indexPath=indexPath;
    if (indexPath.section==2) {
        XWAlterview *xwxw=[[XWAlterview alloc]initWithTitle:nil contentText:@"确定要退出登录吗？" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
        [xwxw show];
        xwxw.rightBlock=^{
            NSLog(@"你点击了确定");
            NSLog(@"退出登录");
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SHANGJIA"];
            [[ZCUserData share]saveUserInfoWithUserId:nil username:nil descriptions:nil mobile:nil fuwu:nil jiedan:nil lianxi:nil yinxiang:nil nickname:nil thumb:nil tiqian:nil xing:nil xingqu:nil xueli:nil zhiye:nil IsLogin:NO];
            [self.navigationController popViewControllerAnimated:YES];
            
        };
        xwxw.leftBlock=^{
            
            
        };
       
    }if (indexPath.section==1) {
        UIColor *colo=Color(234, 234,234);
        if (indexPath.row==1) {//学历
            _pickview=[[ZHPickView alloc] initPickviewWithArray:Xueli isHaveNavControler:NO];
            [_pickview setPickViewColer:colo];
            _pickview.delegate=self;
            [_pickview show];
        }if (indexPath.row==2) {//职业
            _pickview=[[ZHPickView alloc] initPickviewWithArray:Zhiye isHaveNavControler:NO];
            [_pickview setPickViewColer:colo];
            _pickview.delegate=self;
            [_pickview show];
        }if (indexPath.row==4) {
            EmergencyContactViewController *emer=[[EmergencyContactViewController alloc]init];
            [self.navigationController pushViewController:emer animated:YES];
        }
        
    }
}
#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    if (_indexPath.row==1) {
        [[NSUserDefaults standardUserDefaults] setObject:resultString forKey:@"indexpath.row1"];
        [_tableView reloadData];
    }if (_indexPath.row==2) {
        [[NSUserDefaults standardUserDefaults] setObject:resultString forKey:@"indexpath.row2"];
        [_tableView reloadData];
    }
    
}
#pragma uitextfieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textfiele.tag=%ld",textField.tag);
    if (textField.tag==0) {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"indexpath.row0"];
    }if (textField.tag==3) {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"indexpath.row3"];
    }if (textField.tag==4) {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"indexpath.row4"];
    }
    [_tableView reloadData];
}
-(void)leftBtnClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    NSString *name=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"indexpath.row0"]];
    if ([name isEqualToString:@"(null)"]||[name isEqualToString:@""]) {
        name=[ZCUserData share].nickname;
    }
    NSString *xuelihaha=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"indexpath.row1"]];
    if ([xuelihaha isEqualToString:@"(null)"]) {
        xuelihaha=[ZCUserData share].xueli;
    }
    NSString *nechenghaha=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"indexpath.row2"]];
    if ([nechenghaha isEqualToString:@"(null)"]) {
        nechenghaha=[ZCUserData share].zhiye;
    }
    NSString *qianming3=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"indexpath.row3"]];
    if ([qianming3 isEqualToString:@"(null)"]||[qianming3 isEqualToString:@""]) {
        qianming3=[ZCUserData share].xingqu;
    }
    NSString *dianhua=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"zheshi1phone"]];
    if ([dianhua isEqualToString:@"(null)"]||[dianhua isEqualToString:@""]) {
        dianhua=[ZCUserData share].lianxi;
    }
    NSLog(@"签名:%@",qianming.text);
    NSLog(@"学历%@",xuelihaha);
    NSLog(@"职业%@",nechenghaha);
//    NSLog(@"昵称%@",nic);
//    NSLog(@"签名%@",nic3);
//    NSLog(@"紧急联系人%@",nic4);
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.removeFromSuperViewOnHide=YES;
    HUD.labelText = @"正在加载数据...";
    [HUD showAnimated:YES whileExecutingBlock:^{
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                           [ZCUserData share].userId,@"userid",
                           name,@"nickname",//昵称
                           xuelihaha,@"xueli",//学历
                           nechenghaha,@"zhiye",//职业
                           qianming3,@"xingqu",//兴趣
                           qianming.text,@"description",//签名
                           dianhua,@"lianxi",nil];//紧急联系人
        [HttpManager postData:dic andUrl:XIUGAIZILIAO success:^(NSDictionary *fanhuicanshu) {//error  0成功  1失败
            
               [self xiaojiadeTishiTitle:[NSString stringWithFormat:@"%@",[fanhuicanshu objectForKey:@"msg"]]];
            
            
        } Error:^(NSString *cuowuxingxi) {
            
        }];

        sleep(1.0);
    }completionBlock:^{
        
    }];

    
    
}
-(void)geRenZilLiaoBtnClick:(UIButton *)sender
{
    [self AlertController:nil preferredStyle:UIAlertControllerStyleActionSheet actionWithTitle:@"相机" actionWithTitle2:@"从相册选择" handler:^(UIAlertAction *action) {
        // 拍照
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        
        [self presentViewController:picker animated:YES completion:nil];
    } handler2:^(UIAlertAction *action) {
        // 从相册中选取
        UIImagePickerController *imagePicker  = [[UIImagePickerController alloc] init];
        imagePicker.delegate =self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing =YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } handler3:^(UIAlertAction *action) {
        NSLog(@"取消");
    }];

}
//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize

{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    
    //UIImagePickerControllerOriginalImage
    //初始化imageNew为从相机中获得的--
    UIImage *imageNew = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //设置image的尺寸
    CGSize imagesize = imageNew.size;
    
    //对图片大小进行压缩--
    imageNew = [self imageWithImage:imageNew scaledToSize:imagesize];
    
    NSData *photoData=UIImageJPEGRepresentation(imageNew,0.5);
//    UIImage *imageee=[UIImage imageWithData:photoData];
//    [photo setBackgroundImage:imageee forState:UIControlStateNormal];

    [self updateUserPhotoWithImage:photoData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)updateUserPhotoWithImage:(NSData *)photoData
{
    
    
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString * urlString = THUMB;
    NSDictionary* dic = @{@"userid":[ZCUserData share].userId,
                          @"upfile":photoData,};
    if (photoData.length==0) {
        NSLog(@"photoData==%@",photoData);
    }else{
        
        [manager POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
         {
             [formData appendPartWithFileData:photoData name:@"upfile" fileName:@"1.jpg" mimeType:@"image/jpeg"];
             
         } success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSString *  str =[NSString  stringWithFormat:@"%@",[responseObject objectForKey:@"error"]];
             if ([str isEqualToString:@"1"]) {
                 [self xiaojiadeTishiTitle:@"上传失败"];
             }else{
                 
                 [photo sd_setBackgroundImageWithURL:[NSURL URLWithString:[responseObject objectForKey:@"thumb"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"头像"]];
                 [self xiaojiadeTishiTitle:@"上传成功"];
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@",error);
         }];
    }
    
}

@end
