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

- (instancetype)init {
    @throw [NSException
            exceptionWithName:@"YPMenuController initialize error!"
            reason:@"Create object must use `+sharedMenuController` method."
            userInfo:nil];
    return [self initMenuController];
}

- (instancetype)initMenuController
{
    self = [super init];
    if (self) {
        self.menuWindow = [[YPMenuWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        __weak __typeof(self)weakSelf = self;
        self.menuWindow.touchPointInsideCanRespond = ^BOOL(CGPoint point) {
            return CGRectContainsPoint(weakSelf.calloutBar.frame, point);
        };
    }
    return self;
}

- (void)setMenuVisible:(BOOL)menuVisible animated:(BOOL)animated {
    if (menuVisible) {
        self.menuWindow.hidden = NO;
        CGRect bounds = [UIScreen mainScreen].bounds;
        CGRect transformRect = [self.menuWindow convertRect:self.targetRect fromView:self.targetView];
        self.calloutBar = [[YPCalloutBar alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(transformRect), CGRectGetWidth(bounds)-20, 60)];
        self.calloutBar.backgroundColor = [UIColor whiteColor];
        [self.menuWindow addSubview:self.calloutBar];
    }else{
        self.menuWindow.hidden = YES;
        [self.calloutBar removeFromSuperview];
        self.calloutBar = nil;
    }
}

- (void)setTargetRect:(CGRect)targetRect inView:(UIView *)targetView {
    self.targetRect = targetRect;
    self.targetView = targetView;
}


@end
