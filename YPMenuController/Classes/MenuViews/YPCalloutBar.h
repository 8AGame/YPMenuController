//
//  YPCalloutBar.h

//
//  Created by Yaping Liu on 3/19/19.
//

#import <UIKit/UIKit.h>
#import "YPMenuComponets.h"

@class YPMenuItem;

NS_ASSUME_NONNULL_BEGIN

@interface YPCalloutBar : UIView

- (instancetype)initWithMenuItems:(NSArray<YPMenuItem *> *)menuItems
                    transformRect:(CGRect)transformRect
                         menuType:(YPMenuControllerType)menuType
                   arrowDirection:(YPMenuControllerArrowDirection)arrowDirection;

- (void)layoutBarItems;

@property (nonatomic, copy) void (^triggerClickBlock)(SEL action);


@property (nonatomic, assign) CGFloat barHeight;



@end

NS_ASSUME_NONNULL_END
