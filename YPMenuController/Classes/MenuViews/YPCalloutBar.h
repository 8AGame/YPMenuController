//
//  YPCalloutBar.h
//  Pods-YPMenuController_Example
//
//  Created by Yaping Liu on 3/19/19.
//

#import <UIKit/UIKit.h>
#import "YPMenuComponets.h"

@class YPMenuItem;

NS_ASSUME_NONNULL_BEGIN

@interface YPCalloutBar : UIView

@property (nonatomic, assign) CGFloat barHeight;

- (void)layoutBarItemsWithMenuItems:(NSArray<YPMenuItem *> *)menuItems
                      transformRect:(CGRect)transformRect
                           menuType:(YPMenuControllerType)menuType;

@end

NS_ASSUME_NONNULL_END
