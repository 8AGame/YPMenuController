//
//  YPMenuController.h
//  Pods-YPMenuController_Example
//
//  Created by Yaping Liu on 3/18/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPMenuController : NSObject

+ (YPMenuController *)sharedMenuController;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@property(nonatomic,getter=isMenuVisible) BOOL menuVisible; // default is NO

- (void)setMenuVisible:(BOOL)menuVisible animated:(BOOL)animated;

- (void)setTargetRect:(CGRect)targetRect inView:(UIView *)targetView;

@property(nullable, nonatomic, copy) NSArray<id> *menuItems;

@end

NS_ASSUME_NONNULL_END
