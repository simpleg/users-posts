//
//  UserPostsTableViewController.h
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UsersManager.h"

@interface UserPostsTableViewController : UITableViewController
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) UsersManager *userManager;
@end
