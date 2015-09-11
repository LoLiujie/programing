//
//  SharedPlayMusic.h
//  MusicDemo_3
//
//  Created by 刘杰 on 15/8/11.
//  Copyright (c) 2015年 liujie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MusicModel;
@protocol AVPlayerDelegate <NSObject>

- (void)audioPlayerTimeDidEnd;
- (void)audioPlayerWithProgress:(CGFloat)progress
                    currentTime:(NSString *)currentTime
                      totalTime:(NSString *)totalTime;

@end

@interface SharedPlayMusic : NSObject

@property (nonatomic, weak) id <AVPlayerDelegate> delegate;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) MusicModel *musicModel;

+ (SharedPlayMusic *)sharedManager;

- (void)preparMusicPlay;

- (void)seekToTime:(float)progress;

- (NSArray *)allLyricArrayItem;

- (NSInteger)indexWithLyricTime:(NSString *)time;

@end
