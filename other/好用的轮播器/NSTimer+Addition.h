//
//  NSTimer+Addition.h
//  PagedScrollView
//
//  Created by 古智性 on 15-11-2.
//  Copyright (c) 2015年 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSTimer (Addition)

- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
