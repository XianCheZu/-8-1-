//
//  LDCalendarView.m
//
//  Created by lidi on 15/9/1.
//  Copyright (c) 2015年 lidi. All rights reserved.
//

#import "LDCalendarView.h"
#import "NSDate+extend.h"
#define Color(a,b,c)  [UIColor colorWithRed:a/255.0 green:b/255.0  blue:c/255.0  alpha:1.0];
#define UNIT_WIDTH  45 * SCREEN_RAT

//行 列 每小格宽度 格子总数
static const NSInteger kRow = 7;
static const NSInteger kCol = 7;
static const NSInteger kTotalNum = (kRow - 1) * kCol;

@implementation UIColor (Extend)

+ (UIColor *)hexColorWithString:(NSString *)string
{
    return [UIColor hexColorWithString:string alpha:1.0f];
}

+ (UIColor *)hexColorWithString:(NSString *)string alpha:(float) alpha
{
    if ([string hasPrefix:@"#"]) {
        string = [string substringFromIndex:1];
    }
    
    NSString *pureHexString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([pureHexString length] != 6) {
        return [UIColor whiteColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [pureHexString substringWithRange:range];
    
    range.location += range.length ;
    NSString *gString = [pureHexString substringWithRange:range];
    
    range.location += range.length ;
    NSString *bString = [pureHexString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
@end

@interface LDCalendarView() {
    NSMutableArray *_currentMonthDateArray;
    NSMutableArray *_selectArray;
    
    UIView *_dateBgView;//日期的背景
    
    CGRect _touchRect;//可操作区域
    UIButton *_done; //确定按钮
    NSDictionary *userInfo;
}
@property (nonatomic, assign)int32_t month;
@property (nonatomic, assign)int32_t year;

@property (nonatomic, strong)NSDate *today; //今天0点的时间
@end

@implementation LDCalendarView
- (NSDate *)today {
    if (!_today) {
        NSDate *currentDate = [NSDate date];
        NSInteger tYear = currentDate.year;
        NSInteger tMonth = currentDate.month;
        NSInteger tDay = currentDate.day;
        
        //字符串转换为日期
        //实例化一个NSDateFormatter对象
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        _today =[dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",@(tYear),@(tMonth),@(tDay)]];
    }
    return _today;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(PostSelectDaysArray:) name:@"PostSelectDaysArray" object:nil];
        //内容区的背景
        _contentBgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, UNIT_WIDTH*kCol,UNIT_WIDTH*kCol)];
        _contentBgView.layer.cornerRadius = 2.0;
        _contentBgView.layer.masksToBounds = YES;
        
        
        _contentBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentBgView];
        
        
        UIImageView *leftImage = [UIImageView new];
        leftImage.image = [UIImage imageNamed:@"com_arrows_right"];
        leftImage.transform=CGAffineTransformMakeRotation(M_PI);
        [_contentBgView addSubview:leftImage];
        leftImage.frame = CGRectMake(CGRectGetWidth(_contentBgView.frame)/3.0-60, (42-13)/2.0, 8, 13);
        
        UIImageView *rightImage = [UIImageView new];
        rightImage.image = [UIImage imageNamed:@"com_arrows_right"];
        [_contentBgView addSubview:rightImage];
        rightImage.frame = CGRectMake(CGRectGetWidth(_contentBgView.frame)*2/3.0 + 50, (42-13)/2.0, 8, 13);
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_contentBgView.frame), 42)];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.userInteractionEnabled = YES;
        [self addSubview:_titleLab];
        
        UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchMonthTap:)];
        [_titleLab addGestureRecognizer:titleTap];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLab.frame) - 0.5, CGRectGetWidth(_contentBgView.frame), 0.5)];
        line.backgroundColor = [UIColor hexColorWithString:@"dddddd"];
        [_contentBgView addSubview:line];
        
        _dateBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLab.frame), CGRectGetWidth(_contentBgView.frame), UNIT_WIDTH*kCol)];
        _dateBgView.userInteractionEnabled = YES;
        _dateBgView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        [_contentBgView addSubview:_dateBgView];
        
        UIView *_bottomLine  = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dateBgView.frame), CGRectGetWidth(_contentBgView.frame), 0.5)];
        _bottomLine.backgroundColor = [UIColor hexColorWithString:@"dddddd"];
        [_contentBgView addSubview:_bottomLine];
        
        //        _done = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [_done setFrame:CGRectMake((CGRectGetWidth(_contentBgView.frame) - 150) / 2.0, CGRectGetHeight(_contentBgView.frame) - 40, 150, 30)];
        //
        //        [_done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        [_done.titleLabel setFont:[UIFont systemFontOfSize:14]];
        //        [_done setBackgroundImage:[[UIImage imageNamed:@"b_com_bt_blue_normal"] stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateNormal];
        //        [_done setBackgroundImage:[[UIImage imageNamed:@"b_com_bt_blue_normal"] stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateSelected];
        //        [_done setBackgroundImage:[[UIImage imageNamed:@"com_bt_gray_normal"] stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateDisabled];
        //        [_done addTarget:self action:@selector(_doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        [_done setTitle:@"确定" forState:UIControlStateNormal];
        //        [_contentBgView addSubview:_done];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_dateBgView addGestureRecognizer:tap];
        
        //初始化数据
        [self initData];
        
    }
    return self;
}
-(void)PostSelectDaysArray:(NSNotification*)not
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults] setValue:not.userInfo forKey:@"userInfo"];
    
}
- (void)initData {
    
    _selectArray = @[].mutableCopy;
    
    //获取当前年月
    NSDate *currentDate = [NSDate date];
    self.month = (int32_t)currentDate.month;
    self.year = (int32_t)currentDate.year;
    [self refreshDateTitle];
    
    _currentMonthDateArray = [NSMutableArray array];
    for (int i = 0; i < kTotalNum; i++) {
        [_currentMonthDateArray addObject:@(0)];
    }
    
    [self showDateView];
}

- (void)switchMonthTap:(UITapGestureRecognizer *)tap {
    CGPoint loc =  [tap locationInView:_titleLab];
    CGFloat titleLabWidth = CGRectGetWidth(_titleLab.frame);
    if (loc.x <= titleLabWidth/3.0) {
        //左
        [self leftSwitch];
    }else if(loc.x >= titleLabWidth/3.0*2.0){
        //右
        [self rightSwitch];
    }
}

- (void)leftSwitch{
    //左
    NSDate *currentDate = [NSDate date];
    NSInteger tMonth = currentDate.month;
    //    NSLog(@"%ld",(long)tMonth);
    //    NSLog(@"%d",self.month);
    if (self.month > 1) {
        if(tMonth!=self.month)
        {
            self.month -= 1;
        }
    }else {
        self.month = 12;
        self.year -= 1;
    }
    
    [self refreshDateTitle];
}

- (void)rightSwitch {
    if (self.month < 12) {
        self.month += 1;
    }else {
        self.month = 1;
        self.year += 1;
    }
    
    [self refreshDateTitle];
}

- (void)refreshDateTitle {
    _titleLab.text = [NSString stringWithFormat:@"%@年-%@月",@(self.year),@(self.month)];
    
    [self showDateView];
}

- (void)showDateView {
    //移除之前子视图
    [_dateBgView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    CGFloat offX = 0.0;
    CGFloat offY = 0.0;
    CGFloat w = (CGRectGetWidth(_dateBgView.frame)) / kCol;
    CGFloat h = (CGRectGetHeight(_dateBgView.frame)) / kRow;
    CGRect baseRect = CGRectMake(offX,offY, w, h);
    NSArray *tmparr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    for(int i = 0 ;i < 7; i++)
    {
        UILabel *lab = [[UILabel alloc] initWithFrame:baseRect];
        lab.textColor = [UIColor hexColorWithString:@"848484"];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:12];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = [tmparr objectAtIndex:i];
        [_dateBgView addSubview:lab];
        
        baseRect.origin.x += baseRect.size.width;
    }
    
    //字符串转换为日期
    //实例化一个NSDateFormatter对象
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *firstDay =[dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@",@(self.year),@(self.month),@(1)]];
    
    CGFloat startDayIndex = [NSDate acquireWeekDayFromDate:firstDay];
    //第一天是今天，特殊处理
    if (startDayIndex == 1) {
        //星期天（对应一）
        startDayIndex = 6;
    }else {
        //周一到周六（对应2-7）
        startDayIndex -= 2;
    }
    
    baseRect.origin.x = w * startDayIndex;
    baseRect.origin.y += (baseRect.size.height);
    NSInteger baseTag = 100;
    for(int i = startDayIndex; i < kTotalNum;i++)
    {
        if (i % kCol == 0 && i!= 0)
        {
            baseRect.origin.y += (baseRect.size.height);
            baseRect.origin.x = offX;
        }
        
        //设置触摸区域
        if (i == startDayIndex)
        {
            _touchRect.origin = baseRect.origin;
            _touchRect.origin.x = 0;
            _touchRect.size.width = kCol * w;
            _touchRect.size.height = kRow * h;
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = baseTag + i;
        [btn setFrame:baseRect];
        btn.userInteractionEnabled = NO;
        btn.backgroundColor = [UIColor clearColor];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        NSDate * date = [firstDay dateByAddingTimeInterval:(i - startDayIndex) *24*60*60];
        _currentMonthDateArray[i] = @(([date timeIntervalSince1970]) * 1000);
        NSString *title = INTTOSTR(date.day);
        if ([date isToday])
        {//今天
            title = @"今天";
        }
        else if(date.day == 1)
        {//是1号
            //在下面标一下月份
            UILabel *monthLab = [[UILabel alloc] initWithFrame:CGRectMake(baseRect.origin.x, baseRect.origin.y + baseRect.size.height - 7, baseRect.size.width, 7)];
            monthLab.backgroundColor = [UIColor clearColor];
            monthLab.textAlignment = NSTextAlignmentCenter;
            monthLab.font = [UIFont systemFontOfSize:7];
            monthLab.textColor = [UIColor hexColorWithString:@"c0c0c0"];
            monthLab.text = [NSString stringWithFormat:@"%@月",@(date.month)];
            [_dateBgView addSubview:monthLab];
        }else
        {
            NSArray *arr=[NSArray array];
            arr=[[NSUserDefaults standardUserDefaults] valueForKey:@"userInfo"];
            //            NSArray *arr=[NSArray arrayWithObjects:@"2016-12-24", nil];
            NSDateFormatter* dateFormat1 = [[NSDateFormatter alloc] init];
            //设定时间格式,这里可以设置成自己需要的格式
            [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
//            UIColor *jiedancolor1=Color(234, 234, 234)//红
            for (int i=0; i<arr.count; i++) {
                NSDate *firstDay1 =[dateFormat1 dateFromString:arr[i]];
                //                NSDate * date3= [firstDay1 dateByAddingTimeInterval:(i - startDayIndex) *24*60*60];
                if ([firstDay1 isEqualToDate:date]) {
                    btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.frame.size.width - 12, btn.frame.size.height - 10, 0);
                    btn.layer.masksToBounds=YES;
                    [btn setBounds:CGRectMake(3,3,Height(39) - 6,Height(39) -6)];
                    [btn setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
                    [btn setBackgroundColor:[UIColor hexColorWithString:@"848484" alpha:0.5f]];
                }
            }
            
        }
        
        
        [btn setTitle:title forState:UIControlStateNormal];
        if ([self.today compare:date] < 0) {
            
            //时间比今天大,同时是当前月
            [btn setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
        }else {
            
            
            if ([date isToday])
            {
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                
            }
            else
            {
                
                [btn setTitleColor:[UIColor hexColorWithString:@"bfbfbf"] forState:UIControlStateNormal];
                
            }
            
        }
        //        [btn setBackgroundColor:[UIColor clearColor]];
        [_dateBgView addSubview:btn];
        [_dateBgView sendSubviewToBack:btn];
        
        baseRect.origin.x += (baseRect.size.width);
    }
    
    //高亮选中的
    [self refreshDateView];
}



- (void)refreshDateView {
    
    for(int i = 0; i < kTotalNum; i++)
    {
        UIButton *btn = (UIButton *)[_dateBgView viewWithTag:100 + i];
        NSNumber *interval = [_currentMonthDateArray objectAtIndex:i];
        
        if (i < [_currentMonthDateArray count] && btn)
        {
            if ([_selectArray containsObject:interval]) {
                btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.frame.size.width - 12, btn.frame.size.height - 10, 0);
                btn.layer.masksToBounds=YES;
                [btn setBounds:CGRectMake(3,3,Height(39) - 6,Height(39) -6)];
                [btn setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor hexColorWithString:@"848484" alpha:0.5f]];
                
            }
        }
        
        
    }
}

- (void)show {
    self.hidden = NO;
}

- (void)hide {
    self.hidden = YES;
}

-(void)tap:(UITapGestureRecognizer *)gesture{
    CGPoint point = [gesture locationInView:_dateBgView];
    if (CGRectContainsPoint(_touchRect, point)) {
        CGFloat w = (CGRectGetWidth(_dateBgView.frame)) / kCol;
        CGFloat h = (CGRectGetHeight(_dateBgView.frame)) / kRow;
        int row = (int)((point.y - _touchRect.origin.y) / h);
        int col = (int)((point.x) / w);
        
        NSInteger index = row * kCol + col;
        [self clickForIndex:index];
    }
}

- (void)clickForIndex:(NSInteger)index
{
    UIButton *btn = (UIButton *)[_dateBgView viewWithTag:100 + index];
    if (index < [_currentMonthDateArray count]) {
        NSNumber *interval = [_currentMonthDateArray objectAtIndex:index];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval.doubleValue/1000.0];
        if ([self.today  compare:date] < 0||[self.today compare:date]==0) {
            //时间比今天大,同时是当前月
        }else {
            return;
        }
        
        if ([[_selectArray mutableCopy] containsObject:interval]) {
            int i=0;
            for (NSNumber *yesstring in [_selectArray mutableCopy]) {
                
                if ([yesstring isEqualToNumber:interval]) {
                    //已选中,取消
                    [_selectArray  removeObjectAtIndex:i];
                    if (_complete) {
                        NSLog(@"我是选中还是取消的");
                        
                        
                        _complete([_selectArray mutableCopy]);
                    }
                }
                i++;
            }
            
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            
            [btn setImage:nil forState:UIControlStateNormal];
            
            if([date isToday])
            {
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            else
            {
                [btn setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
            }
            [btn setBackgroundColor:[UIColor clearColor]];
            
        }
        else {
            
            //未选中,想选择
            [_selectArray addObject:interval];
            
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.frame.size.width - 12, btn.frame.size.height - 10, 0);
            btn.layer.masksToBounds=YES;
            [btn setBounds:CGRectMake(3,3,Height(39)- 6,Height(39) -6)];
            [btn setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor hexColorWithString:@"838383" alpha:0.5f]];
            if (_complete) {
                _complete([_selectArray mutableCopy]);
            }
            //如果选中的是下个月切换到下个月
            if (date.month > self.month) {
                [self rightSwitch];
            }
        }
    }
}


@end
