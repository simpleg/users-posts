//
//  PostTableViewCell.m
//  UsersPosts
//
//  Created by Jerome Heymonet on 03/04/2018.
//  Copyright © 2018 SimpleG. All rights reserved.
//

#import "PostTableViewCell.h"

@interface PostTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *body;

@end

@implementation PostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setPost:(Post *)post {
    _post = post;
    _title.text = _post.title;
    _body.text = _post.body;
}

@end
