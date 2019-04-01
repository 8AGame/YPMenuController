//
//  YPMenuItem.h
//
//  Created by Yaping Liu on 3/20/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPMenuItem : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
/**
 System style item.
 */
- (instancetype)initSystemWithAction:(SEL)action
                               title:(NSString *)title NS_DESIGNATED_INITIALIZER;
/**
  Image and title style item.
 */
- (instancetype)initTitleAndImageWithAction:(SEL)action
                                      title:(nullable NSString *)title
                                      image:(nullable UIImage *)image NS_DESIGNATED_INITIALIZER;
/**
 Custom view style item.
 */
- (instancetype)initWithCustomView:(UIView *)customView NS_DESIGNATED_INITIALIZER;

/**
 `action` can only be performed when `targetView` call `canPerformAction:withSender:` method to return YES.
 */
@property (nonatomic, assign, nullable, readonly) SEL action;

@property (nonatomic, strong, nullable, readonly) NSString *title;

@property (nonatomic, strong, nullable, readonly) UIImage *image;

@property (nonatomic, strong, nullable, readonly) UIView *customView;

@end

NS_ASSUME_NONNULL_END
