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
    }
    return self;
}


@end
