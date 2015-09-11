//
//  SharedManager.m
//  MusicDemo_3
//
//  Created by 刘杰 on 15/8/11.
//  Copyright (c) 2015年 liujie. All rights reserved.
//

#import "SharedManager.h"
#import "MusicModel.h"

@interface SharedManager ()

@property (nonatomic, strong) NSMutableArray *ListArray;

@end

@implementation SharedManager

+ (SharedManager *)sharedManager{
    static SharedManager * audioManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioManager = [[SharedManager alloc] init];
    });
    return audioManager;
}

- (void)requestDataWithUrl:(NSString *)url andBlock:(myBlock) myBlock
{
    self.Myblock = [myBlock copy];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *array = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:url]];
        
        for (NSDictionary *dict in array)
        {
            MusicModel *music = [MusicModel new];
            [music setValuesForKeysWithDictionary:dict];
            [self.ListArray addObject:music];
        }
        //回到主线程 回调block
        dispatch_async(dispatch_get_main_queue(), ^{
            self.Myblock();
        });
        
    });
}

//懒加载
- (NSMutableArray *)ListArray
{
    if (!_ListArray)
    {
        _ListArray = [NSMutableArray array];
    }
    return _ListArray;
}



- (MusicModel *)setModelWithIndexpath:(NSInteger)index
{
    return _ListArray[index];
}

- (NSInteger)setIntegerWithModel:(MusicModel *)model
{
    return [_ListArray indexOfObject:model];
}
//重写get方法
- (NSInteger)count
{
    return _ListArray.count;
}


@end
