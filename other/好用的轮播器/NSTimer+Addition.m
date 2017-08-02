//
//  NSTimer+Addition.m
//  PagedScrollView
//
//  Created by 古智性 on 15-11-2.
//  Copyright (c) 2015年 Apple Inc. All rights reserved.
//

#import "NSTimer+Addition.h"
@implementation NSTimer (Addition)

-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
