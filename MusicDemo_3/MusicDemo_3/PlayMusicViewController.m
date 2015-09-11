//
//  PlayMusicViewController.m
//  MusicDemo_3
//
//  Created by 刘杰 on 15/8/11.
//  Copyright (c) 2015年 liujie. All rights reserved.
//

#import "PlayMusicViewController.h"
#import "SharedPlayMusic.h"
#import "SharedManager.h"
#import "LyricModel.h"

@interface PlayMusicViewController ()<AVPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PlayMusicViewController

+ (PlayMusicViewController *)sharedManager{
    static PlayMusicViewController * audioManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioManager = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"playMusic"];
    });
    return audioManager;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([SharedPlayMusic sharedManager].musicModel == self.model)
    {
        return;
    }
    [self play];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self play];
    [SharedPlayMusic sharedManager].delegate = self;
    [self.imageView layoutIfNeeded];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height / 2;
    
}

- (void)play
{
    //把model传给播放的单利
    [SharedPlayMusic sharedManager].musicModel = self.model;
    //调播放的方法;
    [[SharedPlayMusic sharedManager] preparMusicPlay];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[SharedPlayMusic sharedManager] allLyricArrayItem].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lyric_id" forIndexPath:indexPath];
    if (indexPath.row > [[SharedPlayMusic sharedManager] allLyricArrayItem].count - 1)
    {
        return cell;
    }
    LyricModel *model = [[[SharedPlayMusic sharedManager] allLyricArrayItem] objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = model.lyricStr;
    cell.textLabel.highlightedTextColor = [UIColor redColor];

    cell.selectedBackgroundView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        view;
    });
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)pasueButton:(id)sender
{
    
}
- (IBAction)lastButton:(id)sender
{
    NSInteger temp = [[SharedManager sharedManager] setIntegerWithModel:self.model];
    if (temp > 0)
    {
        temp --;
    }else
    {
        temp = [SharedManager sharedManager].count - 1;
    }
    self.model = [[SharedManager sharedManager] setModelWithIndexpath:temp];
    [self play];

}
- (void)audioPlayerTimeDidEnd
{
    [self nextButton:nil];
}
- (IBAction)nextButton:(id)sender
{
    NSInteger temp = [[SharedManager sharedManager] setIntegerWithModel:self.model];
    if (temp < [SharedManager sharedManager].count - 1)
    {
        temp ++;
    }else
    {
        temp = 0;
    }
    self.model = [[SharedManager sharedManager] setModelWithIndexpath:temp];
    [self play];
    
}
- (IBAction)progressSlider:(UISlider *)sender
{
    [[SharedPlayMusic sharedManager] seekToTime:sender.value];
}

- (void)audioPlayerWithProgress:(CGFloat)progress currentTime:(NSString *)currentTime totalTime:(NSString *)totalTime
{
    self.progressSlider.value = progress;
    self.currentTime.text = currentTime;
    self.totalTime.text = totalTime;
    
    NSInteger index = [[SharedPlayMusic sharedManager] indexWithLyricTime:currentTime];
    if (index == -1)
    {
        NSLog(@"没有找到");
    }else
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:(UITableViewScrollPositionMiddle)];
    }
    
}


- (IBAction)backButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
