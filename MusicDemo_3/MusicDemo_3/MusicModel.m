//
//  MusicModel.m
//  MusicDemo_3
//
//  Created by 刘杰 on 15/8/11.
//  Copyright (c) 2015年 liujie. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        self.ID = value;
    }else
    {
        NSLog(@"Error Key: %@", key);
    }
}

@end
