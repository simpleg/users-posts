//
//  UsersTableViewCell.m
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "UsersTableViewCell.h"

@interface UsersTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *emailAddress;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *avatarDownloadActivityIndicator;

@end
@implementation UsersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) setUser:(User *)user {
    _user = user;
    _name.text = _user.name;
    _username.text = _user.username;
    _emailAddress.text = _user.email;
    _phoneNumber.text = _user.phone;
    if(!_user.avatarData){
        [_avatarDownloadActivityIndicator startAnimating];
    } else {
        _avatar.image = [UIImage imageWithData:_user.avatarData];
        [_avatarDownloadActivityIndicator stopAnimating];
    }
    
}

@end
