//
//  YPMenuStyleConfig.m
//
//  Created by Yaping Liu on 3/26/19.
//

#import "YPMenuStyleConfig.h"

@implementation YPMenuStyleConfig


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.menuType = YPMenuControllerSystem;
        self.arrowDirection = YPMenuControllerArrowDefault;
        self.barBackgroundColor = [UIColor colorWithRed:31/255 green:31/255 blue:31/255 alpha:0.96];
        self.titleFont = [UIFont systemFontOfSize:14];
        self.titleColor = [UIColor whiteColor];
        self.skipTriangleColor = [UIColor whiteColor];
        self.separatorLineColor = [UIColor whiteColor];
        self.barShadowColor = [UIColor grayColor];
        self.contentSpace = 5;
        self.menuContentEdge =  UIEdgeInsetsMake(0, 15, 0, 15);
        self.backHighlightColor = [UIColor lightGrayColor];
        self.barDismissDelayInterval = 0;
        self.autoDismiss = YES;
        self.topLimitMargin = UIApplication.sharedApplication.statusBarFrame.size.height;
    }
    return self;
}

- (CGFloat)barContentHeight {
    if (!_barContentHeight) {
        if (self.menuType == YPMenuControllerImageTopTitleBottom ||
            self.menuType == YPMenuControllerTitleTopImageBottom) {
            return 56;
            
        }else{
            return 36;
        }
    }
    return _barContentHeight;
}


@end
