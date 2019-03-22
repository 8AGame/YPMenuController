//
//  YPCalloutBar.m
//  Pods-YPMenuController_Example
//
//  Created by Yaping Liu on 3/19/19.
//

#import "YPCalloutBar.h"
#import "YPMenuItem.h"

#define kBarHeight              60
#define kBarMarginLeft          10
#define kBarContentHeight       36
#define kBarContentMarginTop    15
#define kSkipBtnWidth           29

#define kBarMaxWidth  ((CGRectGetWidth([UIScreen mainScreen].bounds))-(kBarMarginLeft)*2)

@interface YPCalloutBar ()

@property (nonatomic, assign) NSRange showMenusRange;

@property (nonatomic, strong) UIButton *leftSkipBtn;

@property (nonatomic, strong) UIButton *rightSkipBtn;

@end

@implementation YPCalloutBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutBarItemsWithMenuItems:(NSArray<YPMenuItem *> *)menuItems
                      transformRect:(CGRect)transformRect
                           menuType:(YPMenuControllerType)menuType
{
    //custom style
    if (menuType == YPMenuControllerCustom) {
        return;
    }
    CGFloat maxWidth = kBarMaxWidth;
    CGFloat totalWidth = 0;

    NSMutableArray *menuBtns = [[NSMutableArray alloc] init];
    for (YPMenuItem *item in menuItems) {
        //image and title style
        UIButton *menuBtn = [self createBarButtonWithMenuItem:item menuType:menuType];
        CGFloat maxContent = maxWidth - kSkipBtnWidth *2;
        CGSize size = [menuBtn sizeThatFits:CGSizeMake(maxContent, kBarContentHeight)];
        menuBtn.frame = CGRectMake(0, 0, size.width, size.height);
        totalWidth += size.width;
        [menuBtns addObject:menuBtn];
    }
    if (totalWidth <= maxWidth) {
        CGFloat menuTotalWidth = [self layoutMenusWithRange:NSMakeRange(0, menuBtns.count) transformRect:transformRect menuBtns:menuBtns];
        [self setCallBarFrameWithTransformRect:transformRect barWidth:menuTotalWidth];

    }else{
        CGFloat restWidth = maxWidth - kSkipBtnWidth;
        NSRange showRange = [self calculateShowMenusRangeWithMaxWidth:restWidth menuBtns:menuBtns];
        
        CGFloat menuTotalWidth = [self layoutMenusWithRange:showRange transformRect:transformRect menuBtns:menuBtns];
        
        UIButton *skipButton = [self createSkipButtonForIsLeft:NO];
        skipButton.frame = CGRectMake(menuTotalWidth, kBarContentMarginTop, kSkipBtnWidth, kBarContentHeight);
        [self addSubview:skipButton];
        menuTotalWidth += kSkipBtnWidth;
        
        [self setCallBarFrameWithTransformRect:transformRect barWidth:menuTotalWidth];
    }


    [self addBackupLayerForMiddleX:CGRectGetMidX(transformRect)];
}

- (CGFloat)layoutMenusWithRange:(NSRange)range
               transformRect:(CGRect)transformRect
                    menuBtns:(NSMutableArray *)menuBtns{
    
    CGFloat curX = 0;
    NSInteger startLoc = range.location;
    NSInteger length = NSMaxRange(range);
    for (; startLoc < length; startLoc++) {
        UIButton *perBtn = menuBtns[startLoc];
        perBtn.frame = CGRectMake(curX, kBarContentMarginTop, CGRectGetWidth(perBtn.frame), kBarContentHeight);
        [self addSubview:perBtn];
        curX += CGRectGetWidth(perBtn.frame);
        //line view
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(curX, kBarContentMarginTop, 1, kBarContentHeight)];
        lineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        [self addSubview:lineView];
    }
    //Menu total width
    return curX;
}

- (NSRange)calculateShowMenusRangeWithMaxWidth:(CGFloat)maxWidth
                                      menuBtns:(NSMutableArray *)menuBtns {
    CGFloat curTotal = 0;
    NSInteger startLoc = NSMaxRange(self.showMenusRange);
    NSInteger endLoc = startLoc;
    for (; endLoc < menuBtns.count; endLoc++) {
        UIButton *btn = menuBtns[endLoc];
        curTotal += btn.frame.size.width;
        if (curTotal > maxWidth) break;
    }
    self.showMenusRange = NSMakeRange(startLoc, endLoc-startLoc);
    return self.showMenusRange;
}

- (UIButton *)createBarButtonWithMenuItem:(YPMenuItem *)menuItem
                                 menuType:(YPMenuControllerType)menuType {
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.backgroundColor = [UIColor clearColor];
    menuBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);

    if (menuItem.title &&
        (menuType == YPMenuControllerSystem ||
        menuType == YPMenuControllerImageUpTitleDown ||
        menuType == YPMenuControllerTitleUpImageDown ||
        menuType == YPMenuControllerImageLeftTitleRight ||
        menuType == YPMenuControllerTitleLeftImageRight)) {
        
        [menuBtn setTitle:menuItem.title forState:UIControlStateNormal];
        menuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    if (menuItem.image &&
        (menuType == YPMenuControllerImageOnly ||
        menuType == YPMenuControllerImageUpTitleDown ||
        menuType == YPMenuControllerTitleUpImageDown ||
        menuType == YPMenuControllerImageLeftTitleRight ||
        menuType == YPMenuControllerTitleLeftImageRight)) {
        
        [menuBtn setImage:menuItem.image forState:UIControlStateNormal];
    }
    switch (menuType) {
        case YPMenuControllerImageOnly:
            
            break;
        case YPMenuControllerImageUpTitleDown:
            
            break;
        case YPMenuControllerTitleUpImageDown:
            
            break;
        case YPMenuControllerImageLeftTitleRight:

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

- (void)setCallBarFrameWithTransformRect:(CGRect)transformRect
                                barWidth:(CGFloat)barWidth {
    CGFloat barX = 0;
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (CGRectGetMidX(transformRect) < CGRectGetMidX(bounds)) {
        barX = kBarMarginLeft;
    }else{
        barX = CGRectGetWidth(bounds) - barWidth - kBarMarginLeft;
    }
    self.frame = CGRectMake(barX, CGRectGetMaxY(transformRect), barWidth, kBarHeight);
}

#pragma mark -- Skip buttons
- (void)leftSikpAction {
    
}
- (void)rightSikpAction {
    
}

- (UIButton *)leftSkipBtn {
    if (!_leftSkipBtn) {
        _leftSkipBtn = [self createSkipButtonForIsLeft:YES];
    }
    return _leftSkipBtn;
}

- (UIButton *)rightSkipBtn {
    if (!_rightSkipBtn) {
        _rightSkipBtn = [self createSkipButtonForIsLeft:NO];
    }
    return _rightSkipBtn;
}

- (UIButton *)createSkipButtonForIsLeft:(BOOL)isLeft {
    UIImage *resultImage = nil;
    CGSize size = CGSizeMake(8.7, 8.7);
    UIColor *tintColor = [UIColor whiteColor];
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPath];
    if (isLeft) {
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

    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    skipButton.backgroundColor = [UIColor clearColor];
    skipButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    [skipButton setImage:resultImage forState:UIControlStateNormal];
    SEL sel = isLeft ? @selector(leftSikpAction) : @selector(rightSikpAction);
    [skipButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    return skipButton;
}

#pragma mark -- Backup layer
- (void)addBackupLayerForMiddleX:(CGFloat)middleX {
    CAShapeLayer *backupLayer = [CAShapeLayer layer];
    backupLayer.backgroundColor = [UIColor clearColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat cornerRadius = 6;
    CGFloat triangleMarginTop = 5;
    CGFloat triangleRadius = 8;
    //rectangle
    CGRect pathRect = CGRectMake(0, kBarContentMarginTop, width, kBarContentHeight);
    path = [UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:cornerRadius];
    //triangle
    middleX -= self.frame.origin.x;
    [path moveToPoint:CGPointMake(middleX, triangleMarginTop)];
    [path addLineToPoint:CGPointMake(middleX-triangleRadius, kBarContentMarginTop)];
    [path addLineToPoint:CGPointMake(middleX+triangleRadius, kBarContentMarginTop)];

    backupLayer.path = path.CGPath;
    backupLayer.frame = self.bounds;
    backupLayer.fillColor = [UIColor colorWithRed:31/255 green:31/288 blue:31/255 alpha:0.96].CGColor;
    [self.layer insertSublayer:backupLayer atIndex:0];
}


@end
