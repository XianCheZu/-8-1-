//
//  ViewController.m
//  LocationMap
//  Created by Alesary on 15/11/24.
//  Copyright © 2015年 Mr.Chen. All rights reserved.


//************须知************//
/*
 
 1.在"Info.plist"中进行如下配置
 <key>NSAppTransportSecurity</key>
 <dict>
 <key>NSAllowsArbitraryLoads</key>
 <true/>
 </dict>
 
 2.在"Info.plist"中进行如下配置
 NSLocationWhenInUseUsageDescription  YES
 NSLocationAlwaysUsageDescription    YES
 
 
 
 */


#import "jxyViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入搜索功能所有的头文件


//设备物理尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
#define Myuser [NSUserDefaults standardUserDefaults]
@interface jxyViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    BMKMapView *_mapView;
    
    UIImageView *_bomeImage;
    
    BMKPinAnnotationView *newAnnotation;
    
    BMKGeoCodeSearch *_geoCodeSearch;
    
    BMKReverseGeoCodeOption *_reverseGeoCodeOption;
    
    BMKLocationService *_locService;
    
    NSMutableArray *_addArray;
    
    UITableView *_tableView;


    bool isGeoSearch;

}

@end

@implementation jxyViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate=self;
    _geoCodeSearch.delegate=self;
    _locService.delegate = self;
    self.tabBarController.tabBar.hidden =YES;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; //不用时，置nil
    _geoCodeSearch.delegate=nil;
    _locService.delegate = nil;
    self.tabBarController.tabBar.hidden =NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _addArray=[NSMutableArray array];
    _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];

    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_width*0.13)];
    view.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:view];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, screen_width*0.13)];
    searchBar.placeholder = @"搜索";
    searchBar.delegate=self;
    [view addSubview:searchBar];
    [self initLocationService];
    [self initMap];
    [self initTableView];
    [self initBomeImage];
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"5");
    //正在编辑
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    //    NSLog(@"123");
    
    NSLog(@"%@",searchBar.text);
    [self theJianSuo:@"上海" addrText:searchBar.text];

}

//放置中间大头针
-(void)initBomeImage
{
    if (_bomeImage==nil) {
        
        _bomeImage=[[UIImageView alloc]initWithFrame:CGRectMake(screen_width/2-25, (screen_width*0.7)/2-50, 50, 50)];
        _bomeImage.image=[UIImage imageNamed:@"pic_pin_serach_MapModel"];
    }
    [_mapView addSubview:_bomeImage];
}
//初始化显示列表


-(void)initTableView
{
    if (_tableView==nil) {
        
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, screen_width*0.7, screen_width, screen_height-screen_width*0.7) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[[UIView alloc]init];
        
    }
    [self.view addSubview:_tableView];
}

-(void)initMap
{
    if (_mapView==nil) {
        
        _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_width*0.7)];
        
        [_mapView setMapType:BMKMapTypeStandard];// 地图类型 ->卫星／标准、
        
        _mapView.zoomLevel=19;
        
        _mapView.showsUserLocation = YES;
        
        
      
    }
    
    _mapView.delegate=self;
    
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(121, 112);
    
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(screen_width*0.05, screen_width*0.55, screen_width*0.08, screen_width*0.08);

    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"未标题-1"] forState:UIControlStateNormal];
    [_mapView addSubview:button];
    
    
    
    [self.view addSubview:_mapView];

}
-(void)btnClick
{
    [_locService startUserLocationService];
}
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
//        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        NSString* titleStr;
        NSString* showmeg;
        
        titleStr = @"搜索成功";
        showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",item.coordinate.latitude,item.coordinate.longitude];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
    }
}
-(void)theJianSuo:(NSString * )_cityText addrText:(NSString *)_addrText
{
    isGeoSearch = true;
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= _cityText;
    geocodeSearchOption.address = _addrText;
    BOOL flag = [_geoCodeSearch geoCode:geocodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    AddressDetailCell *cell=[tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"666=%@",[_addArray[indexPath.row] name]);
    
}
-(void)initLocationService
{
    if (_locService==nil) {
        
        _locService = [[BMKLocationService alloc]init];
        
        [_locService setDesiredAccuracy:kCLLocationAccuracyBest];
    }
    
    _locService.delegate = self;
    
    [_locService startUserLocationService];
    
}
#pragma mark BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //设置地图中心为用户经纬度
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate = userLocation.location.coordinate;
    [_locService stopUserLocationService];
    
}

#pragma mark BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //屏幕坐标转地图经纬度
    CLLocationCoordinate2D MapCoordinate=[_mapView convertPoint:_mapView.center toCoordinateFromView:_mapView];
    
    if (_geoCodeSearch==nil) {
        //初始化地理编码类
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
        _geoCodeSearch.delegate = self;
        
    }
    if (_reverseGeoCodeOption==nil) {
        
        //初始化反地理编码类
        _reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    }
    
    //需要逆地理编码的坐标位置
    _reverseGeoCodeOption.reverseGeoPoint =  CLLocationCoordinate2DMake(MapCoordinate.latitude,MapCoordinate.longitude);
    [_geoCodeSearch reverseGeoCode:_reverseGeoCodeOption];
    
}

#pragma mark BMKGeoCodeSearchDelegate

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //获取周边用户信息
//    if (error==BMK_SEARCH_NO_ERROR) {
//        [_addArray removeAllObjects];
//        for(BMKPoiInfo *poiInfo in result.poiList)
//        {
//            Place *place=[[Place alloc]init];
//            place.name=poiInfo.name;
//            place.address=poiInfo.address;
//            
//            [_addArray addObject:place];
//            [_tableView reloadData];
//        }
//    }else{
//        
//        NSLog(@"BMKSearchErrorCode: %u",error);
//    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _addArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    static NSString *identfire=@"cellID";
////    
////    AddressDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
////    
////    if (!cell) {
////        
////        cell=[[[NSBundle mainBundle] loadNibNamed:@"AddressDetailCell" owner:nil options:nil] firstObject];
////        cell.selectionStyle=UITableViewCellSelectionStyleNone;
////    }
////    
////    cell.place=_addArray[indexPath.row];
////    
////    return cell;
//}

//设置cell分割线做对齐
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews {
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


@end
