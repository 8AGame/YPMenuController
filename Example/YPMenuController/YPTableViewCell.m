//
//  YPTableViewCell.m
//  YPMenuController_Example
//
//  Created by Yaping Liu on 3/18/19.
//  Copyright © 2019 liuyaping. All rights reserved.
//

#import "YPTableViewCell.h"
#import <YPMenuController.h>
#import "ReporderView.h"

@interface YPTableViewCell ()

@end

@implementation YPTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ReporderView *v = [[ReporderView alloc] initWithFrame:CGRectMake(10, 100, 20, 20)];
    v.backgroundColor = [UIColor blackColor];
    v.userInteractionEnabled = YES;
    [self addSubview:v];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [self resignFirstResponder];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    [[YPMenuController sharedMenuController] setMenuVisible:NO animated:YES];

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
    UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"第一" action:@selector(custome:)];
    UIMenuItem *item2 = [[UIMenuItem alloc] initWithTitle:@"第二" action:@selector(custome:)];
    UIMenuItem *item3 = [[UIMenuItem alloc] initWithTitle:@"第三第三第三第三" action:@selector(custome:)];
    UIMenuItem *item4 = [[UIMenuItem alloc] initWithTitle:@"第四" action:@selector(custome:)];
    UIMenuItem *item5 = [[UIMenuItem alloc] initWithTitle:@"第五" action:@selector(custome:)];
    UIMenuItem *item6 = [[UIMenuItem alloc] initWithTitle:@"第六个" action:@selector(custome:)];

    [[UIMenuController sharedMenuController] setMenuItems:@[item1, item2, item3, item4, item5, item6]];
    [[UIMenuController sharedMenuController] setTargetRect:self.systemBtn.frame inView:self];
    [[UIMenuController sharedMenuController] setArrowDirection:UIMenuControllerArrowUp];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];

}

- (IBAction)popupMenu:(id)sender {

    [self popupYPMenu:YES];

    
}
- (IBAction)action2:(id)sender {

    [self popupYPMenu:NO];
}

- (void)popupYPMenu:(BOOL)sys1 {
    YPMenuItem *item1 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"第一" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item2 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第二" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item3 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"第三第三第三第三" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item4 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第四" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item5 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"第五" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item6 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第六个" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item7 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"第七第七第七第七" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item8 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第八" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item9 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"第九" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item10 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"第十个" image:[UIImage imageNamed:@"like"]];

    NSArray *menus = sys1 ? @[item1, item2, item3, item4, item5, item6,item7,item8,item9,item10] : @[item1, item2, item3];
    [[YPMenuController sharedMenuController] setMenuItems:menus menuType:YPMenuControllerSystem];
    UIButton * btn = sys1 ? self.clickBtn : self.clickBtn2;
    [[YPMenuController sharedMenuController] setTargetRect:btn.frame inView:self];
    [[YPMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(custome:)) {
        return YES;
    }
    return NO;
}

- (void)custome1:(id)sender {
}
- (void)custome:(id)sender {
    NSLog(@"custom action");
}

@end
