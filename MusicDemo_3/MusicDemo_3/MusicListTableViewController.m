//
//  MusicListTableViewController.m
//  MusicDemo_3
//
//  Created by 刘杰 on 15/8/11.
//  Copyright (c) 2015年 liujie. All rights reserved.
//

#import "MusicListTableViewController.h"
#import "SharedManager.h"
#import "MusicModel.h"
#import "MusicTableViewCell.h"
#import "PlayMusicViewController.h"
@interface MusicListTableViewController ()


@end

@implementation MusicListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //单利 block回调
    [[SharedManager sharedManager] requestDataWithUrl:@"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist" andBlock:^{
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //返回数组个数
    return [SharedManager sharedManager].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"musicList_id" forIndexPath:indexPath];
    //拿到model
    MusicModel *model = [[SharedManager sharedManager] setModelWithIndexpath:indexPath.row];
    //工厂模式 加载数据
    [cell setManagerWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayMusicViewController *playMusic = [PlayMusicViewController sharedManager];
    //拿到你想要的model..通过下标找到对应的model
    playMusic.model = [[SharedManager sharedManager] setModelWithIndexpath:indexPath.row];
    [self showDetailViewController:playMusic sender:nil];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
