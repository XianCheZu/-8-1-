//
//  DropDownListViewController.m
//  DropDownList
//
//  Created by kingyee on 11-9-19.
//  Copyright 2011 Kingyee. All rights reserved.
//
#define   HISTORY_SEARCH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/historySearch.plist"]
#import "DropDownListViewController.h"
#import "DDList.h"
#import "AllPages.pch"
#import "SOUSUOViewController.h"
#import "UILabel+SizeLabel.h"
#import "TPLChooseItemsView.h"
@implementation DropDownListViewController

@synthesize _searchStr;

-(void)viewWillAppear:(BOOL)animated
{
    //    [self setDDListHidden:YES];
    [super viewWillAppear:animated];
    [self historySearchStrArr];
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden =NO;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithTitle:@"搜索"];
    [_searchBar becomeFirstResponder];
    _searchStr = [[NSString alloc] initWithString:@""];
    
    //    _ddList = [[DDList alloc] initWithStyle:UITableViewStylePlain];
    //    _ddList._delegate = self;
    //    [_ddList.view setFrame:CGRectMake(Height(10), 36, self.view.frame.size.width-Height(60), 0)];
    
    
    
    
    
    [self initSegmentedControl];
    
}
- (void)initSegmentedControl
{
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"热门搜索",@"历史记录",nil];
    UISegmentedControl * segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.frame =CGRectMake(Height(50),Height(50), ScreenWidth-Height(100),Height(30));
    /*
     这个是设置按下按钮时的颜色
     */
    //    [UIColor colorWithRed:0 green:0.66 blue:0.933 alpha:1.00]
    segmentedControl.tintColor =Color(63, 65, 76);
    segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引
    UIColor *jiedancolor=Color(46, 51, 61)//红
    
    /*
     下面的代码实同正常状态和按下状态的属性控制,比如字体的大小和颜色等
     */
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,jiedancolor, NSForegroundColorAttributeName,nil];
    
    
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:jiedancolor forKey:NSForegroundColorAttributeName];
    
    [segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    //设置分段控件点击相应事件
    [segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmentedControl];
    partview=[[UIView alloc]initWithFrame:CGRectMake(0, Height(81), ScreenWidth, ScreenHeight-Height(80))];
    [HttpManager postData:nil andUrl:HOT_WORLD success:^(NSDictionary *fanhuicanshu) {
        
        if (fanhuicanshu.count==0) {
            
        }else
        {
            NSArray *arr=(NSArray *)fanhuicanshu;
            
            Hotarray= [NSMutableArray array];
            for (int i=0; i<fanhuicanshu.count; i++) {
                NSString *rrr=[arr[i]objectForKey:@"search"];
                [Hotarray addObject:rrr];
                
            }
            [self remen];
        }
        
 
    } Error:^(NSString *cuowuxingxi) {
        
    }];
    
}
-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    switch (Index)
    {
        case 0:
            [self.tableView removeFromSuperview];
            [HttpManager postData:nil andUrl:HOT_WORLD success:^(NSDictionary *fanhuicanshu) {
                
                if (fanhuicanshu.count==0) {
                    
                }else
                {
                    NSArray *arr=(NSArray *)fanhuicanshu;
                    
                    Hotarray= [NSMutableArray array];
                    for (int i=0; i<fanhuicanshu.count; i++) {
                        NSString *rrr=[arr[i]objectForKey:@"search"];
                        [Hotarray addObject:rrr];
                        
                    }
                    [self remen];
                }
            } Error:^(NSString *cuowuxingxi) {
                
            }];
            
            break;
        case 1:
            [_chooseItemsView removeFromSuperview];
            [self tabelViews];
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}
-(void)tabelViews
{
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth,ScreenHeight-Height(90)-Height(64))];
    self.tableView.delegate = self;
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.dataSource =self;
    [partview addSubview:self.tableView];
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  ScreenWidth*0.1;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _historySearchStrArr.count;
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, ScreenWidth*0.1)];
        label.textAlignment =NSTextAlignmentLeft;
        label.tag = 1000;
        label.textColor =[UIColor grayColor];
        label.font =[UIFont systemFontOfSize:13.0f];
        [cell.contentView  addSubview: label];
        
    }
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:1000];
    label.text = _historySearchStrArr[indexPath.row];
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0,ScreenWidth, ScreenWidth*0.1);
    [button setTitle:@"清除所有记录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(removeAllBtn) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor=[UIColor colorWithRed:0 green:0.66 blue:0.933 alpha:1.00];
    //这是设置一边有圆角的代码
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.path = [[self getPath:0] CGPath];
    button.layer.mask = shapLayer;
    button.titleLabel.font=Font(13);
    self.tableView.tableFooterView =button;
    
    
    return cell ;
}
//画一个按钮出来
- (UIBezierPath *)getPath:(NSInteger)num
{
    switch (num)
    {
        case 0:
        {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(Height(10),Height(2))];
            [path addLineToPoint:CGPointMake(Height(12), 0)];
            [path addLineToPoint:CGPointMake(Height(310), 0)];
            [path addLineToPoint:CGPointMake(Height(312), Height(2))];
            [path addLineToPoint:CGPointMake(Height(312),ScreenWidth*0.1-Height(2))];
            [path addLineToPoint:CGPointMake(Height(310),ScreenWidth*0.1)];
            [path addLineToPoint:CGPointMake(Height(12),ScreenWidth*0.1)];
            [path addLineToPoint:CGPointMake(Height(10),ScreenWidth*0.1-Height(2))];
            [path closePath];
            return path;
        }
            break;
        default:
            return nil;
            break;
    }
}
-(void)removeAllBtn
{
    NSFileManager *fileManage = [NSFileManager defaultManager];
    if (![fileManage fileExistsAtPath:HISTORY_SEARCH]) {
        [fileManage createDirectoryAtPath:HISTORY_SEARCH withIntermediateDirectories:YES attributes:nil error:nil];
    }else{
        
        [fileManage removeItemAtPath:HISTORY_SEARCH error:nil];
        
    }
    [self performSelector:@selector(demaxiya) withObject:nil afterDelay:0.1];
}
-(void)demaxiya
{
    _historySearchStrArr = [[NSMutableArray alloc] initWithContentsOfFile:HISTORY_SEARCH];
    [self.tableView removeFromSuperview];
}
-(void)remen
{
    
    /* tpl 使用方法 */
    _chooseItemsView = [[TPLChooseItemsView alloc] initWithFrame:CGRectMake(Height(10),Height(10), ScreenWidth-Height(20),ScreenHeight-Height(90))];
    _chooseItemsView.backgroundColor = [UIColor whiteColor];
    [partview addSubview:_chooseItemsView];
//    NSMutableArray * titleArray = [Hotarray mutableCopy];
    
    //    [titleArray addObjectsFromArray:Hotarray];
    
    _chooseItemsView.titleArray = Hotarray;
    _chooseItemsView.bianqian=^(NSString *aa){
        SOUSUOViewController *sec=[[SOUSUOViewController alloc]init];
        sec.search=aa;
        [self.navigationController pushViewController:sec animated:YES];
    };
    _chooseItemsView.itemHeight = Height(20);
    _chooseItemsView.itemFont =Font(10);
    _chooseItemsView.xSpace = Height(10);
    _chooseItemsView.ySpace = Height(10);
    _chooseItemsView.itemWidth = (ScreenWidth - Height(10))/3;
    _chooseItemsView.isNeat = YES;
    _chooseItemsView.isFitLength = YES;
    _chooseItemsView.isMutableChoose = NO;
    _chooseItemsView.itemChooseColor = Color(246, 99, 107)
    ;
    _chooseItemsView.itemNormalColor = [UIColor grayColor];
    [_chooseItemsView clickedItemIndex:2];
    /* tpl 使用方法 */
    [self.view addSubview:partview];}
-(void)btnClick1:(UIButton *)sender
{
    
    SOUSUOViewController *sec=[[SOUSUOViewController alloc]init];
    sec.search=[(UIButton *)sender currentTitle];
    [self.navigationController pushViewController:sec animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    //    [_ddList release];
    [_searchStr release];
    [super dealloc];
}

//- (void)setDDListHidden:(BOOL)hidden {
//    NSInteger height = hidden ? 0 : Height(180);
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:.2];
//    [_ddList.view setFrame:CGRectMake(Height(10), 36, self.view.frame.size.width-Height(60), height)];
//    [UIView commitAnimations];
//}

#pragma mark -
#pragma mark PassValue protocol
- (void)passValue:(NSString *)value{
    if (value) {
        
        _searchBar.text = value;
        [self searchBarSearchButtonClicked:_searchBar];
        SOUSUOViewController *sec=[[SOUSUOViewController alloc]init];
        sec.search=value;
        [self.navigationController pushViewController:sec animated:YES];
        
        
    }
    else {
        
    }
}

#pragma mark -
#pragma mark SearchBar Delegate Methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] != 0) {
        //        _ddList._searchText = searchText;
        //        [_ddList updateData];
        //        [self.view addSubview:_ddList.view];
        //        [self setDDListHidden:NO];
    }
    else {
        //        [self setDDListHidden:YES];
        
    }
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    for(id cc in [searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
            //            btn.titleLabel.font=Font(13);
            //            [btn setTitleColor:[UIColor colorWithRed:0 green:0.66 blue:0.933 alpha:1.00] forState:UIControlStateNormal];
        }
    }
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.text = @"";
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    searchBar.text = @"";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //    [self setDDListHidden:YES];
    self._searchStr = [searchBar text];
    [searchBar resignFirstResponder];
    
    NSLog(@"最终结果:%@",self._searchStr);
    [self doSearch:searchBar];
    __block NSUInteger stringIndex;
    __block BOOL isReloadArr = YES;
    //    [self.historySearchStrArr enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
    //        if ([searchBar.text isEqualToString:obj]) {
    //            stringIndex = idx;
    //            isReloadArr = NO;
    //        }
    //    }];
    if (isReloadArr == YES) {
        if (self.historySearchStrArr.count==10) {
            [self.historySearchStrArr removeLastObject];
        }
        [self.historySearchStrArr insertObject:_searchStr atIndex:0];
    }else
    {
        [self.historySearchStrArr removeObjectAtIndex:stringIndex];
        [self.historySearchStrArr insertObject:_searchStr atIndex:0];
    }
    
    [self.historySearchStrArr writeToFile:HISTORY_SEARCH atomically:YES];
    
    
    
    SOUSUOViewController *sec=[[SOUSUOViewController alloc]init];
    sec.search=self._searchStr;
    [self.navigationController pushViewController:sec animated:YES];
    
    [self.tableView reloadData];
}
- (NSMutableArray *)historySearchStrArr
{
    if (!_historySearchStrArr) {
        _historySearchStrArr = [[NSMutableArray alloc] initWithContentsOfFile:HISTORY_SEARCH];
        
        
        if (_historySearchStrArr == nil) {
            _historySearchStrArr = [[NSMutableArray alloc] initWithCapacity:0];
        }
    }
    
    return _historySearchStrArr;
    
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    //    [self setDDListHidden:YES];
    [searchBar resignFirstResponder];
}
//这里点击搜索按钮搜索
- (void)doSearch:(UISearchBar *)searchBar{
    NSLog(@"这里放搜索接口:%@",searchBar.text);
    
}
//这里点击历史记录搜索
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击历史记录搜索");
    
    SOUSUOViewController *sec=[[SOUSUOViewController alloc]init];
    sec.search=self.historySearchStrArr[indexPath.row];
    [self.navigationController pushViewController:sec animated:YES];
    
}

@end
