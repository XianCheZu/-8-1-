//
//  UIButton+ResponsiveInteraction.h
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 6/30/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ResponsiveInteraction) <UIGestureRecognizerDelegate>
// ACtive
-(void) activeResponsiveInteraction;

// Disable
-(void) disableResponsiveInteraction;

-(void) setGlobalResponsiveInteractionWithView:(UIView *) view;

@end