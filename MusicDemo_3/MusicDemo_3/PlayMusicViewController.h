//
//  PlayMusicViewController.h
//  MusicDemo_3
//
//  Created by 刘杰 on 15/8/11.
//  Copyright (c) 2015年 liujie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicModel;
@interface PlayMusicViewController : UIViewController

@property (nonatomic, strong) MusicModel *model;

+ (PlayMusicViewController *)sharedManager;
@end
