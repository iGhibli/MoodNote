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
#import "ShareVC.h"

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
    //获取当前Model
    ContentModel *currentModel = [self getCurrentModelWithButton:sender];
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
    //获取btnView
    UIView *btnView = [sender superview];
    //获取tempView
    UIView *tempView = [btnView superview];
    //获取当前Button所在cell的contentView信息
    UIView *currentContentView = [tempView superview];
    
#pragma mark - 截屏
    CGSize imageSize = CGSizeMake(currentContentView.frame.size.width, currentContentView.frame.size.height - 40);
    //1.开启图片上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0.0);
    //2.获取当前上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //3.绘制
    [currentContentView.layer renderInContext:ctx];
    //4.取出图片，
    UIImage *currentImage=UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData=UIImagePNGRepresentation(currentImage);
    
    NSString *tempPath = NSTemporaryDirectory();
    NSString *imageDataPath = [tempPath stringByAppendingPathComponent:@"CurrentScreenData"];
    //    NSLog(@"%@",imageDataPath);
    [imageData writeToFile:imageDataPath atomically:YES];
    //.关闭图形上下文
    UIGraphicsEndImageContext();
    
    ShareVC *VC = [ShareVC new];
    //    ShareVC *VC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"ShareVCID"];
    //模态出的试图控制器透明需要设置此项
    //    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:VC animated:YES completion:nil];
}
- (IBAction)likeAction:(UIButton *)sender {
    //获取当前Model
    ContentModel *currentModel = [self getCurrentModelWithButton:sender];
    //删除数据库内容
    [DBEngine deleteDataWithID:currentModel.ID];
    self.favorites = [DBEngine getFavoritesFromLocal];
    //更新UI
//    [sender setImage:[UIImage imageNamed:@"litle-like-1"] forState:UIControlStateNormal];
    [self.tableView reloadData];
}

/**
 *  通过当前Button获取当前Button所在Cell的Model
 *
 *  @param sender 当前Button
 *
 *  @return 当前Cell的Model
 */
- (ContentModel *)getCurrentModelWithButton:(UIButton *)sender
{
    //获取btnView
    UIView *btnView = [sender superview];
    //获取tempView
    UIView *tempView = [btnView superview];
    //获取当前Button所在cell的信息
    FavoriteCell *currentCell = (FavoriteCell *)[[tempView superview] superview];
    //获取当前的IndexPath
    NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:currentCell];
    //    NSLog(@"IndexPath-----%@",currentIndexPath);
    //得到当前Model
    ContentModel *currentModel = self.favorites[currentIndexPath.row];
    return currentModel;
}

@end
