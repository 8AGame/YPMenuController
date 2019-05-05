//
//  YPMenuController.m
//
//  Created by Yaping Liu on 3/18/19.
//

#import "YPMenuController.h"
#import "YPMenuWindow.h"
#import "YPCalloutBar.h"

NSNotificationName const YPMenuControllerWillShowMenuNotification = @"YPMenuControllerWillShowMenuNotification";
NSNotificationName const YPMenuControllerDidShowMenuNotification = @"YPMenuControllerDidShowMenuNotification";
NSNotificationName const YPMenuControllerWillHideMenuNotification = @"YPMenuControllerWillHideMenuNotification";
NSNotificationName const YPMenuControllerDidHideMenuNotification = @"YPMenuControllerDidHideMenuNotification";


@interface YPMenuController ()

@property (nonatomic, strong) YPMenuWindow *menuWindow;

@property (nonatomic, strong) YPCalloutBar *calloutBar;

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
            CGPoint inCallBarPoint = [weakSelf.menuWindow convertPoint:point toView:weakSelf.calloutBar];
            if (weakSelf.calloutBar &&
                CGRectContainsPoint(weakSelf.calloutBar.contentRect, inCallBarPoint)) {
                return YES;
            }else{
                if (weakSelf.styleConfig.autoDismiss) {
                    [weakSelf menuInvisibleWithAnimated:YES];
                }
                return NO;
            }
        };
        self.styleConfig = [[YPMenuStyleConfig alloc] init];
    }
    return self;
}

-(void)setStyleConfig:(YPMenuStyleConfig *)styleConfig {
    if (!styleConfig) {
        _styleConfig = [[YPMenuStyleConfig alloc] init];
    }else{
        _styleConfig = styleConfig;
    }
}

- (void)menuVisibleInView:(UIView *)targetView
               targetRect:(CGRect)targetRect
                 animated:(BOOL)animated {
    
    CGRect transformRect = [self.menuWindow convertRect:targetRect fromView:targetView];
    
    [self menuVisibleInView:targetView windowRect:transformRect animated:animated];
}

- (void)menuVisibleInView:(UIView *)targetView
                  targetX:(CGFloat)targetX
              menuWindowY:(CGFloat)menuWindowY
                 animated:(BOOL)animated {
    
    CGPoint p = [self.menuWindow convertPoint:CGPointMake(targetX, 0) fromView:targetView];
    CGRect transformRect = CGRectMake(p.x, menuWindowY, 0, 0);
    
    [self menuVisibleInView:targetView windowRect:transformRect animated:animated];
}

- (void)menuVisibleInView:(UIView *)targetView
               windowRect:(CGRect)windowRect
                 animated:(BOOL)animated {
    
    //Conditions that bar cannot be displayed.
    if (self->_menuVisible || ![targetView isKindOfClass:UIView.class]) return;
    
    NSMutableArray *canVisibleItems = [[NSMutableArray alloc] init];
    for (YPMenuItem *item in self.menuItems) {
        if (self.styleConfig.menuType == YPMenuControllerCustom || [self canPerformMenuSelector:item.action inTargetView:targetView]) {
            [canVisibleItems addObject:item];
        }
    }
    if (canVisibleItems.count < 1) return;
    
    YPCalloutBar *callBar = [YPCalloutBar createCallBarWithMenuItems:canVisibleItems transformRect:windowRect styleConfig:self.styleConfig];

    if (callBar.frame.origin.y < self.styleConfig.topLimitMargin) {
        //Bar cannot be displayed when less than `topLimitMargin`.
        return;
    }else if (CGRectGetMaxY(callBar.frame) >= CGRectGetHeight([UIScreen mainScreen].bounds)){
        return;
    }
    
    self.targetView = targetView;
    self.calloutBar = callBar;
    __weak __typeof(self)weakSelf = self;
    self.calloutBar.triggerClickBlock = ^(SEL  _Nonnull action) {
        [weakSelf performMenuSelector:action];
    };
    [[NSNotificationCenter defaultCenter] postNotificationName:YPMenuControllerWillShowMenuNotification object:self];
    self.calloutBar.alpha = 0.0;
    self.menuWindow.hidden = NO;
    [self.menuWindow addSubview:self.calloutBar];
    self->_menuVisible = YES;
    if (animated) {
        NSTimeInterval time =  0.2;
        [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.calloutBar.alpha = 1;
        } completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:YPMenuControllerDidShowMenuNotification object:self];
        }];
    }
}

- (void)setCalloutBar:(YPCalloutBar *)calloutBar {
    if (_calloutBar && _calloutBar.superview) {
        [[NSNotificationCenter defaultCenter] postNotificationName:YPMenuControllerDidHideMenuNotification object:self];
    }
    _calloutBar = calloutBar;
}
- (void)menuInvisibleWithAnimated:(BOOL)animated {
    if (!self->_menuVisible) return;
    self->_menuVisible = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:YPMenuControllerWillHideMenuNotification object:self];

    if (animated) {
        YPCalloutBar *animatePeriodBar = self.calloutBar;
        animatePeriodBar.alpha = 1;
        NSTimeInterval time =  0.3;
        [UIView animateWithDuration:time delay:self.styleConfig.barDismissDelayInterval options:UIViewAnimationOptionCurveEaseInOut animations:^{
            animatePeriodBar.alpha = 0;
            
        } completion:^(BOOL finished) {
            //Handle last bar view be being dismiss, new bar be created and show.
            if (animatePeriodBar == self.calloutBar) {
                [self dismissMenuOperate];
            }else{
                if (animatePeriodBar.superview) {
                    [animatePeriodBar removeFromSuperview];
                }
            }
        }];

    }else{
        [self dismissMenuOperate];
    }
}
- (void)dismissMenuOperate {
    self.menuWindow.hidden = YES;
    if (self.calloutBar && self.calloutBar.superview) {
        [self.calloutBar removeFromSuperview];
        self.calloutBar = nil;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:YPMenuControllerDidHideMenuNotification object:self];
}

- (BOOL)canPerformMenuSelector:(SEL)sel inTargetView:(UIView *)targetView{
    if (targetView) {
        if ([targetView respondsToSelector:@selector(canPerformAction:withSender:)]
             && [targetView canPerformAction:sel withSender:self]
            ) {
            return YES;
        }
    }
    return NO;
}

- (void)performMenuSelector:(SEL)sel {
    if ([self canPerformMenuSelector:sel inTargetView:self.targetView]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.targetView performSelector:sel withObject:self];
#pragma clang diagnostic pop
    }
    if (self.styleConfig.autoDismiss) {
        [self menuInvisibleWithAnimated:YES];
    }
}


@end
