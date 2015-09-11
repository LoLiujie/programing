//
//  SharedPlayMusic.m
//  MusicDemo_3
//
//  Created by 刘杰 on 15/8/11.
//  Copyright (c) 2015年 liujie. All rights reserved.
//

#import "SharedPlayMusic.h"
#import <AVFoundation/AVFoundation.h>
#import "MusicModel.h"
#import "LyricModel.h"
@interface SharedPlayMusic ()

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSMutableArray *lyricListArray;

@end

@implementation SharedPlayMusic

+ (SharedPlayMusic *)sharedManager{
    static SharedPlayMusic * audioManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioManager = [[SharedPlayMusic alloc] init];
    });
    return audioManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _player = [AVPlayer new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioPlayerEndAction) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

- (void)preparMusicPlay
{
    if (self.player.currentItem){
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.musicModel.mp3Url]];
    [item addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    [self.player replaceCurrentItemWithPlayerItem:item];
    
}
- (void)audioPlayerEndAction{
    if ([_delegate respondsToSelector:@selector(audioPlayerTimeDidEnd)]){
        [_delegate audioPlayerTimeDidEnd];
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"])
    {
        AVPlayerItemStatus status = [[change objectForKey:@"new"] intValue];
        switch (status) {
            case AVPlayerItemStatusUnknown:{
                NSLog(@"未知");
                break;
            }
            case AVPlayerItemStatusReadyToPlay:{
                [self playMusic];
                break;
            }
            case AVPlayerItemStatusFailed:{
                NSLog(@"错误");
                break;
            }
            default:
                break;
        }
    }
}

- (void)playMusic
{
    [self.player play];
    self.isPlaying = YES;
    if (_timer != nil)
    {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
    [_timer fire];
    
}
- (void)timeAction:(NSTimer *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(audioPlayerWithProgress:currentTime:totalTime:)])
    {
        [_delegate audioPlayerWithProgress:[self Progress] currentTime:[self currentTime] totalTime:[self totalTime]];
    }
}


- (NSInteger)currentTimeValue
{
    NSInteger currentTime = self.player.currentTime.value / self.player.currentTime.timescale;
    return currentTime;
}

- (NSString *)currentTime
{
    if (self.player.currentItem)
    {
        return [NSString stringWithFormat:@"%02ld:%02ld",[self currentTimeValue] / 60, [self currentTimeValue ] % 60];
    }
    return @"00:00";
}

- (NSInteger)totalTimeValue
{
    CMTime time = [self.player.currentItem duration];
    if (time.timescale != 0)
    {
        NSInteger totalTime = time.value / time.timescale;
        return totalTime;
    }
    return 0;
}

- (NSString *)totalTime
{
    if (self.player.currentItem)
    {
        return [NSString stringWithFormat:@"%2ld:%02ld",[self totalTimeValue] / 60 , [self totalTimeValue] % 60];
    }
    return @"00:00";
}

- (CGFloat)Progress
{
    if (self.player.currentItem)
    {
        if ([self totalTimeValue] != 0)
        {
            CGFloat progress = (CGFloat)[self currentTimeValue] / (CGFloat)[self totalTimeValue];
            return progress;
        }
    }
    return 0.0;
}

- (void)seekToTime:(float)progress
{
    [self pause];       
    [self.player seekToTime:CMTimeMake(progress * (CGFloat)[self totalTimeValue], 1) completionHandler:^(BOOL finished) {
       
        if (finished) {
            [self playMusic];
        }
    }];
}

- (void)pause
{
    if (!_isPlaying)
    {
        return;
    }
    self.isPlaying = NO;
    [self.player pause];
    [self.timer invalidate];
    self.timer = nil;
}

- (NSArray *)allLyricArrayItem
{
    [self.lyricListArray removeAllObjects];
    NSArray *contentArray = [self.musicModel.lyric componentsSeparatedByString:@"\n"];
    for (NSString *itemStr in contentArray)
    {
        NSArray *itemArray = [itemStr componentsSeparatedByString:@"]"];
        if ([itemArray.firstObject length] < 1)
        {
            break;
        }
        NSString *timeStr = [itemArray.firstObject substringFromIndex:1];
        NSArray *timeArray = [timeStr componentsSeparatedByString:@"."];
        NSString *lyricTime = timeArray.firstObject;
        NSString *lyricStr = itemArray.lastObject;
        LyricModel *lyricModel = [[LyricModel alloc] initWithLyricTime:lyricTime LyricStr:lyricStr];
        [self.lyricListArray addObject:lyricModel];
    }
    return self.lyricListArray;
    
}
- (NSInteger)indexWithLyricTime:(NSString *)time
{
    NSInteger index = -1;
    for (int i = 0; i < self.lyricListArray.count; i ++)
    {
        if ([[self.lyricListArray[i] lyricTime] isEqualToString:time])
        {
            index = i;
            return index;
        }
    }
    return index;
}

- (NSMutableArray *)lyricListArray
{
    if (!_lyricListArray)
    {
        _lyricListArray = [NSMutableArray array];
    }
    return _lyricListArray;
}

@end
