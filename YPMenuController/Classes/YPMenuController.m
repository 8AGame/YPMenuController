//
//  YPMenuController.m
//  Pods-YPMenuController_Example
//
//  Created by Yaping Liu on 3/18/19.
//

#import "YPMenuController.h"
#import "YPMenuWindow.h"
#import "YPCalloutBar.h"

@interface YPMenuController ()

@property (nonatomic, strong) YPMenuWindow *menuWindow;

@property (nonatomic, strong) YPCalloutBar *calloutBar;

@property (nonatomic, assign) CGRect targetRect;

@property (nonatomic, weak) UIView *targetView;

@end

@implementation YPMenuController

+ (YPMenuController *)sharedMenuController {
    static YPMenuController *menuVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menuVC = [[YPMenuController alloc] initMenuController];
    });
    return menuVC;
}

- (instancetype)initMenuController
{
    self = [super init];
    if (self) {
        self.menuWindow = [[YPMenuWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        __weak __typeof(self)weakSelf = self;
        self.menuWindow.touchPointInsideCanRespond = ^BOOL(CGPoint point) {
            if (weakSelf.calloutBar &&
                CGRectContainsPoint(weakSelf.calloutBar.frame, point)) {
                return YES;
            }else{
                //应该是当点击 menu 区域时候松开手才消失
                [weakSelf setMenuVisible:NO animated:YES];
                return NO;
            }
        };
    }
    return self;
}


- (void)setMenuItems:(NSArray<YPMenuItem *> *)menuItems
            menuType:(YPMenuControllerType)menuType {
    _menuItems = menuItems;
    _menuType = menuType;
}

- (void)setTargetRect:(CGRect)targetRect inView:(UIView *)targetView {
    self.targetRect = targetRect;
    self.targetView = targetView;
}

- (void)setMenuVisible:(BOOL)menuVisible animated:(BOOL)animated {
    if (menuVisible) {
        self.menuWindow.hidden = NO;
        CGRect transformRect = [self.menuWindow convertRect:self.targetRect fromView:self.targetView];
        self.calloutBar = [[YPCalloutBar alloc] initCalloutBarWithMenuItems:self.menuItems  transformRect:transformRect menuType:self.menuType];
        [self.calloutBar layoutBarItems];
        self.calloutBar.alpha = 0.0;
        [self.menuWindow addSubview:self.calloutBar];
        if (animated) {
            NSTimeInterval time =  0.16;
            [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
                self.calloutBar.alpha = 1;
            } completion:nil];
        }
        
    }else{
        self.menuWindow.hidden = YES;
        [self.calloutBar removeFromSuperview];
        self.calloutBar = nil;
    }
    
}


@end
