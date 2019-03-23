//
//  YPCalloutBar.m
//  Pods-YPMenuController_Example
//
//  Created by Yaping Liu on 3/19/19.
//

#import "YPCalloutBar.h"
#import "YPMenuItem.h"
#import <objc/runtime.h>

#define kBarHeight              60
#define kBarMarginLeft          10
#define kBarContentHeight       36
#define kSkipBtnWidth           32

#define kBarMaxWidth  ((CGRectGetWidth([UIScreen mainScreen].bounds))-(kBarMarginLeft)*2)


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

@property (nonatomic, assign) YPMenuControllerType menuType;

@property (nonatomic, strong) NSMutableArray *menuItemBtns;

@property (nonatomic, strong) NSArray<YPMenuItem *> *menuItems;

@property(nonatomic, assign) YPMenuControllerArrowDirection arrowDirection;

@end

@implementation YPCalloutBar

- (instancetype)initWithMenuItems:(NSArray<YPMenuItem *> *)menuItems
                    transformRect:(CGRect)transformRect
                         menuType:(YPMenuControllerType)menuType
                   arrowDirection:(YPMenuControllerArrowDirection)arrowDirection {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.transformRect = transformRect;
        self.menuType = menuType;
        self.menuItems = menuItems;
        self.arrowDirection = arrowDirection;

    }
    return self;

}

- (void)layoutBarItems {
    //custom style
    if (self.menuType == YPMenuControllerCustom) {
        return;
    }
    CGFloat maxWidth = kBarMaxWidth;
    CGFloat totalWidth = 0;

    self.menuItemBtns = [[NSMutableArray alloc] init];
    for (YPMenuItem *item in self.menuItems) {
        //image and title style
        UIButton *menuBtn = [self createBarButtonWithMenuItem:item];
        CGFloat maxContent = maxWidth - kSkipBtnWidth *2;
        CGSize size = [menuBtn sizeThatFits:CGSizeMake(maxContent, kBarContentHeight)];
        menuBtn.frame = CGRectMake(0, 0, size.width, size.height);
        totalWidth += size.width;
        [self.menuItemBtns addObject:menuBtn];
    }
    if (totalWidth <= maxWidth) {
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
        self.leftSkipBtn.frame = CGRectMake(0, contentMarginTop, kSkipBtnWidth, kBarContentHeight);
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
        perBtn.frame = CGRectMake(totalWidth, contentMarginTop, CGRectGetWidth(perBtn.frame), kBarContentHeight);
        [self addSubview:perBtn];
        totalWidth += CGRectGetWidth(perBtn.frame);
        //line view
        [self addSubview:[self lineViewWithXValue:totalWidth]];
    }
    
    //right skip button
    if (hasMore) {
        self.rightSkipBtn.enabled = YES;
        self.rightSkipBtn.frame = CGRectMake(totalWidth, contentMarginTop, kSkipBtnWidth, kBarContentHeight);
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
        (self.menuType == YPMenuControllerSystem ||
        self.menuType == YPMenuControllerImageUpTitleDown ||
        self.menuType == YPMenuControllerTitleUpImageDown ||
        self.menuType == YPMenuControllerImageLeftTitleRight ||
        self.menuType == YPMenuControllerTitleLeftImageRight)) {
        
        [menuBtn setTitle:menuItem.title forState:UIControlStateNormal];
        menuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    if (menuItem.image &&
        (self.menuType == YPMenuControllerImageOnly ||
        self.menuType == YPMenuControllerImageUpTitleDown ||
        self.menuType == YPMenuControllerTitleUpImageDown ||
        self.menuType == YPMenuControllerImageLeftTitleRight ||
        self.menuType == YPMenuControllerTitleLeftImageRight)) {
        
        [menuBtn setImage:menuItem.image forState:UIControlStateNormal];
    }
    switch (self.menuType) {
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
    YPMenuItem *item = objc_getAssociatedObject(sender, @selector(itemButtonAction:));
    if (item && [item isKindOfClass:YPMenuItem.class]) {
        if (self.triggerClickBlock) {
            self.triggerClickBlock(item.action);
        }
    }
}

- (UIView *)lineViewWithXValue:(CGFloat)xValue {
    CGFloat contentMarginTop = [self getBarContentMarginTop];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(xValue, contentMarginTop, 1, kBarContentHeight)];
    lineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
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
    if (self.arrowDirection == YPMenuControllerArrowDefault ||
        self.arrowDirection == YPMenuControllerArrowDown) {
        barY = CGRectGetMinY(self.transformRect) - kBarHeight;
        
    }else{
        barY = CGRectGetMaxY(self.transformRect);
    }
    self.frame = CGRectMake(barX, barY, barWidth, kBarHeight);
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
    UIImage *resultImage = nil;
    CGSize size = CGSizeMake(10, 10);
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
- (void)addBackupLayer {
    CGFloat middleX = CGRectGetMidX(self.transformRect);
    self.backupLayer = [CAShapeLayer layer];
    self.backupLayer.backgroundColor = [UIColor clearColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat cornerRadius = 6;
    CGFloat triangleRadius = 8;
    //rectangle
    //y
    CGFloat backupY = [self getBarContentMarginTop];

    CGFloat triangleStartY = 0;
    if (self.arrowDirection == YPMenuControllerArrowDefault ||
        self.arrowDirection == YPMenuControllerArrowDown) {
        triangleStartY = kBarHeight - 5;
        
    }else{
        triangleStartY = 5;
    }

    CGRect pathRect = CGRectMake(0, backupY, width, kBarContentHeight);
    path = [UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:cornerRadius];
    //triangle
    middleX -= self.frame.origin.x;
    [path moveToPoint:CGPointMake(middleX, triangleStartY)];
    [path addLineToPoint:CGPointMake(middleX-triangleRadius, backupY)];
    [path addLineToPoint:CGPointMake(middleX+triangleRadius, backupY)];

    self.backupLayer.path = path.CGPath;
    self.backupLayer.frame = self.bounds;
    self.backupLayer.fillColor = [UIColor colorWithRed:31/255 green:31/288 blue:31/255 alpha:0.96].CGColor;
    [self.layer insertSublayer:self.backupLayer atIndex:0];
}

- (CGFloat)getBarContentMarginTop {
    if (self.arrowDirection == YPMenuControllerArrowDefault ||
        self.arrowDirection == YPMenuControllerArrowDown) {
        return kBarHeight - 15 - kBarContentHeight;
        
    }else{
       return 15;
    }
}




@end
