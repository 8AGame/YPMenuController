//
//  YPMenuItem.h
//  Pods-YPMenuController_Example
//
//  Created by Yaping Liu on 3/20/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YPMenuItemType) {
    YPMenuItemSystem,
    YPMenuItemImageOnly,
    YPMenuItemTitleLeftImageRight,
    YPMenuItemImageLeftTitleRight,
    YPMenuItemImageUpTitleDown,
    YPMenuItemTitleUpImageDown,
    YPMenuItemCustom
};

@interface YPMenuItem : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

+ (instancetype)itemSystemWithAction:(SEL)action
                               title:(NSString *)title;

+ (instancetype)itemTitleAndImageWithAction:(SEL)action
                                      title:(nullable NSString *)title
                                      image:(nullable UIImage *)image
                                   itemType:(YPMenuItemType)itemType;

+ (instancetype)itemTitleAndImageWithAction:(SEL)action
                                 customView:(UIView *)customView;

@property (nonatomic, assign, readonly) YPMenuItemType itemType;

@property (nonatomic, assign, readonly) SEL action;

@property (nonatomic, strong, nullable, readonly) NSString *title;

@property (nonatomic, strong, nullable, readonly) UIImage *image;

@property (nonatomic, strong, nullable, readonly) UIView *customView;

@end

NS_ASSUME_NONNULL_END
