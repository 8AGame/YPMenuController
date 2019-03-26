//
//  YPViewController.m
//  YPMenuController
//
//  Created by liuyaping on 03/18/2019.
//  Copyright (c) 2019 liuyaping. All rights reserved.
//

#import "YPViewController.h"
#import "YPTableViewCell.h"


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
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YPTableViewCell" forIndexPath:indexPath];
    [cell.systemBtn setTitle:self.text forState:UIControlStateNormal];
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
