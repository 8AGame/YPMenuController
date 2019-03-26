//
//  YPCalloutBar.m
//
//  Created by Yaping Liu on 3/19/19.
//


#import "YPCalloutBar.h"
#import <objc/runtime.h>

#import "YPMenuItem.h"
#import "YPMenuStyleConfig.h"

/// Bar frame
#define kBarMarginLeft                      10

#define kSkipBtnWidth                       32

#define kContentTowardTargetViewMargin      15

#define kContentTowardRearMargin            9

#define kSpacingBetweenTitleAndImage        5

#define kContentHeight \
((self.styleConfig.barHeight) - (kContentTowardTargetViewMargin) - (kContentTowardRearMargin))

#define kBarMaxWidth  \
((CGRectGetWidth([UIScreen mainScreen].bounds))-(kBarMarginLeft)*2)

/// Backup layer frame
#define kBackupLayerCornerRadius            6

#define kTriangleArrowsTowardContentMargin  5

#define kTriangleRadiusWidth                8

@interface YPMenuNode: NSObject

@property (nonatomic, strong) YPMenuNode *previous;

@property (nonatomic, assign) NSRange currentRange;

@end
@implementation YPMenuNode @end


@interface YPCalloutBar ()

@property (nonatomic, strong) CAShapeLayer *backupLayer;

@property (nonatomic, strong) UIButton *leftSkipBtn;

@property (nonatomic, strong) UIButton *rightSkipBtn;

@property (nonatomic, assign) CGRect transformRect;

@property (nonatomic, strong) YPMenuNode *currentNode;

@property (nonatomic, strong) NSMutableArray *menuItemBtns;

@property (nonatomic, strong) NSArray<YPMenuItem *> *menuItems;

@property (nonatomic, strong) YPMenuStyleConfig *styleConfig;

@end

@implementation YPCalloutBar

- (instancetype)initWithMenuItems:(NSArray<YPMenuItem *> *)menuItems
                    transformRect:(CGRect)transformRect
                      styleConfig:(YPMenuStyleConfig *)styleConfig {
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.transformRect = transformRect;
        self.menuItems = menuItems;
        self.styleConfig = styleConfig;
    }
    return self;

}

- (void)layoutBarItems {
    //custom style
    if (self.styleConfig.menuType== YPMenuControllerCustom) {
        return;
    }
    CGFloat totalWidth = 0;
    self.menuItemBtns = [[NSMutableArray alloc] init];
    for (YPMenuItem *item in self.menuItems) {
        //image and title style
        UIButton *menuBtn = [self createBarButtonWithMenuItem:item];
        totalWidth += CGRectGetWidth(menuBtn.frame);
        [self.menuItemBtns addObject:menuBtn];
    }
    if (totalWidth <= kBarMaxWidth) {
        [self layoutMenusWhetherHasMore:NO towardRight:NO];

    }else{
        [self layoutMenusWhetherHasMore:YES towardRight:YES];
    }
}

- (void)layoutMenusWhetherHasMore:(BOOL)hasMore towardRight:(BOOL)towardRight {
 
    CGFloat totalWidth = 0;
    CGFloat contentMarginTop = [self getBarContentMarginTop];

    //menu range
    NSRange range = NSMakeRange(0, self.menuItemBtns.count);
    if (hasMore) {
        range = [self calculateShowRangeForHasMoreWithTowardRight:towardRight];
    }
    //left skip button
    if (hasMore && range.location > 0) {
        self.leftSkipBtn.frame = CGRectMake(0, contentMarginTop, kSkipBtnWidth, kContentHeight);
        [self addSubview:self.leftSkipBtn];
        totalWidth += kSkipBtnWidth;
        //line view
        [self addSubview:[self lineViewWithXValue:totalWidth]];
    }
    
    //menus button
    NSInteger startLoc = range.location;
    NSInteger length = NSMaxRange(range);
    for (; startLoc < length; startLoc++) {
        UIButton *perBtn = self.menuItemBtns[startLoc];
        perBtn.frame = CGRectMake(totalWidth, contentMarginTop, CGRectGetWidth(perBtn.frame), CGRectGetHeight(perBtn.frame));
        [self addSubview:perBtn];
        totalWidth += CGRectGetWidth(perBtn.frame);
        //line view
        [self addSubview:[self lineViewWithXValue:totalWidth]];
    }
    
    //right skip button
    if (hasMore) {
        self.rightSkipBtn.enabled = YES;
        self.rightSkipBtn.frame = CGRectMake(totalWidth, contentMarginTop, kSkipBtnWidth, kContentHeight);
        [self addSubview:self.rightSkipBtn];
        totalWidth += kSkipBtnWidth;
        if (NSMaxRange(range) >= self.menuItems.count) {
            self.rightSkipBtn.enabled = NO;
        }
    }
    [self setCallBarFrameWithBarWidth:totalWidth];
}

- (NSRange)calculateShowRangeForHasMoreWithTowardRight:(BOOL)towardRight  {
    if (!towardRight){
        self.currentNode = self.currentNode.previous;
        return self.currentNode.currentRange;
    }
    //`startLoc` is 0 indicate that initial bar view.
    NSInteger startLoc = NSMaxRange(self.currentNode.currentRange);

    int skipBtnCount = 1;
    if (startLoc > 0) skipBtnCount = 2;
    CGFloat restWidth = kBarMaxWidth - skipBtnCount * kSkipBtnWidth;
    
    CGFloat curTotal = 0;
    NSInteger endLoc = startLoc;
    for (; endLoc < self.menuItemBtns.count; endLoc++) {
        UIButton *btn = self.menuItemBtns[endLoc];
        curTotal += btn.frame.size.width;
        if (curTotal > restWidth) break;
    }
    YPMenuNode *node = [[YPMenuNode alloc] init];
    if (startLoc > 0) {
        node.previous = self.currentNode;
    }else {
        node.previous = nil;
    }
    node.currentRange = NSMakeRange(startLoc, endLoc-startLoc);
    self.currentNode = node;
    return self.currentNode.currentRange;
}

- (UIButton *)createBarButtonWithMenuItem:(YPMenuItem *)menuItem {
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.backgroundColor = [UIColor clearColor];
    menuBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    [menuBtn addTarget:self action:@selector(itemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(menuBtn, @selector(itemButtonAction:), menuItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (menuItem.title &&
        (self.styleConfig.menuType== YPMenuControllerSystem ||
        self.styleConfig.menuType== YPMenuControllerImageTopTitleBottom ||
        self.styleConfig.menuType== YPMenuControllerTitleTopImageBottom ||
        self.styleConfig.menuType== YPMenuControllerImageLeftTitleRight ||
        self.styleConfig.menuType== YPMenuControllerTitleLeftImageRight)) {
        
            [menuBtn setTitle:menuItem.title forState:UIControlStateNormal];
            menuBtn.titleLabel.font = self.styleConfig.titleFont;
            [menuBtn setTitleColor:self.styleConfig.titleColor forState:UIControlStateNormal];
    }
    if (menuItem.image &&
        (self.styleConfig.menuType== YPMenuControllerImageOnly ||
        self.styleConfig.menuType== YPMenuControllerImageTopTitleBottom ||
        self.styleConfig.menuType== YPMenuControllerTitleTopImageBottom ||
        self.styleConfig.menuType== YPMenuControllerImageLeftTitleRight ||
        self.styleConfig.menuType== YPMenuControllerTitleLeftImageRight)) {
            [menuBtn setImage:menuItem.image forState:UIControlStateNormal];
    }
    CGFloat maxContent = kBarMaxWidth - kSkipBtnWidth * 2;
    CGSize size = [menuBtn sizeThatFits:CGSizeMake(maxContent, kContentHeight)];
    CGFloat btnWidth = size.width;
    if (btnWidth > maxContent) {
        btnWidth = maxContent;
        menuBtn.clipsToBounds = YES;
    }
    menuBtn.frame = CGRectMake(0, 0, btnWidth, kContentHeight);
    switch (self.styleConfig.menuType) {
        case YPMenuControllerImageOnly:
            
            break;
            
        case YPMenuControllerImageTopTitleBottom:
            menuBtn.titleEdgeInsets = UIEdgeInsetsMake(menuBtn.imageView.intrinsicContentSize.height + kSpacingBetweenTitleAndImage, - menuBtn.imageView.intrinsicContentSize.width, 0, 0);
            menuBtn.imageEdgeInsets = UIEdgeInsetsMake(0, menuBtn.titleLabel.intrinsicContentSize.width/2, menuBtn.titleLabel.intrinsicContentSize.height+kSpacingBetweenTitleAndImage, - menuBtn.titleLabel.intrinsicContentSize.width/2);
            break;
            
        case YPMenuControllerTitleTopImageBottom:
            menuBtn.titleEdgeInsets = UIEdgeInsetsMake(-menuBtn.imageView.intrinsicContentSize.height-kSpacingBetweenTitleAndImage,  -menuBtn.imageView.intrinsicContentSize.width, 0, 0);
            menuBtn.imageEdgeInsets = UIEdgeInsetsMake(0, menuBtn.titleLabel.intrinsicContentSize.width/2, -menuBtn.titleLabel.intrinsicContentSize.height-kSpacingBetweenTitleAndImage,  menuBtn.titleLabel.intrinsicContentSize.width/2);
            break;
            
        case YPMenuControllerImageLeftTitleRight:
            menuBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -kSpacingBetweenTitleAndImage, 0, 0);

            break;
            
        case YPMenuControllerTitleLeftImageRight:
            menuBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -menuBtn.imageView.intrinsicContentSize.width-kSpacingBetweenTitleAndImage, 0, menuBtn.imageView.intrinsicContentSize.width);
            menuBtn.imageEdgeInsets = UIEdgeInsetsMake(0, menuBtn.titleLabel.intrinsicContentSize.width, 0, -menuBtn.titleLabel.intrinsicContentSize.width-kSpacingBetweenTitleAndImage);
            break;
            
        case YPMenuControllerSystem:
        default:
            
            break;
    }
    return menuBtn;
}

- (void)itemButtonAction:(id)sender {
    YPMenuItem *item = objc_getAssociatedObject(sender, @selector(itemButtonAction:));
    if (item && [item isKindOfClass:YPMenuItem.class]) {
        if (self.triggerClickBlock) {
            self.triggerClickBlock(item.action);
        }
    }
}

- (UIView *)lineViewWithXValue:(CGFloat)xValue {
    CGFloat contentMarginTop = [self getBarContentMarginTop];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(xValue, contentMarginTop, 1, kContentHeight)];
    lineView.backgroundColor = [self.styleConfig.separatorLineColor colorWithAlphaComponent:0.8];
    return lineView;
}

- (void)setCallBarFrameWithBarWidth:(CGFloat)barWidth {
    //x
    CGFloat barX = 0;
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (CGRectGetMidX(self.transformRect) < CGRectGetMidX(bounds)) {
        barX = kBarMarginLeft;
    }else{
        barX = CGRectGetWidth(bounds) - barWidth - kBarMarginLeft;
    }
    //y
    CGFloat barY = 0;
    if ([self getRealArrowDirection] == YPMenuControllerArrowUp) {
        barY = CGRectGetMaxY(self.transformRect);

    } else if ([self getRealArrowDirection] == YPMenuControllerArrowDown) {
        barY = CGRectGetMinY(self.transformRect) - self.styleConfig.barHeight;
    }
    self.frame = CGRectMake(barX, barY, barWidth, self.styleConfig.barHeight);
    [self addBackupLayer];
}

#pragma mark -- Skip buttons
- (void)leftSikpAction {
    [self clearAllSubViews];
    [self layoutMenusWhetherHasMore:YES towardRight:NO];
}

- (void)rightSikpAction {
    [self clearAllSubViews];
    [self layoutMenusWhetherHasMore:YES towardRight:YES];
}
- (void)clearAllSubViews {
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    [self.backupLayer removeFromSuperlayer];
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

    CGSize size = CGSizeMake(10, 10);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //points
    CGPoint moveToPoint = CGPointZero;
    CGPoint linePoint1 = CGPointZero;
    CGPoint linePoint2 = CGPointZero;
    if (isLeft) {
        moveToPoint = CGPointMake(0, size.height/2);
        linePoint1 = CGPointMake(size.width, 0);
        linePoint2 = CGPointMake(size.width, size.height);

    } else {
        moveToPoint = CGPointMake(0, size.height);
        linePoint1 = CGPointMake(0 , 0);
        linePoint2 = CGPointMake(size.width, size.height/2);
    }
    //bezier path
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:moveToPoint];
    [path addLineToPoint:linePoint1];
    [path addLineToPoint:linePoint2];
    [path closePath];
    CGContextSetFillColorWithColor(context, self.styleConfig.skipTriangleColor.CGColor);
    [path fill];
    //image
    UIImage *triangleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    skipButton.backgroundColor = [UIColor clearColor];
    skipButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    [skipButton setImage:triangleImage forState:UIControlStateNormal];
    SEL sel = isLeft ? @selector(leftSikpAction) : @selector(rightSikpAction);
    [skipButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return skipButton;
}

#pragma mark -- Backup layer
- (void)addBackupLayer {
    CGFloat middleX = CGRectGetMidX(self.transformRect);
    self.backupLayer = [CAShapeLayer layer];
    self.backupLayer.backgroundColor = [UIColor clearColor].CGColor;
    CGFloat width = CGRectGetWidth(self.bounds);
    //rectangle
    //y
    CGFloat backupY = [self getBarContentMarginTop];

    CGFloat triangleStartY = 0;
    CGFloat triangleEndY = 0;
    if ([self getRealArrowDirection] == YPMenuControllerArrowDown) {
        triangleStartY = self.styleConfig.barHeight - kTriangleArrowsTowardContentMargin;
        triangleEndY = backupY + kContentHeight;
        
    }else if([self getRealArrowDirection] == YPMenuControllerArrowUp) {
        triangleStartY = kTriangleArrowsTowardContentMargin;
        triangleEndY = backupY;
    }

    CGRect pathRect = CGRectMake(0, backupY, width, kContentHeight);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:kBackupLayerCornerRadius];
    //triangle
    middleX -= self.frame.origin.x;
    [path moveToPoint:CGPointMake(middleX, triangleStartY)];
    [path addLineToPoint:CGPointMake(middleX - kTriangleRadiusWidth, triangleEndY)];
    [path addLineToPoint:CGPointMake(middleX + kTriangleRadiusWidth, triangleEndY)];

    self.backupLayer.path = path.CGPath;
    self.backupLayer.frame = self.bounds;
    self.backupLayer.fillColor = self.styleConfig.barBackgroundColor.CGColor;
    [self.layer insertSublayer:self.backupLayer atIndex:0];
}

#pragma mark -- General values
- (CGFloat)getBarContentMarginTop {
    if ([self getRealArrowDirection] == YPMenuControllerArrowDown) {
        return kContentTowardRearMargin;
        
    }else if ([self getRealArrowDirection] == YPMenuControllerArrowUp){
       return kContentTowardTargetViewMargin;
    }
    return 0;
}

- (CGFloat)getBarContentMarginBottom {
    if ([self getRealArrowDirection] == YPMenuControllerArrowDown) {
        return kContentTowardTargetViewMargin;
        
    }else if ([self getRealArrowDirection] == YPMenuControllerArrowUp){
        return kContentTowardRearMargin;
    }
    return 0;
}

- (YPMenuControllerArrowDirection)getRealArrowDirection {
    if (self.styleConfig.arrowDirection == YPMenuControllerArrowDefault) {
        CGFloat barY = CGRectGetMinY(self.transformRect) - self.styleConfig.barHeight;
        if (barY <= 0) {
            return YPMenuControllerArrowUp;
        }else{
            return YPMenuControllerArrowDown;
        }
    }
    return self.styleConfig.arrowDirection;
}
@end
