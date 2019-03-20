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

- (IBAction)popupMenu:(id)sender {
    [self becomeFirstResponder];
//    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"ddd" action:@selector(custome:)];
//    [[UIMenuController sharedMenuController] setMenuItems:@[item]];
    [[UIMenuController sharedMenuController] setTargetRect:self.clickBtn.frame inView:self];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];

    YPMenuItem *item1 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome:) title:@"喜欢" image:[UIImage imageNamed:@"like"]];
    YPMenuItem *item2 = [[YPMenuItem alloc] initTitleAndImageWithAction:@selector(custome1:) title:@"不喜欢" image:[UIImage imageNamed:@"like"]];
    
    [[YPMenuController sharedMenuController] setMenuItems:@[item1, item2] menuType:YPMenuControllerTitleLeftImageRight];
    [[YPMenuController sharedMenuController] setTargetRect:self.clickBtn.frame inView:self];
    [[YPMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    
}
- (IBAction)action2:(id)sender {
    [self becomeFirstResponder];
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"ddd" action:@selector(custome:)];
    [[UIMenuController sharedMenuController] setMenuItems:@[item]];
    [[UIMenuController sharedMenuController] setTargetRect:self.clickBtn2.frame inView:self];
    [[UIMenuController sharedMenuController] setArrowDirection:UIMenuControllerArrowLeft];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];

}

- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return YES;
//    if (action == @selector(custome:)) {
//        return YES;
//    }
    return NO;
}

- (void)custome1:(id)sender {
}
- (void)custome:(id)sender {
    NSLog(@"custom action");
}

@end
