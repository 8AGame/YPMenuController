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

@property(nonatomic, strong) YPMenuStyleConfig *styleConfig;

@property(nonatomic, copy) NSArray<YPMenuItem *> *menuItems;

//Make menu visible.
- (void)menuVisibleInView:(UIView *)targetView
               targetRect:(CGRect)targetRect
                 animated:(BOOL)animated;

//Make menu invisible.
- (void)menuInvisibleWithAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
