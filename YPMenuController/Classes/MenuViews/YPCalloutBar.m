//
//  YPCalloutBar.m
//  Pods-YPMenuController_Example
//
//  Created by Yaping Liu on 3/19/19.
//

#import "YPCalloutBar.h"

@interface YPCalloutBar ()

@property (nonatomic, strong) CAShapeLayer *backupLayer;

@end

@implementation YPCalloutBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backupLayer = [CAShapeLayer layer];
        [self.layer addSublayer:self.backupLayer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:2];
    self.backupLayer.path = path.CGPath;
    self.backupLayer.frame = self.bounds;
    self.backupLayer.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
}

@end
