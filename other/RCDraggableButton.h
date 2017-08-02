//购物车的控件

#import <UIKit/UIKit.h>
#define RC_DB_VERSION @"0.2"

@interface RCDraggableButton : UIButton {
    BOOL _isDragging;
    BOOL _singleTapBeenCanceled;
    CGPoint _beginLocation;
    UILongPressGestureRecognizer *_longPressGestureRecognizer;
}
@property (nonatomic) BOOL draggable;
@property (nonatomic) BOOL autoDocking;

@property (nonatomic, copy) void(^longPressBlock)(RCDraggableButton *button);
@property (nonatomic, copy) void(^tapBlock)(RCDraggableButton *button);
@property (nonatomic, copy) void(^doubleTapBlock)(RCDraggableButton *button);

@property (nonatomic, copy) void(^draggingBlock)(RCDraggableButton *button);
@property (nonatomic, copy) void(^dragDoneBlock)(RCDraggableButton *button);

@property (nonatomic, copy) void(^autoDockingBlock)(RCDraggableButton *button);
@property (nonatomic, copy) void(^autoDockingDoneBlock)(RCDraggableButton *button);

- (id)initInKeyWindowWithFrame:(CGRect)frame;
- (id)initInView:(id)view WithFrame:(CGRect)frame;

- (BOOL)isDragging;

+ (NSString *)version;

+ (void)removeAllFromKeyWindow;
+ (void)removeAllFromView:(id)superView;

@end
