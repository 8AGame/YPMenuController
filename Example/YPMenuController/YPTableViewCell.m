//
//  YPTableViewCell.m
//  YPMenuController_Example
//
//  Created by Yaping Liu on 3/18/19.
//  Copyright © 2019 liuyaping. All rights reserved.
//

#import "YPTableViewCell.h"
#import <YPMenuController.h>

@interface YPTableViewCell ()

@end

@implementation YPTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark -- yp styele

- (IBAction)systemStyleAction:(id)sender {

    [self popupYPMenuSender:sender config:nil];
}

- (IBAction)onlyImageStyleAction:(id)sender {
    
    YPMenuStyleConfig *config = [[YPMenuStyleConfig alloc] init];
    config.menuType = YPMenuControllerImageOnly;
    
    [self popupYPMenuSender:sender config:config];
}

- (IBAction)LeftImgRightTitleStyleAction:(id)sender {
    YPMenuStyleConfig *config = [[YPMenuStyleConfig alloc] init];
    config.menuType = YPMenuControllerTitleLeftImageRight;
    config.barBackgroundColor = [UIColor purpleColor];
    config.titleColor = [UIColor yellowColor];
    config.skipTriangleColor = [UIColor cyanColor];
    config.separatorLineColor = [UIColor blackColor];
    [self popupYPMenuSender:sender config:config];
}

- (IBAction)rightImgLeftTitleStyleAction:(id)sender {
    
    YPMenuStyleConfig *config = [[YPMenuStyleConfig alloc] init];
    config.menuType = YPMenuControllerImageLeftTitleRight;
    config.titleColor = [UIColor orangeColor];
    config.skipTriangleColor = [UIColor cyanColor];
    config.separatorLineColor = [UIColor cyanColor];
    
    [self popupYPMenuSender:sender config:config];
}

- (IBAction)topImgBottomTitleStyleAction:(id)sender {

    YPMenuStyleConfig *config = [[YPMenuStyleConfig alloc] init];
    config.menuType = YPMenuControllerImageTopTitleBottom;
    [self popupYPMenuSender:sender config:config];

}

- (IBAction)bottomImgTopTitleStyleAction:(id)sender {
    
    YPMenuStyleConfig *config = [[YPMenuStyleConfig alloc] init];
    config.menuType = YPMenuControllerTitleTopImageBottom;
    config.barBackgroundColor = [UIColor whiteColor];
    config.titleColor = [UIColor orangeColor];
    config.skipTriangleColor = [UIColor blueColor];
    config.separatorLineColor = [UIColor lightGrayColor];
    
    [self popupYPMenuSender:sender config:config];
}

- (void)popupYPMenuSender:(UIView *)sender
                   config:(YPMenuStyleConfig *)config {
    
    YPMenuItem *item1 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome3) title:@"第一" image:[UIImage imageNamed:@"share"]];
    YPMenuItem *item2 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第二" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item3 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"第三" image:[UIImage imageNamed:@"share"]];
    YPMenuItem *item4 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第四" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item5 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"第五第五第五第五" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item6 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第六个" image:[UIImage imageNamed:@"share"]];
    YPMenuItem *item7 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"第七第七第七第七" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item8 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第八" image:[UIImage imageNamed:@"share"]];
    YPMenuItem *item9 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"第九" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item10 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第十个" image:[UIImage imageNamed:@"like"]];
    NSArray *menus = @[item1, item2, item3, item4, item5, item6,item7,item8,item9,item10];
    [YPMenuController sharedMenuController].styleConfig = config;
    [YPMenuController sharedMenuController].menuItems = menus;
    [[YPMenuController sharedMenuController] menuVisibleInView:self
                                                    targetRect:sender.frame
                                                      animated:YES];
}

- (IBAction)customStyleAction:(id)sender {
    YPMenuStyleConfig *config = [[YPMenuStyleConfig alloc] init];
    config.menuType = YPMenuControllerCustom;
    config.barHeight = 58;
    config.barBackgroundColor = [UIColor whiteColor];
    config.separatorLineColor = [UIColor cyanColor];
    config.barDismissDelayInterval = 0.2;
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    sw.onTintColor = [UIColor greenColor];
    sw.tintColor = [UIColor lightGrayColor];
    [sw addTarget:self action:@selector(customViewTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [slider addTarget:self action:@selector(custome3) forControlEvents:UIControlEventValueChanged];
    slider.minimumTrackTintColor = [UIColor orangeColor];
    slider.maximumTrackTintColor = [UIColor purpleColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 80, 34);
    [btn setTitle:@"点赞" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(customViewTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    YPMenuItem *item = [[YPMenuItem alloc] initWithCustomView:sw];
    YPMenuItem *item1 = [[YPMenuItem alloc] initWithCustomView:slider];
    YPMenuItem *item2 = [[YPMenuItem alloc] initWithCustomView:btn];

    NSArray *menus = @[item,item1,item2];
    
    [YPMenuController sharedMenuController].styleConfig = config;
    [YPMenuController sharedMenuController].menuItems = menus;
    [[YPMenuController sharedMenuController] menuVisibleInView:self
                                                    targetRect:[(UIButton *)sender frame]
                                                      animated:YES];
    
}

- (void)customViewTypeAction:(id)sender {
    [[YPMenuController sharedMenuController] menuInvisibleWithAnimated:YES];
}

- (void)custome1:(id)sender {
    NSLog(@"custom1 action");
}
- (void)custome:(id)sender {
    NSLog(@"custom action");
}
- (void)custome3 {
    NSLog(@"custome3 action");
}
#pragma mark -- UIMenu style

- (IBAction)UIMenuStyleAction:(id)sender {
    
    [self becomeFirstResponder];
    [[UIMenuController sharedMenuController] setTargetRect:[(UIButton *)sender frame] inView:self];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];

}
- (void)copy:(id)sender {
    
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {

    if (action == @selector(copy:)) {
        return YES;
        
    }
    return NO;
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self resignFirstResponder];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}



@end
