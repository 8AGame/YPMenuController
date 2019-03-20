//
//  YPMenuController.h
//  Pods-YPMenuController_Example
//
//  Created by Yaping Liu on 3/18/19.
//

#import "YPMenuItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPMenuController : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

+ (YPMenuController *)sharedMenuController;

@property(nonatomic, copy) NSArray<YPMenuItem *> *menuItems;

@property(nonatomic,getter=isMenuVisible) BOOL menuVisible; // default is NO

- (void)setTargetRect:(CGRect)targetRect inView:(UIView *)targetView;

- (void)setMenuVisible:(BOOL)menuVisible animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
