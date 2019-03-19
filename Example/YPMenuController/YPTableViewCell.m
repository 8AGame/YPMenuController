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
    [[UIMenuController sharedMenuController] setTargetRect:self.clickBtn.frame inView:self];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    
    [[YPMenuController sharedMenuController] setTargetRect:self.clickBtn.frame inView:self];
    [[YPMenuController sharedMenuController] setMenuVisible:YES animated:YES];

    
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copy:)) {
        return YES;
    }
    return NO;
}



@end
