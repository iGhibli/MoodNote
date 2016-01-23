//
//  FavoriteVC.m
//  MoodNote
//
//  Created by qingyun on 16/1/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "FavoriteVC.h"
#import "ContentModel.h"
#import "DBEngine.h"
#import "FavoriteCell.h"
#import "Common.h"

@interface FavoriteVC ()<UITableViewDataSource ,UITableViewDelegate>
@property (nonatomic, strong) NSArray *favorites;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation FavoriteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSwipeGesture];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)addSwipeGesture
{
    //添加下滑手势
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:[UIApplication sharedApplication].delegate action:@selector(swipeDownAction)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

#pragma mark - Getter & Setter

- (NSArray *)favorites {
    if (_favorites == nil) {
        _favorites = [NSArray array];
        _favorites = [DBEngine getFavoritesFromLocal];
    }
    return _favorites;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.favorites.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [FavoriteCell favoriteCellHeightWithModel:self.favorites[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     FavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoritesCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bandingFavoriteCellWithModel:self.favorites[indexPath.row]];
    return cell;
}

- (IBAction)copyAction:(UIButton *)sender {
    //获取btnView
    UIView *btnView = [sender superview];
    //获取当前Button所在cell的信息
    FavoriteCell *currentCell = (FavoriteCell *)[[btnView superview] superview];
    //获取当前的IndexPath
    NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:currentCell];
    NSLog(@"IndexPath-----%@",currentIndexPath);
    //得到当前Model
    ContentModel *currentModel = self.favorites[currentIndexPath.row];
    
    //获取剪切板
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    //将内容赋值给剪切板
    pasteBoard.string = currentModel.title;
    UILabel *popLabel = [[UILabel alloc]init];
    popLabel.textAlignment = NSTextAlignmentCenter;
    popLabel.font = [UIFont systemFontOfSize:12];
    popLabel.text = @"已复制美句到剪切板";
    popLabel.layer.cornerRadius = 10;
    popLabel.clipsToBounds = YES;
    popLabel.backgroundColor = [UIColor orangeColor];
    popLabel.frame = CGRectMake(75, kScreenH * 5 / 6 - 40, kScreenW - 150, 20);
    [self.view addSubview:popLabel];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:popLabel selector:@selector(removeFromSuperview) userInfo:nil repeats:NO];
}

- (IBAction)shareAction:(UIButton *)sender {
    
}
- (IBAction)likeAction:(UIButton *)sender {
    
}
@end
