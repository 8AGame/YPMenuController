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
            CGPoint inCallBarPoint = [weakSelf.menuWindow convertPoint:point toView:weakSelf.calloutBar];
            if (weakSelf.calloutBar &&
                CGRectContainsPoint(weakSelf.calloutBar.contentRect, inCallBarPoint)) {
                return YES;
            }else{
                [weakSelf menuInvisibleWithAnimated:YES];
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
    
    if (!self.menuItems || self.menuItems.count < 1) return;
    
    [self menuInvisibleWithAnimated:NO];
    self.targetRect = targetRect;
    self.targetView = targetView;
    self.menuWindow.hidden = NO;
    CGRect transformRect = [self.menuWindow convertRect:self.targetRect fromView:self.targetView];
    self.calloutBar = [[YPCalloutBar alloc] initWithMenuItems:self.menuItems
                                                transformRect:transformRect
                                                  styleConfig:self.styleConfig];
    __weak __typeof(self)weakSelf = self;
    self.calloutBar.triggerClickBlock = ^(SEL  _Nonnull action) {
        [weakSelf performMenuSelector:action];
    };
    [self.calloutBar layoutBarItems];
    [[NSNotificationCenter defaultCenter] postNotificationName:YPMenuControllerWillShowMenuNotification object:self];
    self.calloutBar.alpha = 0.0;
    [self.menuWindow addSubview:self.calloutBar];
    self->_menuVisible = YES;
    if (animated) {
        NSTimeInterval time =  0.3;
        [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
            self.calloutBar.alpha = 1;
        } completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:YPMenuControllerDidShowMenuNotification object:self];
        }];
    }
}

- (void)menuInvisibleWithAnimated:(BOOL)animated {
    if (!self->_menuVisible) return;
    self->_menuVisible = NO;

    if (animated) {
        [[NSNotificationCenter defaultCenter] postNotificationName:YPMenuControllerWillHideMenuNotification object:self];
        YPCalloutBar *animatePeriodBar = self.calloutBar;
        self.calloutBar.alpha = 1;
        NSTimeInterval time =  0.3;
        [UIView animateWithDuration:time delay:self.styleConfig.barDismissDelayInterval options:UIViewAnimationOptionCurveEaseInOut  animations:^{
            self.calloutBar.alpha = 0;
            
        } completion:^(BOOL finished) {
            if (animatePeriodBar == self.calloutBar) {
                [self dismissMenuOperate];
            }else{
                if (animatePeriodBar.superview) {
                    [animatePeriodBar removeFromSuperview];
                }
            }
        }];

    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:YPMenuControllerWillHideMenuNotification object:self];
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

- (void)performMenuSelector:(SEL)sel {
    if (self.targetView && [self.targetView respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.targetView performSelector:sel withObject:self];
#pragma clang diagnostic pop
    }
    [self menuInvisibleWithAnimated:YES];
}


@end
