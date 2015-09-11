//
//  MusicTableViewCell.m
//  MusicDemo_3
//
//  Created by 刘杰 on 15/8/11.
//  Copyright (c) 2015年 liujie. All rights reserved.
//

#import "MusicTableViewCell.h"
#import "MusicModel.h"
@implementation MusicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setManagerWithModel:(MusicModel *)model
{
    self.nameLabel.text = model.name;
    self.label.text = model.singer;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
