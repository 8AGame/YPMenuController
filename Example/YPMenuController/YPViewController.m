//
//  YPViewController.m
//  YPMenuController
//
//  Created by liuyaping on 03/18/2019.
//  Copyright (c) 2019 liuyaping. All rights reserved.
//

#import "YPViewController.h"
#import "YPTableViewCell.h"
#import <YPMenuController/YPMenuController.h>

@interface YPViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString *text;
@end

@implementation YPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"YPTableViewCell" bundle:nil] forCellReuseIdentifier:@"YPTableViewCell"];
    self.text = @"wwwwww";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:YPMenuControllerWillShowMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:YPMenuControllerDidShowMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:YPMenuControllerWillHideMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:YPMenuControllerDidHideMenuNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:UIMenuControllerWillShowMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:UIMenuControllerDidShowMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:UIMenuControllerWillHideMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:UIMenuControllerDidHideMenuNotification object:nil];
}

- (void)notificationAction:(NSNotification *)sender {
//    NSLog(@"%@",sender.name);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YPTableViewCell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did cell select");
//    YPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YPTableViewCell" forIndexPath:indexPath];
    self.text = @"xxxx";
    [self.tableView reloadData];
    
}




@end
