//
//  YPMenuStyleConfig.m
//
//  Created by Yaping Liu on 3/26/19.
//

#import "YPMenuStyleConfig.h"

@implementation YPMenuStyleConfig

+ (instancetype)defaultStyleConfig {
    YPMenuStyleConfig *config = [[YPMenuStyleConfig alloc] init];
    config.menuType = YPMenuControllerSystem;
    config.arrowDirection = YPMenuControllerArrowDefault;
    config.barBackgroundColor = [UIColor colorWithRed:31/255 green:31/288 blue:31/255 alpha:0.96];
    config.titleFont = [UIFont systemFontOfSize:14];
    config.titleColor = [UIColor whiteColor];
    config.triangleColor = [UIColor whiteColor];
    config.separatorLineColor = [UIColor whiteColor];
    return config;
}

- (CGFloat)barHeight {
    if (!_barHeight) {
        if (self.menuType == YPMenuControllerImageTopTitleBottom ||
            self.menuType == YPMenuControllerTitleTopImageBottom) {
            return 80;
            
        }else{
            return 60;
        }
    }
    return _barHeight;
}


@end
