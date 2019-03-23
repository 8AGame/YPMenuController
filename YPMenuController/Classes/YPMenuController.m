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
                [weakSelf menuInvisibleWithAnimated:YES];
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

- (void)menuVisibleInView:(UIView *)targetView
               targetRect:(CGRect)targetRect
                 animated:(BOOL)animated {
    self.targetRect = targetRect;
    self.targetView = targetView;
    self.menuWindow.hidden = NO;
    CGRect transformRect = [self.menuWindow convertRect:self.targetRect fromView:self.targetView];
    self.calloutBar = [[YPCalloutBar alloc] initCalloutBarWithMenuItems:self.menuItems  transformRect:transformRect menuType:self.menuType];
    __weak __typeof(self)weakSelf = self;
    self.calloutBar.triggerClickBlock = ^(SEL  _Nonnull action) {
        [weakSelf performMenuSelector:action];
    };
    [self.calloutBar layoutBarItems];
    self.calloutBar.alpha = 0.0;
    [self.menuWindow addSubview:self.calloutBar];
    if (animated) {
        NSTimeInterval time =  0.16;
        [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
            self.calloutBar.alpha = 1;
        } completion:nil];
    }
}

- (void)menuInvisibleWithAnimated:(BOOL)animated {
    self.calloutBar.alpha = 1;
    if (animated) {
        NSTimeInterval time =  0.2;
        [UIView animateWithDuration:time delay:0.2 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
            self.calloutBar.alpha = 0;
        } completion:^(BOOL finished) {
            self.menuWindow.hidden = YES;
            [self.calloutBar removeFromSuperview];
            self.calloutBar = nil;
        }];
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
