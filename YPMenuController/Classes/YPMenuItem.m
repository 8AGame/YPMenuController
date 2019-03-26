//
//  YPMenuItem.m
//
//  Created by Yaping Liu on 3/20/19.
//

#import "YPMenuItem.h"

@implementation YPMenuItem

#pragma mark -- Initialize
- (instancetype)initSystemWithAction:(SEL)action
                               title:(NSString *)title {
    self = [super init];
    if (self) {
        self->_title = title;
        self->_action = action;
    }
    return self;

}

- (instancetype)initTitleAndImageWithAction:(SEL)action
                                      title:(nullable NSString *)title
                                      image:(nullable UIImage *)image {
    self = [super init];
    if (self) {
        self->_title = title;
        self->_action = action;
        self->_image = image;
    }
    return self;
}

- (instancetype)initTitleAndImageWithAction:(SEL)action
                                 customView:(UIView *)customView {
    self = [super init];
    if (self) {
        self->_action = action;
        self->_customView = customView;
    }
    return self;
}


@end
