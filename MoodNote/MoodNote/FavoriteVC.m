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
#import "UMSocial.h"

@interface FavoriteVC ()<UITableViewDataSource ,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *favorites;
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
        _favorites = [NSMutableArray array];
        _favorites = [NSMutableArray arrayWithArray:[DBEngine getFavoritesFromLocal]];
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
     FavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoritesCellID"];
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

#pragma mark - UM分享
    UIImage *shareImage = [UIImage imageWithData:imageData];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56a3781a67e58e9bf7002cac"
                                      shareText:[[self getCurrentModelWithButton:sender].title stringByAppendingString:@"      --来自Encounter遇见，心中的小美好。"]
                                     shareImage:shareImage
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToEmail,UMShareToSms,nil]
                                       delegate:nil];
}
- (IBAction)likeAction:(UIButton *)sender {
    //获取btnView
    UIView *btnView = [sender superview];
    //获取tempView
    UIView *tempView = [btnView superview];
    //获取当前Button所在cell的信息
    FavoriteCell *currentCell = (FavoriteCell *)[[tempView superview] superview];
    //获取当前的IndexPath
    NSIndexPath *currentIndexPath = [self.tableView indexPathForCell:currentCell];
    NSInteger rowIndex = currentIndexPath.row;
    int index = (int)rowIndex;
    //得到当前Model
    ContentModel *currentModel = self.favorites[index];
    [self.favorites removeObjectAtIndex:index];
    //更新UI
    [self.tableView reloadData];
    
    //删除数据库内容
    [DBEngine deleteDataWithID:currentModel.ID];
    
    UILabel *popLabel = [[UILabel alloc]init];
    popLabel.textAlignment = NSTextAlignmentCenter;
    popLabel.font = [UIFont systemFontOfSize:12];
    popLabel.text = @"取消收藏成功";
    popLabel.layer.cornerRadius = 10;
    popLabel.clipsToBounds = YES;
    popLabel.backgroundColor = [UIColor orangeColor];
    popLabel.frame = CGRectMake(75, kScreenH * 5 / 6 - 40, kScreenW - 150, 20);
    [self.view addSubview:popLabel];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:popLabel selector:@selector(removeFromSuperview) userInfo:nil repeats:NO];
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
