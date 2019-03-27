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
#pragma mark -- Bar properties
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
 Bar shadow color.
 The default is grayColor.
 */
@property (nonatomic, strong) UIColor *barShadowColor;
/**
 Bar dismis delay interval.
 The default is 0.
 */
@property (nonatomic, assign) NSTimeInterval barDismissDelayInterval;

#pragma mark -- Menu button properties
#pragma mark The properties in this section is invalid when `menuType` is `YPMenuControllerCustom`
/**
 Spacing between image and title.
 The default is 5.
 */
@property (nonatomic, assign) CGFloat contentSpace;
/**
 Menu button content edge insets.
 The default is UIEdgeInsetsMake(0, 15, 0, 15).
 */
@property (nonatomic, assign) UIEdgeInsets menuContentEdge;
/**
 Title color.
 The default is whiteColor.
 */
@property (nonatomic, strong) UIColor *titleColor;
/**
 Touch highlight color.
 The default is lightGrayColor.
 */
@property (nonatomic, strong) UIColor *backHighlightColor;

/**
 Title font.
 The default is system font with 14 size.
 */
@property (nonatomic, strong) UIFont *titleFont;

#pragma mark -- Other properties
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
