//
//  YPMenuWindow.m
//
//  Created by Yaping Liu on 3/18/19.
//

#import "YPMenuWindow.h"

@implementation YPMenuWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel = UIWindowLevelStatusBar + 66.;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL canRespond = NO;
    if (self.touchPointInsideCanRespond &&
        self.touchPointInsideCanRespond(point)) {
        canRespond = [super pointInside:point withEvent:event];
    }
    return canRespond;
}

@end
