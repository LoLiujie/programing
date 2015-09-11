//
//  MusicTableViewCell.h
//  MusicDemo_3
//
//  Created by 刘杰 on 15/8/11.
//  Copyright (c) 2015年 liujie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicModel;
@interface MusicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;

- (void)setManagerWithModel:(MusicModel *)model;

@end
