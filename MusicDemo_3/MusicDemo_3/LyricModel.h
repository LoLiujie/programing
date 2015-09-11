//
//  LyricModel.h
//  MusicDemo_3
//
//  Created by 刘杰 on 15/8/17.
//  Copyright (c) 2015年 liujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyricModel : NSObject

@property (nonatomic, copy) NSString *lyricTime;
@property (nonatomic, copy) NSString *lyricStr;

- (instancetype)initWithLyricTime:(NSString *)lyricTime
                         LyricStr:(NSString *)lyricStr;

@end
