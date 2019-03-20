//
//  YPCalloutBar.m
//  Pods-YPMenuController_Example
//
//  Created by Yaping Liu on 3/19/19.
//

#import "YPCalloutBar.h"
#import "YPMenuItem.h"

@interface YPCalloutBar ()


@end

@implementation YPCalloutBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    }
    return self;
}

- (void)layoutBarItemsWithMenuItems:(NSArray<YPMenuItem *> *)menuItems
                      transformRect:(CGRect)transformRect
                           menuType:(YPMenuControllerType)menuType
{
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGFloat gapX = 10;
    CGFloat height = 60;
    CGFloat maxWidth = CGRectGetWidth(bounds)-gapX*2;
    self.frame = CGRectMake(gapX, CGRectGetMaxY(transformRect), maxWidth, height);
    
    CGFloat totalWidth = 0;
    NSMutableArray *btns = [[NSMutableArray alloc] init];
    for (YPMenuItem *item in menuItems) {
        //custom style
        if (menuType == YPMenuControllerCustom) {
            continue;
        }
        //image and title style
        UIButton *menuBtn = [self createBarButtonWithMenuItem:item menuType:menuType];
        CGSize size = [menuBtn sizeThatFits:CGSizeMake(maxWidth, height)];
        totalWidth += size.width;
        [btns addObject:menuBtn];
    }
    
    if (totalWidth < maxWidth) {
        CGFloat marginTop = 15;
        CGFloat height = 36;
        CGFloat currentX = 0;
        for (UIButton *btn in btns) {
            CGSize size = [btn sizeThatFits:CGSizeMake(maxWidth, height)];
            btn.frame = CGRectMake(currentX, marginTop, size.width, height);
            [self addSubview:btn];
            currentX += size.width;
        }
    }
    [self addBackupLayer];
}


- (UIButton *)createBarButtonWithMenuItem:(YPMenuItem *)menuItem
                                 menuType:(YPMenuControllerType)menuType {
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.backgroundColor = [UIColor clearColor];
        menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (menuItem.title) {
        [menuBtn setTitle:menuItem.title forState:UIControlStateNormal];
        menuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    if (menuItem.image) {
        [menuBtn setImage:menuItem.image forState:UIControlStateNormal];
    }
    menuBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    switch (menuType) {
        case YPMenuControllerImageOnly:
            
            break;
        case YPMenuControllerImageUpTitleDown:
            
            break;
        case YPMenuControllerTitleUpImageDown:
            
            break;
        case YPMenuControllerImageLeftTitleRight:
        {
//            [menuBtn se]
        }
            break;
        case YPMenuControllerTitleLeftImageRight:
            
            break;
        case YPMenuControllerSystem:
        default:
            break;
    }
    return menuBtn;
}

- (void)itemButtonAction:(id)sender {
    
}

- (void)addBackupLayer {
    CAShapeLayer *backupLayer = [CAShapeLayer layer];
    backupLayer.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer insertSublayer:backupLayer atIndex:0];
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat marginTop = 15;
    CGFloat height = 36;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat cornerRadius = 6;
    CGFloat middleX = width/2.0;
    CGFloat triangleMarginTop = 5;
    CGFloat triangleRadius = 8;
    //rectangle
    CGRect pathRect = CGRectMake(0, marginTop, width, height);
    path = [UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:cornerRadius];
    //triangle
    [path moveToPoint:CGPointMake(middleX, triangleMarginTop)];
    [path addLineToPoint:CGPointMake(middleX-triangleRadius, marginTop)];
    [path addLineToPoint:CGPointMake(middleX+triangleRadius, marginTop)];

    backupLayer.path = path.CGPath;
    backupLayer.frame = self.bounds;
    backupLayer.fillColor = [UIColor colorWithRed:26/255 green:26/288 blue:27/255 alpha:1].CGColor;
}

+ (UIImage *)createTriangleImageWithSize:(CGSize)size tintColor:(UIColor *)tintColor isRight:(BOOL)isRight
{
    size = CGSizeMake(8.7, 8.7);
    UIImage *resultImage = nil;
    
    tintColor = tintColor ? tintColor : [UIColor whiteColor];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPath];
    if (!isRight) {
        [path moveToPoint:CGPointMake(0, size.height/2)];
        [path addLineToPoint:CGPointMake(size.width , 0)];
        [path addLineToPoint:CGPointMake(size.width, size.height)];
        [path closePath];
    } else {
        [path moveToPoint:CGPointMake(0, size.height)];
        [path addLineToPoint:CGPointMake(0 , 0)];
        [path addLineToPoint:CGPointMake(size.width, size.height/2)];
        [path closePath];
    }
    CGContextSetFillColorWithColor(context, tintColor.CGColor);
    [path fill];
    
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}


@end
