//
//  YPMenuController.m
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
                [weakSelf menuInvisibleWithAnimated:YES];
                return NO;
            }
        };
        _styleConfig = [[YPMenuStyleConfig alloc] init];
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
    self.calloutBar.alpha = 0.0;
    [self.menuWindow addSubview:self.calloutBar];
    self->_menuVisible = YES;
    if (animated) {
        NSTimeInterval time =  0.16;
        [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
            self.calloutBar.alpha = 1;
        } completion:nil];
    }
}

- (void)menuInvisibleWithAnimated:(BOOL)animated {
    if (animated) {
        YPCalloutBar *animatePeriodBar = self.calloutBar;
        self.calloutBar.alpha = 1;
        NSTimeInterval time =  0.2;
        [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
            self.calloutBar.alpha = 0;
            
        } completion:^(BOOL finished) {
            if (animatePeriodBar == self.calloutBar) {
                self.menuWindow.hidden = YES;
                if (self.calloutBar) {
                    [self.calloutBar removeFromSuperview];
                    self.calloutBar = nil;
                }
                self->_menuVisible = NO;
            }
        }];

    }else{
        self.menuWindow.hidden = YES;
        if (self.calloutBar) {
            [self.calloutBar removeFromSuperview];
            self.calloutBar = nil;
        }
        self->_menuVisible = NO;
    }
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
