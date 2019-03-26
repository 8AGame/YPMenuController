//
//  YPMenuStyleConfig.h
//
//  Created by Yaping Liu on 3/26/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YPMenuComponets.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPMenuStyleConfig : NSObject
/**
 Menu type.
 The default is `YPMenuControllerSystem`.
 */
@property (nonatomic, assign) YPMenuControllerType menuType;
/**
 Arrow direction.
 The default is `YPMenuControllerArrowDefault`.
 */
@property (nonatomic, assign) YPMenuControllerArrowDirection arrowDirection;
/**
 Bar view height.
 The default is automatically calculated based on `menuType`.
 */
@property (nonatomic, assign) CGFloat barHeight;
/**
 Bar background color.
 The default is red:31 green:31 blue:31 alpha:0.96.
 */
@property (nonatomic, strong) UIColor *barBackgroundColor;
/**
 Title color.
 The default is whiteColor.
 */
@property (nonatomic, strong) UIColor *titleColor;
/**
 Title font.
 The default is system font with 14 size.
 */
@property (nonatomic, strong) UIFont *titleFont;
/**
 Skip button triangle image color.
 The default is whiteColor.
 */
@property (nonatomic, strong) UIColor *skipTriangleColor;
/**
 Separator line color.
 The default is whiteColor.
 */
@property (nonatomic, strong) UIColor *separatorLineColor;

@end

NS_ASSUME_NONNULL_END
