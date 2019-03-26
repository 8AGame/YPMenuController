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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [self resignFirstResponder];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];

}
- (IBAction)sys2:(id)sender {
    [self becomeFirstResponder];
    UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"喜欢" action:@selector(custome:)];
    UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"不喜欢" action:@selector(custome:)];
    UIMenuItem *item3 = [[UIMenuItem alloc] initWithTitle:@"喜欢我就收藏他哦哦" action:@selector(custome:)];
    UIMenuItem *item4 = [[UIMenuItem alloc] initWithTitle:@"不喜欢哦哦哦哦哦哦哦哦" action:@selector(custome:)];

    
    [[UIMenuController sharedMenuController] setMenuItems:@[item1, item2, item3, item4]];
    [[UIMenuController sharedMenuController] setTargetRect:self.sys2Btn.frame inView:self];
    [[UIMenuController sharedMenuController] setArrowDirection:UIMenuControllerArrowUp];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];

}
- (IBAction)systemAction:(id)sender {
    [self becomeFirstResponder];
    UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"第一" action:@selector(custome3)];
    UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"第二" action:@selector(custome:)];
    UIMenuItem *item3 = [[UIMenuItem alloc] initWithTitle:@"第三第三第三第三" action:@selector(custome:)];
    UIMenuItem *item4 = [[UIMenuItem alloc] initWithTitle:@"第四" action:@selector(custome:)];
    UIMenuItem *item5 = [[UIMenuItem alloc] initWithTitle:@"第五" action:@selector(custome:)];
    UIMenuItem *item6 = [[UIMenuItem alloc] initWithTitle:@"第六个" action:@selector(custome:)];
    UIMenuItem *item7 = [[UIMenuItem alloc] initWithTitle:@"第七第七第七第七" action:@selector(custome:)];
    UIMenuItem *item8 = [[UIMenuItem alloc] initWithTitle:@"第八" action:@selector(custome:)];
    UIMenuItem *item9 = [[UIMenuItem alloc] initWithTitle:@"第九" action:@selector(custome:)];
    UIMenuItem *item10 = [[UIMenuItem alloc] initWithTitle:@"第十个" action:@selector(custome:)];

    [[UIMenuController sharedMenuController] setMenuItems:@[item1, item2, item3, item4, item5, item6,item7,item8,item9,item10]];
    [[UIMenuController sharedMenuController] setTargetRect:self.systemBtn.frame inView:self];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];

}



- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(custome:) || action == @selector(custome3)) {
        return YES;
    }
    return NO;
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



- (IBAction)systemStyleAction:(id)sender {
    [self popupYPMenu:YPMenuControllerSystem sender:sender];
}
- (IBAction)onlyImageStyleAction:(id)sender {
    [self popupYPMenu:YPMenuControllerImageOnly sender:sender];

}
- (IBAction)LeftImgRightTitleStyleAction:(id)sender {
    [self popupYPMenu:YPMenuControllerTitleLeftImageRight sender:sender];

}
- (IBAction)rightImgLeftTitleStyleAction:(id)sender {
    [self popupYPMenu:YPMenuControllerImageLeftTitleRight sender:sender];

}
- (IBAction)topImgBottomTitleStyleAction:(id)sender {
    [self popupYPMenu:YPMenuControllerImageTopTitleBottom sender:sender];

}
- (IBAction)bottomImgTopTitleStyleAction:(id)sender {
    [self popupYPMenu:YPMenuControllerTitleTopImageBottom sender:sender];

}
- (IBAction)customStyleAction:(id)sender {
    [self popupYPMenu:YPMenuControllerCustom sender:sender];

}


- (void)popupYPMenu:(YPMenuControllerType)type sender:(UIView *)sender{
    YPMenuItem *item1 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome3) title:@"第一" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item2 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第二" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item3 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"第三" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item4 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第四" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item5 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"第五第五第五第五" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item6 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第六个" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item7 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"第七第七第七第七" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item8 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第八" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item9 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"第九" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item10 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第十个" image:[UIImage imageNamed:@"like"]];
    
    NSArray *menus = @[item1, item2, item3, item4, item5, item6,item7,item8,item9,item10];
    [[YPMenuController sharedMenuController] setMenuItems:menus menuType:type];

    [[YPMenuController sharedMenuController] menuVisibleInView:self
                                                    targetRect:sender.frame
                                                      animated:YES];
}


@end
