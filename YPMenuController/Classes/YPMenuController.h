//
//  YPMenuController.h
//
//  Created by Yaping Liu on 3/18/19.
//

#import "YPMenuItem.h"
#import "YPMenuStyleConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPMenuController : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

+ (YPMenuController *)sharedMenuController;

@property(nonatomic, assign, readonly) BOOL menuVisible;
/**
 This value has a default configuration,
 and its properties are the default value mentioned in `YPMenuStyleConfig.h` file.
 */
@property(nonatomic, strong) YPMenuStyleConfig *styleConfig;
/**
 Menu items.
 `YPMenuItem` object can display when `targetView` call `canPerformAction:withSender:` method with `action` param to return YES.
 */
@property(nonatomic, copy) NSArray<YPMenuItem *> *menuItems;

/**
 Make menu controller visible.
 @param targetRect   A rectangle that defines the area that is to be the target of the menu commands.
 @param targetView   The view in which targetRect appears.
 @param animated     YES if the showing of the menu should be animated, otherwise NO.
 */
- (void)menuVisibleInView:(UIView *)targetView
               targetRect:(CGRect)targetRect
                 animated:(BOOL)animated;

/**
 Make menu controller visible.
 @param targetX      The targetView x axis coordinate.
 @param menuWindowY  The menuWindow y axis coordinate.
 @param targetView   The view in which targetRect appears.
 @param animated     YES if the showing of the menu should be animated, otherwise NO.
 */
- (void)menuVisibleInView:(UIView *)targetView
                  targetX:(CGFloat)targetX
              menuWindowY:(CGFloat)menuWindowY
                 animated:(BOOL)animated;


/**
 Make menu controller invisible.
 @param animated     YES if the hiding of the menu should be animated, otherwise NO.
 */
- (void)menuInvisibleWithAnimated:(BOOL)animated;

@end

UIKIT_EXTERN NSNotificationName const YPMenuControllerWillShowMenuNotification;
UIKIT_EXTERN NSNotificationName const YPMenuControllerDidShowMenuNotification;
UIKIT_EXTERN NSNotificationName const YPMenuControllerWillHideMenuNotification;
UIKIT_EXTERN NSNotificationName const YPMenuControllerDidHideMenuNotification;

NS_ASSUME_NONNULL_END
