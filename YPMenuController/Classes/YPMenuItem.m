//
//  YPMenuItem.m
//  Pods-YPMenuController_Example
//
//  Created by Yaping Liu on 3/20/19.
//

#import "YPMenuItem.h"

@interface YPMenuItem ()

@property (nonatomic, strong) UIButton *menuButton;

@end

@implementation YPMenuItem

#pragma mark -- Initialize

+ (instancetype)itemSystemWithAction:(SEL)action
                               title:(NSString *)title {
    return [YPMenuItem itemTitleAndImageWithAction:action title:title image:nil itemType:YPMenuItemSystem];
}

+ (instancetype)itemTitleAndImageWithAction:(SEL)action
                                      title:(NSString *)title
                                      image:(UIImage *)image
                                   itemType:(YPMenuItemType)itemType {
    YPMenuItem *item = [[YPMenuItem alloc] initMenuItem];
    item->_title = title;
    item->_action = action;
    item->_image = image;
    item->_itemType = itemType;
    [item createBarButton];
    return item;
}


+ (instancetype)itemTitleAndImageWithAction:(SEL)action
                                 customView:(UIView *)customView {
    YPMenuItem *item = [[YPMenuItem alloc] initMenuItem];
    item->_action = action;
    item->_customView = customView;
    return item;
}

- (instancetype)initMenuItem
{
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark -- menuViews

- (void)createBarButton {
    //custom style
    if (self.itemType == YPMenuItemCustom) {
        return;
    }
    //image and title style
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.title) {
        [self.menuButton setTitle:self.title forState:UIControlStateNormal];
        self.menuButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    if (self.image) {
        [self.menuButton setImage:self.image forState:UIControlStateNormal];
    }
    switch (self.itemType) {
        case YPMenuItemImageOnly:
            
            break;
        case YPMenuItemImageUpTitleDown:
            
            break;
        case YPMenuItemTitleUpImageDown:
            
            break;
        case YPMenuItemImageLeftTitleRight:
            
            break;
        case YPMenuItemTitleLeftImageRight:
            
            break;
        case YPMenuItemSystem:
        default:
            break;
    }
}

@end
