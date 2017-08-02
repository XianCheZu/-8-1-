//
//  MultilevelMenu.m
//  MultilevelMenu
//
//  Created by gitBurning on 15/3/13.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import "MultilevelMenu.h"
#import "MultilevelTableViewCell.h"
#import "jiaTableViewCell.h"
#import "UIImageView+WebCache.h"

#define kCellRightLineTag 100
#define kImageDefaultName @"tempShop"
#define kMultilevelCollectionViewCell @"MultilevelCollectionViewCell"
#define kMultilevelCollectionHeader   @"CollectionHeader"//CollectionHeader
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface MultilevelMenu()

@property(strong,nonatomic ) UITableView * leftTablew;
@property(strong,nonatomic ) UITableView * rightTablew;

@property(assign,nonatomic) BOOL isReturnLastOffset;

@end
@implementation MultilevelMenu

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(instancetype)initWithFrame:(CGRect)frame WithData:(NSArray *)data withSelectIndex:(void (^)(NSInteger, NSInteger, id))selectIndex
{
    self=[super initWithFrame:frame];
    if (self) {
        if (data.count==0) {
            return nil;
        }
        
        _block=selectIndex;
        self.leftSelectColor=[UIColor blackColor];
        self.leftSelectBgColor=[UIColor whiteColor];
        self.leftBgColor=UIColorFromRGB(0xF3F4F6);
        self.leftSeparatorColor=UIColorFromRGB(0xE5E5E5);
        self.leftUnSelectBgColor=UIColorFromRGB(0xF3F4F6);
        self.leftUnSelectColor=[UIColor blackColor];
        
        _selectIndex=0;
        _allData=data;
        
        
        /**
         左边的视图
         */
        self.leftTablew=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, frame.size.height)];
        self.leftTablew.dataSource=self;
        self.leftTablew.delegate=self;
        
        self.leftTablew.tableFooterView=[[UIView alloc] init];
        [self addSubview:self.leftTablew];
        self.leftTablew.backgroundColor=self.leftBgColor;
        if ([self.leftTablew respondsToSelector:@selector(setLayoutMargins:)]) {
            self.leftTablew.layoutMargins=UIEdgeInsetsZero;
        }
        if ([self.leftTablew respondsToSelector:@selector(setSeparatorInset:)]) {
            self.leftTablew.separatorInset=UIEdgeInsetsZero;
        }
        self.leftTablew.separatorColor=self.leftSeparatorColor;
        
        //右边的试图
        self.rightTablew=[[UITableView alloc] initWithFrame:CGRectMake(kLeftWidth, 0, kScreenWidth-kLeftWidth, frame.size.height)];
        self.rightTablew.dataSource=self;
        self.rightTablew.separatorStyle=UITableViewCellSelectionStyleNone;
        self.rightTablew.delegate=self;
        
        [self addSubview:self.rightTablew];
        
        //        self.isReturnLastOffset=YES;
        //        
        //        self.rightTablew.backgroundColor=self.leftSelectBgColor;
        
        //        self.backgroundColor=self.leftSelectBgColor;
        
        
        
    }
    return self;
}

-(void)setNeedToScorllerIndex:(NSInteger)needToScorllerIndex{
    
    /**
     *  滑动到 指定行数
     */
    [self.leftTablew selectRowAtIndexPath:[NSIndexPath indexPathForRow:needToScorllerIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    _selectIndex=needToScorllerIndex;
    
    [self.rightTablew reloadData];
    
    _needToScorllerIndex=needToScorllerIndex;
}
-(void)setLeftBgColor:(UIColor *)leftBgColor{
    _leftBgColor=leftBgColor;
    self.leftTablew.backgroundColor=leftBgColor;
    
}
-(void)setLeftSelectBgColor:(UIColor *)leftSelectBgColor{
    
    _leftSelectBgColor=leftSelectBgColor;
    //    self.rightTablew.backgroundColor=leftSelectBgColor;
    
    self.backgroundColor=leftSelectBgColor;
}
-(void)setLeftSeparatorColor:(UIColor *)leftSeparatorColor{
    _leftSeparatorColor=leftSeparatorColor;
    self.leftTablew.separatorColor=leftSeparatorColor;
}
-(void)reloadData{
    
    [self.leftTablew reloadData];
    [self.rightTablew reloadData];
    
}
-(void)setLeftTablewCellSelected:(BOOL)selected withCell:(MultilevelTableViewCell*)cell
{
    UILabel * line=(UILabel*)[cell viewWithTag:kCellRightLineTag];
    if (selected) {
        
        line.backgroundColor=cell.backgroundColor;
        cell.titile.textColor=self.leftSelectColor;
        cell.backgroundColor=self.leftSelectBgColor;
    }
    else{
        cell.titile.textColor=self.leftUnSelectColor;
        cell.backgroundColor=self.leftUnSelectBgColor;
        line.backgroundColor=_leftTablew.separatorColor;
    }
    
    
}

#pragma mark---左边的tablew 代理
#pragma mark--deleagte
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    CGFloat nu=0.0;
    if (tableView==self.rightTablew) {
        
        nu=26;
        
    }else if(self.leftTablew)
    {
        nu=self.allData.count;
        
    }
    return nu;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * Identifier=@"MultilevelTableViewCell";
    MultilevelTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (tableView==self.leftTablew) {
        if (!cell) {
            cell=[[NSBundle mainBundle] loadNibNamed:@"MultilevelTableViewCell" owner:self options:nil][0];
            
            UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(kLeftWidth-0.5, 0, 0.5, 44)];
            label.backgroundColor=tableView.separatorColor;
            [cell addSubview:label];
            label.tag=kCellRightLineTag;
        }
        
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        rightMeun * title=self.allData[indexPath.row];
        
        cell.titile.text=title.meunName;
        
        
        if (indexPath.row==self.selectIndex) {
            
            [self setLeftTablewCellSelected:YES withCell:cell];
        }
        else{
            [self setLeftTablewCellSelected:NO withCell:cell];
            
            
            
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            cell.layoutMargins=UIEdgeInsetsZero;
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset=UIEdgeInsetsZero;
        }
        
        
        return cell;
        
    }
    else if (self.rightTablew)
    {
        if (!cell) {
            
            
            cell=[[NSBundle mainBundle] loadNibNamed:@"jiaTableViewCell" owner:self options:nil][0];
            
            
        }
        
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        rightMeun * title=self.allData[self.selectIndex];
        NSArray * list;
        
        
        
        rightMeun * meun=title.nextArray[indexPath.section];
        
        if (meun.nextArray.count>0) {
            meun=title.nextArray[indexPath.section];
            list=meun.nextArray;
            meun=list[indexPath.row];
        }
        
        cell.titile.text=[NSString stringWithFormat:@"%c",'A'+indexPath.row];
        
        
        
        cell.backgroundColor=[UIColor clearColor];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat num=0.0f;
    if (tableView==self.rightTablew) {
        
        num= 44;
        
    }else if(tableView==self.leftTablew)
    {
        num= 44;
    }
    return num;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.leftTablew) {
        MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        _selectIndex=indexPath.row;
        
        [self setLeftTablewCellSelected:YES withCell:cell];
        
        rightMeun * title=self.allData[indexPath.row];
        
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        self.isReturnLastOffset=NO;
        
        
        [self.rightTablew reloadData];
        
        
        if (self.isRecordLastScroll) {
            [self.rightTablew scrollRectToVisible:CGRectMake(0, title.offsetScorller, self.rightTablew.frame.size.width, self.rightTablew.frame.size.height) animated:self.isRecordLastScrollAnimated];
        }
        else{
            
            [self.rightTablew scrollRectToVisible:CGRectMake(0, 0, self.rightTablew.frame.size.width, self.rightTablew.frame.size.height) animated:self.isRecordLastScrollAnimated];
        }
        NSLog(@"第%ld行",indexPath.row);
    }if(tableView==self.rightTablew)
    {
        
        rightMeun * title=self.allData[self.selectIndex];
        NSArray * list;
        
        
        
        
        rightMeun * meun;
        
        meun=title.nextArray[indexPath.section];
        
        if (meun.nextArray.count>0) {
            meun=title.nextArray[indexPath.section];
            list=meun.nextArray;
            meun=list[indexPath.row];
        }
        
        
        void (^select)(NSInteger left,NSInteger right,id info) = self.block;
        
        select(self.selectIndex,indexPath.row,meun);
        
        NSString *jiaxianyue=[NSString stringWithFormat:@"%c",'A'+indexPath.row];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dizhi_xq" object:jiaxianyue];
        
        
        
    }
    
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    
    [self setLeftTablewCellSelected:NO withCell:cell];
    
    cell.backgroundColor=self.leftUnSelectBgColor;
}


#pragma mark---记录滑动的坐标
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.rightTablew]) {
        
        self.isReturnLastOffset=YES;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:self.rightTablew]) {
        
        rightMeun * title=self.allData[self.selectIndex];
        
        title.offsetScorller=scrollView.contentOffset.y;
        
        self.isReturnLastOffset=NO;
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.rightTablew]) {
        
        rightMeun * title=self.allData[self.selectIndex];
        
        title.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:self.rightTablew] && self.isReturnLastOffset) {
        rightMeun * title=self.allData[self.selectIndex];
        
        title.offsetScorller=scrollView.contentOffset.y;
        
        
    }
}



#pragma mark--Tools
-(void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@end



@implementation rightMeun



@end
