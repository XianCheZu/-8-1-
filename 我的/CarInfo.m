//
//  CarInfo.m
//  ZuChe
//
//  Created by JYD DE MAC on 16/3/8.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import "CarInfo.h"

@implementation CarInfo
+(CarInfo*)paramWithDictionary:(NSDictionary *)dict
{
    //cargonglione = "5\U516c\U91cc5\U5c0f\U65f6";
    //carid = 76;
    //carmoneyone = 123;
    //models = "\U5b9d\U9a6c5\U7cfb";
    //plate = "\U6caaB88888";
    //thumb = "http://zuche.ztu.wang/uploadfile/carinfo/14568304634114.jpg";
    CarInfo * info = [[CarInfo alloc]init];
    info.cargonglione = [dict objectForKey:@"cargonglione"];
    info.carid = [dict objectForKey:@"carid"];
    info.carmoneyone = [dict objectForKey:@"carmoneyone"];
    info.models = [dict objectForKey:@"models"];
    info.plate = [dict objectForKey:@"plate"];
    info.thumb = [dict objectForKey:@"thumb"];
    info.pingjia = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",@"fuwu",@"",@"chekuang",@"",@"shoushi", nil];

    
    return info;
}
@end
