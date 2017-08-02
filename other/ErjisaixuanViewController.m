//
//  ViewController.m
//  kxmenu
//
//  Created by Kolyvan on 17.05.13.
//  Copyright (c) 2013 Konstantin Bukreev. All rights reserved.
//
#define Color(a,b,c)  [UIColor colorWithRed:a/255.0 green:b/255.0  blue:c/255.0  alpha:1.0];
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define Font(F) [UIFont fontWithName:@"STHeitiSC-Light" size:(F)/320.0*ScreenWidth]
#import "ErjisaixuanViewController.h"
#import "KxMenu.h"
#import "AllPages.pch"
@interface ErjisaixuanViewController ()

@end

@implementation ErjisaixuanViewController{
    NSArray *menuItems0;
    NSArray *menuItems1;
    NSArray *menuItems;
    UIButton * _tmpBtn;
    int j;
    int j0;
    int j1;
    int aniu0;
    int aniu1;
    int aniu2;
    NSString *shou;
    NSMutableArray * array;
    NSMutableArray * imagearray;
    UIImageView *image;
    NSString *imagearr;
    KxMenuOverlay *kx;
    NSString *titleimage3;
    NSString *titleimage2;
    NSString *titleimage1;
    NSString *selecarray;
}
-(NSString *)Title1
{
    if (!_Title1) {
        _Title1=[[NSString alloc]init];
    }
    return _Title1;
}
-(NSString *)Title2
{
    if (!_Title2) {
        _Title2=[[NSString alloc]init];
    }
    return _Title2;
}
-(NSString *)Title3
{
    if (!_Title3) {
        _Title3=[[NSString alloc]init];
    }
    return _Title3;
}
-(void)setFont:(CGFloat)font
{
    [UIFont systemFontOfSize:ScreenWidth*(font/320)];
    
}
- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self button];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(handleColorChange:) name:@"ChangeDizhiNotification" object:nil];
    selecarray=[[NSString alloc] init];
}
-(void)button
{
    
    const CGFloat W = self.view.bounds.size.width;
    UIColor *colo=Color(64, 64, 64)
    UIColor *color1=Color(18, 152, 233);
    array = [NSMutableArray arrayWithObjects:@"颜色",@"牌照",@"排序",nil];
    for (int i = 0; i<3; i ++) {
        
        UILabel *xian=[[UILabel alloc]initWithFrame:CGRectMake(W/3*i-1, 10, 0.5, 20)];
        xian.backgroundColor=[UIColor colorWithRed:81/255 green:81/255 blue:81/255 alpha:0.5];
        xian.alpha=0.4;
        [self.view addSubview:xian];
        _tmpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tmpBtn.frame=CGRectMake(W/3*i,0, W/3, 35);
        _tmpBtn.userInteractionEnabled=YES;
        UIImageView  *iimage=[[UIImageView alloc]init];
        iimage.image=[UIImage imageNamed:@"二级筛选_下"];
        iimage.userInteractionEnabled=YES;
        UIImageView  *iimage1=[[UIImageView alloc]init];
        iimage1.image=[UIImage imageNamed:@"二级筛选_上上"];
        iimage1.userInteractionEnabled=YES;
        [_tmpBtn setImage:iimage.image forState:UIControlStateNormal];
        [_tmpBtn setImage:iimage1.image forState:UIControlStateSelected];
        
        [_tmpBtn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [_tmpBtn setTitleColor:colo forState:UIControlStateNormal];
        [_tmpBtn setTitleColor:color1 forState:UIControlStateSelected];
        [_tmpBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0,25 )];
        [_tmpBtn setImageEdgeInsets:UIEdgeInsetsMake(0,40 ,0,-40 )];
        [_tmpBtn.titleLabel setFont:Font(12.5)];
        _tmpBtn.tag=i;
        _tmpBtn.userInteractionEnabled = YES;
        [_tmpBtn addTarget:self action:@selector(btnt:) forControlEvents:UIControlEventTouchUpInside];
        [_tmpBtn setBackgroundColor:[UIColor whiteColor]];
        [_tmpBtn setTag:i];
        _tmpBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self.view addSubview:_tmpBtn];
    }
    UILabel *xian1=[[UILabel alloc]initWithFrame:CGRectMake(0, 34.6, ScreenWidth, 0.3)];
    xian1.backgroundColor=[UIColor colorWithRed:81/255 green:81/255 blue:81/255 alpha:0.5];
    xian1.alpha=0.4;
    [self.view addSubview:xian1];
    
}

-(void)btnt:(UIButton *)sender
{
    //     if ([[NSString stringWithFormat:@"%ld",(long)btn.tag]intValue]==0)
    switch(sender.tag){
        case 0:{
            
            menuItems0 =
            @[
              
              [KxMenuItem menuItem:@"黑色"
                             image:[UIImage imageNamed:@"黑色"]
                            target:self
                            action:@selector(pushMenuItem0:)],
              
              [KxMenuItem menuItem:@"白色"
                             image:[UIImage imageNamed:@"白色"]
                            target:self
                            action:@selector(pushMenuItem0:)],
              
              [KxMenuItem menuItem:@"红色"
                             image:[UIImage imageNamed:@"红色"]
                            target:self
                            action:@selector(pushMenuItem0:)],
              
              [KxMenuItem menuItem:@"金色"
                             image:[UIImage imageNamed:@"金色"]
                            target:self
                            action:@selector(pushMenuItem0:)],
              
              [KxMenuItem menuItem:@"其他色"
                             image:[UIImage imageNamed:@"其他色"]
                            target:self
                            action:@selector(pushMenuItem0:)],
              [KxMenuItem menuItem:@"显示全部"
                             image:[UIImage imageNamed:@"1 (7)1"]
                            target:self
                            action:@selector(pushMenuItem0:)],
              
              ];
            
            if (aniu0==0) {//此方法用于判断首次点击按钮,冒泡弹窗都是默认的灰色
                
            }else
            {
                KxMenuItem *first = menuItems0[j0];
                
                
                first.foreColor = Color(18, 152, 233);;
                first.alignment = NSTextAlignmentLeft;
                first.seleimage=[UIImage imageNamed:titleimage1];
                
            }
            
            [KxMenu showMenuInView:self.view
                          fromRect:sender.frame
                         menuItems:menuItems0];
            
        }break;
        case 1:{
            
            menuItems1 =
            @[
              [KxMenuItem menuItem:@"本地"
                             image:[UIImage imageNamed:@"1 (8)1"]
                            target:self
                            action:@selector(pushMenuItem1:)],
              
              [KxMenuItem menuItem:@"无4 (本地)"
                             image:[UIImage imageNamed:@"1 (9)1"]
                            target:self
                            action:@selector(pushMenuItem1:)],
              
              [KxMenuItem menuItem:@"外地"
                             image:[UIImage imageNamed:@"1 (10)1"]
                            target:self
                            action:@selector(pushMenuItem1:)],
              
              [KxMenuItem menuItem:@"无4 (外地)"
                             image:[UIImage imageNamed:@"1 (1)1"]
                            target:self
                            action:@selector(pushMenuItem1:)],
              [KxMenuItem menuItem:@"显示全部"
                             image:[UIImage imageNamed:@"1 (7)1"]
                            target:self
                            action:@selector(pushMenuItem1:)],
              
              ];
            if (aniu1==0) {
                
            }else
            {
                KxMenuItem *first = menuItems1[j1];
                first.foreColor = Color(18, 152, 233);;
                first.alignment = NSTextAlignmentLeft;
                first.seleimage=[UIImage imageNamed:titleimage2];
            }
            
            
            [KxMenu showMenuInView:self.view
                          fromRect:sender.frame
                         menuItems:menuItems1];
        }break;
        case 2:{
            
            menuItems =
            @[
              
              [KxMenuItem menuItem:@"综合排序"
                             image:[UIImage imageNamed:@"1 (2)1"]
                            target:self
                            action:@selector(pushMenuItem:)],
              
              [KxMenuItem menuItem:@"价格低到高"
                             image:[UIImage imageNamed:@"1 (3)1"]
                            target:self
                            action:@selector(pushMenuItem:)],
              
              [KxMenuItem menuItem:@"接受率高"
                             image:[UIImage imageNamed:@"1 (4)1"]
                            target:self
                            action:@selector(pushMenuItem:)],
              
              [KxMenuItem menuItem:@"最高评价"
                             image:[UIImage imageNamed:@"1 (5)1"]
                            target:self
                            action:@selector(pushMenuItem:)],
              
              [KxMenuItem menuItem:@"次数最多"
                             image:[UIImage imageNamed:@"1_1"]
                            target:self
                            action:@selector(pushMenuItem:)],
//              [KxMenuItem menuItem:@"显示全部"
//                             image:[UIImage imageNamed:@"1 (7)1"]
//                            target:self
//                            action:@selector(pushMenuItem:)],
              ];
            if (aniu2==0) {
                
            }else
            {
                KxMenuItem *first = menuItems[j];
                first.foreColor = Color(18, 152, 233);;
                first.alignment = NSTextAlignmentLeft;
                first.seleimage=[UIImage imageNamed:titleimage3];
            }
            
            
            [KxMenu showMenuInView:self.view
                          fromRect:sender.frame
                         menuItems:menuItems];
            
        }break;
        default:
            break;
            
    }
    
    if (_tmpBtn == nil){
        
        sender.selected = YES;
        _tmpBtn = sender;
    }
    else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
        
    }
    else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        sender.selected = YES;
        _tmpBtn = sender;
    }
    
    
}

- (void) pushMenuItem0:(KxMenuItem*)sender
{
    aniu0+=1;
    
    _Title1=sender.title;
    titleimage1=sender.title;
    for( int i  =0; i<menuItems0.count; ++i) //n为数组长度
    {
        if([menuItems0[i] title] == sender.title) //temp为要查找 的元素
            j0=i; //i为该元素在数组中的位置
    }
    [array replaceObjectAtIndex:0 withObject:sender.title];
    [_tmpBtn setTitle:[array objectAtIndex:0] forState:UIControlStateNormal];
    if ([sender.title isEqualToString:@"显示全部"]){
        [_tmpBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0 ,0,-(self.view.frame.size.width)/3)];
    }else
    {
        [_tmpBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0 ,0,-(self.view.frame.size.width)/4.4)];
    }
    [GiFHUD dismiss];
    [self xiaosi];
}
- (void) pushMenuItem1:(KxMenuItem*)sender
{
    aniu1+=1;
    
    _Title2=sender.title;
    titleimage2=sender.title;
    for( int i  =0; i<menuItems1.count; ++i) //n为数组长度
    {
        if([menuItems1[i] title] == sender.title) //temp为要查找 的元素
            //i为该元素在数组中的位置
            j1=i;
        
    }
    [array replaceObjectAtIndex:1 withObject:sender.title];
    [_tmpBtn setTitle:[array objectAtIndex:1] forState:UIControlStateNormal];
    if ([sender.title isEqualToString:@"无4 (本地)"]||
        [sender.title isEqualToString:@"无4 (外地)"]){
        [_tmpBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0 ,0,-(self.view.frame.size.width)/2.8)];
    }else if([sender.title isEqualToString:@"显示全部"])
    {
        [_tmpBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0 ,0,-(self.view.frame.size.width)/3)];
    }else
    {
        [_tmpBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0 ,0,-(self.view.frame.size.width)/4)];
    }
    
    [GiFHUD dismiss];
    [self xiaosi];
}



- (void) pushMenuItem:(KxMenuItem*)sender
{
    aniu2+=1;
  
    _Title3=sender.title;
    titleimage3=sender.title;
    for( int i  =0; i<menuItems.count; ++i) //n为数组长度
    {
        if([menuItems[i] title] == sender.title) //temp为要查找 的元素
            j=i; //i为该元素在数组中的位置
    }
    [array replaceObjectAtIndex:2 withObject:sender.title];
    [_tmpBtn setTitle:[array objectAtIndex:2] forState:UIControlStateNormal];
    if ([sender.title isEqualToString:@"价格低到高"]){
        [_tmpBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0 ,0,-(self.view.frame.size.width)/2.5)];
    }else
    {
       [_tmpBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0 ,0,-(self.view.frame.size.width)/3)];
    }
    [GiFHUD dismiss];
    [self xiaosi];
}
-(void)xiaosi
{
   
    if ([_Title1 isKindOfClass:[NSNull class]]||_Title1==nil) {
        _Title1=@"all";
    }if ([_Title2 isKindOfClass:[NSNull class]]||_Title2==nil) {
        _Title2=@"all";
    }if ([_Title3 isKindOfClass:[NSNull class]]||_Title3 ==nil) {
        _Title3=@"all";
    }
    if ([_Title2 isEqualToString:@"无4 (本地)"]) {
        //与服务器字段保持一致
        _Title2=@"无四本地";
    }if ([_Title2 isEqualToString:@"无4 (外地)"]) {
        //与服务器字段保持一致
        _Title2=@"无四外地";
    }if ([_Title1 isEqualToString:@"显示全部"]) {
        _Title1=@"all";
    }if ([_Title2 isEqualToString:@"显示全部"]) {
        _Title2=@"all";
    }if ([_Title3 isEqualToString:@"综合排序"]) {
        _Title3=@"all";
    }
    selecarray=[NSString stringWithFormat:@"color:%@,plate:%@,paixu:%@",_Title1,_Title2,_Title3];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SECPAGETITLE" object:selecarray];
    
    
    
}
-(void)handleColorChange:(NSNotification*)not
{
    NSDictionary *userInfo = not.userInfo;
    shou = [userInfo objectForKey:@"stu"];
    if ([shou isEqualToString:@"1"]||[shou isKindOfClass:[NSNull class]]) {
        
        _tmpBtn.selected = NO;
        
    }else
    {
        _tmpBtn.selected = NO;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _tmpBtn.selected=NO;
}
@end
