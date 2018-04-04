//
//  UsersTableViewController.m
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "UsersTableViewController.h"
#import "UsersManager.h"
#import "UsersTableViewCell.h"
#import "UserPostsTableViewController.h"

@interface UsersTableViewController ()
@property (nonatomic, strong) UsersManager *usersManager;
@end

@implementation UsersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Users";

    self.tableView.tableFooterView = [UIView new];
    __weak typeof(self) weakSelf = self;
    _usersManager = [UsersManager new];
    [_usersManager fetchUsersWithCompletionHandler:^(NSArray<User *> *users, NSError *error) {
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
    return _usersManager.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UsersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"usersCellID" forIndexPath:indexPath];
    User *user = [_usersManager.users objectAtIndex:indexPath.row];
    cell.user = user;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    User *theUser = [_usersManager.users objectAtIndex:indexPath.row];
    if(!theUser.avatarData){
       [_usersManager fetchAvatarForUser:theUser completionHandler:^(User *user, NSData *avatarData, NSError *error) {
           dispatch_async(dispatch_get_main_queue(), ^{
               UsersTableViewCell *aCell = (UsersTableViewCell *) cell;
               aCell.user = user;
           });
       }];
    }
}

#pragma mark - Navigation
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(nullable id)sender {
    if([identifier isEqualToString:@"showPostSegueID"]){
        return YES;
    }
    return NO;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UserPostsTableViewController *destViewController = [segue destinationViewController];
    CGPoint clickedPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:clickedPoint];
    User *user = [_usersManager.users objectAtIndex:indexPath.row];
    destViewController.user = user;
    destViewController.userManager = _usersManager;
}

@end
