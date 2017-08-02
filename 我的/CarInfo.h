//
//  CarInfo.h
//  ZuChe
//
//  Created by JYD DE MAC on 16/3/8.
//  Copyright © 2016年 佐途. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarInfo : NSObject

@property(nonatomic,strong)NSString*cargonglione;
@property(nonatomic,strong)NSString*carid;
@property(nonatomic,strong)NSString*carmoneyone;
@property(nonatomic,strong)NSString*models;
@property(nonatomic,strong)NSString*plate;
@property(nonatomic,strong)NSString*thumb;
@property(nonatomic,strong)NSMutableDictionary* pingjia;

//cargonglione = "5\U516c\U91cc5\U5c0f\U65f6";
//carid = 76;
//carmoneyone = 123;
//models = "\U5b9d\U9a6c5\U7cfb";
//plate = "\U6caaB88888";
//thumb = "http://zuche.ztu.wang/uploadfile/carinfo/14568304634114.jpg";
;
+(CarInfo*)paramWithDictionary:(NSDictionary *)dict;

@end
