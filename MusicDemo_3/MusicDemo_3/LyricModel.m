//
//  LyricModel.m
//  MusicDemo_3
//
//  Created by 刘杰 on 15/8/17.
//  Copyright (c) 2015年 liujie. All rights reserved.
//

#import "LyricModel.h"

@implementation LyricModel
- (instancetype)initWithLyricTime:(NSString *)lyricTime LyricStr:(NSString *)lyricStr
{
    self = [super init];
    if (self)
    {
        _lyricStr = lyricStr;
        _lyricTime = lyricTime;
    }
    return self;
}

@end
