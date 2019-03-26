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

@property (nonatomic, assign) YPMenuControllerType menuType;

@property (nonatomic, assign) YPMenuControllerArrowDirection arrowDirection;

@property (nonatomic, assign) CGFloat barHeight;

@property (nonatomic, strong) UIColor *barBackgroundColor;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *triangleColor;

@property (nonatomic, strong) UIColor *separatorLineColor;

+ (instancetype)defaultStyleConfig;

@end

NS_ASSUME_NONNULL_END
