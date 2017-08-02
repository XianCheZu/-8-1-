//
//  UIButton+ResponsiveInteraction.m
//  FeResponsiveInteraction
//
//  Created by Nghia Tran on 6/30/14.
//  Copyright (c) 2014 Fe. All rights reserved.
//

#import "UIButton+ResponsiveInteraction.h"
#import "FeBasicAnimationBlock.h"
#import <objc/runtime.h>

// Key
static char key_isActive;
static char key_groupAnimation_lift_up;
static char key_groupAnimation_lift_down;
static char key_animation_state;
static char key_current_touch;
static char key_longPressGesture;
static char key_isAlreadyInit;

// Define State
#define kFe_State_Stop_InGround 1
#define kFe_State_Stop_InAir 2
#define kFe_State_Lifting_Up 3
#define kFe_State_Lifting_Down 4

@implementation UIButton (ResponsiveInteraction)

#pragma mark - Init
-(void) initDefault
{
    [self initCommon];
    
//    [self initShadow];
    
    [self initGesture];
    
    [self initAnimationLift];
}
-(void) initCommon
{
    [self set_isAlreadyInit:YES];
    
    [self set_isActive:YES];
    
    [self set_animation_state:kFe_State_Stop_InGround];
    
    self.userInteractionEnabled = YES;
}
-(void) initShadow
{
    // Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.4f;
    self.layer.shadowOffset = CGSizeMake(0, 2);
}
-(void) initAnimationLift
{
    ////////////////////////////////////////////
    ////////////////////////////////////////////////
    // Define
    CGFloat durationUp = 0.3f;
    CGFloat durationDown = 0.2f;
    
    if (YES)
    {
        /////////////
        // Transform
        CATransform3D t = CATransform3DIdentity;
        t.m34 = - 1.0f / 800.0f;
        t = CATransform3DTranslate(t, 0, 0, 200);
        
        CABasicAnimation *liftAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        liftAnimation.toValue = (id) [NSValue valueWithCATransform3D:t];
        liftAnimation.duration = durationUp;
        liftAnimation.fillMode = kCAFillModeForwards;
        liftAnimation.removedOnCompletion = NO;
        liftAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        // Shadow Offset
        CABasicAnimation *shadowOffsetAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
        shadowOffsetAnimation.toValue = (id) [NSValue valueWithCGSize:CGSizeMake(0, 7)];
        shadowOffsetAnimation.duration = durationUp;
        shadowOffsetAnimation.fillMode = kCAFillModeForwards;
        shadowOffsetAnimation.removedOnCompletion = NO;
        shadowOffsetAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        // Shadow Radius
        CABasicAnimation *shadowRaidusAnimation = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
        shadowRaidusAnimation.toValue = (id) [NSNumber numberWithFloat:5];
        shadowRaidusAnimation.duration = durationUp;
        shadowRaidusAnimation.fillMode = kCAFillModeForwards;
        shadowRaidusAnimation.removedOnCompletion = NO;
        shadowRaidusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group = [CAAnimationGroup animation];
        group.duration = durationUp;
        group.animations = @[liftAnimation, shadowOffsetAnimation, shadowRaidusAnimation];
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        // Set
        [self set_groupAnimation_lift_up:group];
    }
    /////////////////////////////////////////
    ////////////////////////////////////////
    if (YES)
    {
        /////////////
        // Transform
        CATransform3D t = CATransform3DIdentity;
        t.m34 = - 1.0f / 800.0f;
        
        CABasicAnimation *liftAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        liftAnimation.toValue = (id) [NSValue valueWithCATransform3D:t];
        liftAnimation.duration = durationDown;
        liftAnimation.fillMode = kCAFillModeForwards;
        liftAnimation.removedOnCompletion = NO;
        liftAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        // Shadow Offset
        CABasicAnimation *shadowOffsetAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
        shadowOffsetAnimation.toValue = (id) [NSValue valueWithCGSize:CGSizeMake(0, 2)];
        shadowOffsetAnimation.duration = durationDown;
        shadowOffsetAnimation.fillMode = kCAFillModeForwards;
        shadowOffsetAnimation.removedOnCompletion = NO;
        shadowOffsetAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        // Shadow Radius
        CABasicAnimation *shadowRaidusAnimation = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
        shadowRaidusAnimation.toValue = (id) [NSNumber numberWithFloat:3];
        shadowRaidusAnimation.duration = durationDown;
        shadowRaidusAnimation.fillMode = kCAFillModeForwards;
        shadowRaidusAnimation.removedOnCompletion = NO;
        shadowRaidusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group = [CAAnimationGroup animation];
        group.duration = durationDown;
        group.animations = @[liftAnimation, shadowOffsetAnimation, shadowRaidusAnimation];
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        // Set
        [self set_groupAnimation_lift_down:group];
    }
}
-(void) initGesture
{
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    longGesture.minimumPressDuration = 0.03f;
    longGesture.delegate = self;
    
    [self addGestureRecognizer:longGesture];
    
    // Save
    [self set_longPessGesture:longGesture];
}

#pragma mark - Getter / Setter

// isActive
-(void) set_isActive:(BOOL) isActive
{
    objc_setAssociatedObject(self, &key_isActive, [NSNumber numberWithBool:isActive], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // Active / disable gesture
    UILongPressGestureRecognizer *longGesture = [self get_longPressGesture];
    if (longGesture)
    {
        longGesture.enabled = isActive;
    }
}
-(NSNumber *) get_isActive
{
    NSNumber *isActive = (NSNumber *) objc_getAssociatedObject(self, &key_isActive);
    return isActive;
}

// groupAnimation
-(void) set_groupAnimation_lift_up:(CAAnimationGroup *) groupAnimation
{
    objc_setAssociatedObject(self, &key_groupAnimation_lift_up, groupAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CAAnimationGroup *) get_groupAnimation_lift_up
{
    CAAnimationGroup *group = objc_getAssociatedObject(self, &key_groupAnimation_lift_up);
    
    return group;
}
-(void) set_groupAnimation_lift_down:(CAAnimationGroup *) groupAnimation
{
    objc_setAssociatedObject(self, &key_groupAnimation_lift_down, groupAnimation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CAAnimationGroup *) get_groupAnimation_lift_down
{
    CAAnimationGroup *group = objc_getAssociatedObject(self, &key_groupAnimation_lift_down);
    
    return group;
}

// Animation State
-(void) set_animation_state:(NSInteger) state
{
    objc_setAssociatedObject(self, &key_animation_state, [NSNumber numberWithInteger:state], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSInteger) get_isAnimate_state
{
    NSNumber *state = (NSNumber *)objc_getAssociatedObject(self, &key_animation_state);
    return state.integerValue;
}

// Current touch
-(void) set_current_touch:(CGPoint) point
{
    objc_setAssociatedObject(self, &key_current_touch, [NSValue valueWithCGPoint:point], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CGPoint) get_current_touch
{
    NSValue *value = (NSValue *)objc_getAssociatedObject(self, &key_current_touch);
    return value.CGPointValue;
}

// Gesture
-(void) set_longPessGesture:(UILongPressGestureRecognizer *) longPressGesture
{
    objc_setAssociatedObject(self, &key_longPressGesture, longPressGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UILongPressGestureRecognizer *) get_longPressGesture
{
    UILongPressGestureRecognizer *gesture = (UILongPressGestureRecognizer *) objc_getAssociatedObject(self, &key_longPressGesture);
    
    return gesture;
}

// Already init
-(void) set_isAlreadyInit:(BOOL) toogle
{
    objc_setAssociatedObject(self, &key_isAlreadyInit, [NSNumber numberWithBool:toogle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSNumber *) get_isAlreadyInit
{
    NSNumber *number = (NSNumber *) objc_getAssociatedObject(self, &key_isAlreadyInit);
    return number;
}

#pragma mark - Gesture
-(void) handleGesture:(UILongPressGestureRecognizer *) sender
{
    CGPoint locationTouch = [sender locationInView:self.superview];
    CGPoint locationInside = [sender locationInView:self];
    
    // Save current touch's point
    [self set_current_touch:locationTouch];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (CGRectContainsPoint(self.frame, locationTouch))
            {
                if ([self get_isAnimate_state] == kFe_State_Stop_InGround)
                {
                    CGPoint locationInside = [sender locationInView:self];
                    [self liftUpAnimationAtPoint:locationInside];
                }
            }
            
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            if (CGRectContainsPoint(self.frame, locationTouch))
            {
                if ([self get_isAnimate_state] == kFe_State_Stop_InGround)
                {
                    [self liftUpAnimationAtPoint:locationInside];
                }
                if ([self get_isAnimate_state] == kFe_State_Stop_InAir)
                {
                    
                }
            }
            else // Out-side
            {
                if ([self get_isAnimate_state] == kFe_State_Lifting_Up)
                {
                    
                }
                else if ([self get_isAnimate_state] == kFe_State_Stop_InAir)
                {
                    [self liftDownAnimationAtPoint:locationInside];
                }
            }
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            if (CGRectContainsPoint(self.frame, locationTouch))
            {
                [self sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            if ([self get_isAnimate_state] == kFe_State_Stop_InAir)
            {
                [self liftDownAnimationAtPoint:locationInside];
            }
            if ([self get_isAnimate_state] == kFe_State_Lifting_Up)
            {
                [self liftDownAnimationAtPoint:locationInside];
            }
            
            // Release Current touch
            [self set_current_touch:CGPointMake(-100, -100)];
            
            break;
        }
        default:
            break;
    }
    
}

-(void) liftUpAnimationAtPoint:(CGPoint) point
{
    CAAnimationGroup *groupLift = [self get_groupAnimation_lift_up];
    
    // Delegate object
    FeBasicAnimationBlock *blockObj = [[FeBasicAnimationBlock alloc] init];
    groupLift.delegate = blockObj;
    blockObj.blockDidStop = ^
    {
        // Check if animation is stopped, and current touch is not inside cell
        // Just fire lift down animation.
        if (!CGRectContainsPoint(self.frame, [self get_current_touch]))
        {
            [self liftDownAnimationAtPoint:point];
        }
        else
        {
            // Save state
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            
            CATransform3D t = CATransform3DIdentity;
            t.m34 = - 1.0f / 800.0f;
            t = CATransform3DTranslate(t, 0, 0, 200);
            
            self.layer.transform = t;
            self.layer.shadowOffset = CGSizeMake(0, 7);
            self.layer.shadowRadius = 5;
            
            // REMOVE
            [self.layer removeAllAnimations];
            
            [CATransaction commit];
            
            // State
            [self set_animation_state:kFe_State_Stop_InAir];
        }
    };
    
    
    
    // Add animation
    [self.layer addAnimation:groupLift forKey:@"liftUP"];
    
    // is Animating
    [self set_animation_state:kFe_State_Lifting_Up];
}
-(void) liftDownAnimationAtPoint:(CGPoint) point
{
    // Reverse animate at end animation
    CAAnimationGroup *group = [self get_groupAnimation_lift_down];
    
    // Set position
    //circleLayer.position = point;
    
    // Delegate object
    FeBasicAnimationBlock *blockObj = [[FeBasicAnimationBlock alloc] init];
    group.delegate = blockObj;
    blockObj.blockDidStop = ^
    {
        // Save state
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        
        CATransform3D t = CATransform3DIdentity;
        
        self.layer.transform = t;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowRadius = 3;
        
        // REMOVE
        [self.layer removeAllAnimations];
        
        [CATransaction commit];
        
        
        
        // State
        [self set_animation_state:kFe_State_Stop_InGround];
    };
    
    [self.layer addAnimation:group forKey:@"liftDown"];
    [self set_animation_state:kFe_State_Lifting_Down];
}

#pragma mark - Action
-(void) activeResponsiveInteraction
{
    NSNumber *isAlreadyInit = [self get_isAlreadyInit];
    if (isAlreadyInit == nil || isAlreadyInit == NO)
    {
        [self initDefault];
    }
    
    // Active
    NSNumber *isActive = [self get_isActive];
    if (isActive && isActive.boolValue == NO)
    {
        [self set_isActive:YES];
    }
    else
    {
        return;
    }
}
-(void) disableResponsiveInteraction
{
    NSNumber *isActive = [self get_isActive];
    if (isActive)
    {
        [self set_isActive:NO];
    }
    else
    {
        return;
    }
}
-(void) setGlobalResponsiveInteractionWithView:(UIView *) view;
{
    // Check if we have added longgesture before
    UILongPressGestureRecognizer *longGesture = [self get_longPressGesture];
    if (longGesture)
    {
        // remove
        [self removeGestureRecognizer:longGesture];
        
        // Add to view
        [view addGestureRecognizer:longGesture];
    }
    else
    {
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        longGesture.minimumPressDuration = 0.03f;
        longGesture.delegate = self;
        
        [view addGestureRecognizer:longGesture];

    }
}

#pragma mark - Gesture Delegate
-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

/*
 // At runtime this method will be called as buttonWithType:
 -(void) customeLayoutSubviews
 {
 // ---Add in custom code here---
 for(UIView* buttonSubview in self.subviews) {
 if([buttonSubview isKindOfClass:[UIImageView class]])
 {
 NSLog(@"transform");
 buttonSubview.layer.transform = CATransform3DMakeTranslation(150, 0, 0);
 }
 }
 // This line at runtime does not go into an infinite loop
 // because it will call the real method instead of ours.
 [self customeLayoutSubviews];
 
 for(UIView* buttonSubview in self.subviews) {
 if([buttonSubview isKindOfClass:[UIImageView class]])
 {
 NSLog(@"transform");
 buttonSubview.layer.transform = CATransform3DMakeTranslation(150, 0, 0);
 }
 }
 }
 
 // Swaps our custom implementation with the default one
 // +load is called when a class is loaded into the system
 + (void) load
 {
 SEL origSel = @selector(layoutSubviews);
 
 SEL newSel = @selector(customeLayoutSubviews);
 
 Class buttonClass = [UIButton class];
 
 Method origMethod = class_getInstanceMethod(buttonClass, origSel);
 Method newMethod = class_getInstanceMethod(buttonClass, newSel);
 method_exchangeImplementations(origMethod, newMethod);
 }
 */
@end
