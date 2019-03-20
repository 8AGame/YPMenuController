//
//  YPCalloutBar.h
//  Pods-YPMenuController_Example
//
//  Created by Yaping Liu on 3/19/19.
//

#import <UIKit/UIKit.h>
#import "YPMenuItem+Private.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPCalloutBar : UIView

@property (nonatomic, assign) CGFloat barHeight;

@property(nonatomic, strong) NSArray<YPMenuItem *> *menuItems;

@end

NS_ASSUME_NONNULL_END
