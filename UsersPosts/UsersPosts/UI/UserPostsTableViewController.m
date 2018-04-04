//
//  UserPostsTableViewController.m
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "UserPostsTableViewController.h"
#import "PostTableViewCell.h"

@interface UserPostsTableViewController ()

@end

@implementation UserPostsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _user.name;
    self.tableView.tableFooterView = [UIView new];
    __weak typeof(self) weakSelf = self;
    [_userManager fetchPostsForUser:_user completionHandler:^(User *user, NSArray<Post *> *posts, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _user.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCellID" forIndexPath:indexPath];
    cell.post = [_user.posts objectAtIndex:indexPath.row];
    return cell;
}

@end
