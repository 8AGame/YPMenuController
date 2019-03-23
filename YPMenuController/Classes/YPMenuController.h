//
//  YPMenuController.h
//  Pods-YPMenuController_Example
//
//  Created by Yaping Liu on 3/18/19.
//

#import "YPMenuItem.h"
#import "YPMenuComponets.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPMenuController : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

+ (YPMenuController *)sharedMenuController;

@property(nonatomic, strong, readonly) NSArray<YPMenuItem *> *menuItems;

@property(nonatomic, assign, readonly) YPMenuControllerType menuType;

- (void)setMenuItems:(NSArray<YPMenuItem *> *)menuItems
            menuType:(YPMenuControllerType)menuType;

- (void)menuVisibleInView:(UIView *)targetView
               targetRect:(CGRect)targetRect
                 animated:(BOOL)animated;

- (void)menuInvisibleWithAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
