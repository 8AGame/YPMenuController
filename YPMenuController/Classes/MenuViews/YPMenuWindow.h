//
//  YPMenuEffectWindow.h
//  Pods-YPMenuController_Example
//
//  Created by Yaping Liu on 3/18/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPMenuWindow : UIWindow

@property (nonatomic, strong) BOOL(^touchPointInsideCanRespond)(CGPoint point);

@end

NS_ASSUME_NONNULL_END
