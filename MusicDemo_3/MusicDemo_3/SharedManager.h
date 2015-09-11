//
//  SharedManager.h
//  MusicDemo_3
//
//  Created by 刘杰 on 15/8/11.
//  Copyright (c) 2015年 liujie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MusicModel;
typedef void(^myBlock)();

@interface SharedManager : NSObject
//声明属性block
@property (nonatomic, copy) myBlock Myblock;
//返回数组个数
@property (nonatomic, assign) NSInteger count;

//通过下标找model;
- (MusicModel *)setModelWithIndexpath:(NSInteger)index;

//通过model 找下标
- (NSInteger)setIntegerWithModel:(MusicModel *)model;

//要播放 需要参数 url
- (void)requestDataWithUrl:(NSString *)url andBlock:(myBlock) myBlock;

+ (SharedManager *)sharedManager;


@end
