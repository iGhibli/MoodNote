//
//  MusicVC.m
//  MoodNote
//
//  Created by 赛驰 on 16/5/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MusicVC.h"
#import "Common.h"

@interface MusicVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *storyBtn;
@property (weak, nonatomic) IBOutlet UIButton *lrcBtn;
@property (weak, nonatomic) IBOutlet UIButton *infoBtn;

@property (nonatomic, strong) UITextView *storyTextView;
@property (nonatomic, strong) UITextView *lrcTextView;
@property (nonatomic, strong) UITextView *infoTextView;
@end

@implementation MusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}

- (void)setupSubViews
{
    //初始化
    self.topLabel.text = @"音乐故事";
    self.storyBtn.selected = YES;
    self.lrcBtn.selected = NO;
    self.infoBtn.selected = NO;
    //ScrollView
    self.scrollView.contentSize = CGSizeMake(kScreenW * 3, kScreenH-44-44);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.scrollEnabled = NO;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    //storyTextView
    self.storyTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, kScreenW-20, kScreenH-44-44)];
    self.storyTextView.textColor = [UIColor blackColor];
    self.storyTextView.font
    = [UIFont systemFontOfSize:14.f];//设置字体名字和字体大小
    self.storyTextView.backgroundColor
    = [UIColor whiteColor];//设置它的背景颜色
    self.storyTextView.text = self.model.story;
    self.storyTextView.scrollEnabled = YES;//是否可以拖动
    self.storyTextView.editable = NO;//禁止编辑
    self.storyTextView.showsVerticalScrollIndicator = NO;
    self.storyTextView.showsHorizontalScrollIndicator = NO;
    self.storyTextView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.storyTextView];
    
    //lrcTextView
    self.lrcTextView = [[UITextView alloc]initWithFrame:CGRectMake(kScreenW+10, 0, kScreenW-20, kScreenH-44-44)];
    self.lrcTextView.textColor = [UIColor blackColor];
    self.lrcTextView.font
    = [UIFont systemFontOfSize:14.f];//设置字体名字和字体大小
    self.lrcTextView.backgroundColor
    = [UIColor whiteColor];//设置它的背景颜色
    self.lrcTextView.text = self.model.lyric;
    self.lrcTextView.scrollEnabled = YES;//是否可以拖动
    self.lrcTextView.editable = NO;//禁止编辑
    self.lrcTextView.showsHorizontalScrollIndicator = NO;
    self.lrcTextView.showsVerticalScrollIndicator = NO;
    self.lrcTextView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.lrcTextView];
    
    //infoTextView
    self.infoTextView = [[UITextView alloc]initWithFrame:CGRectMake(kScreenW*2+10, 0, kScreenW-20, kScreenH-44-44)];
    self.infoTextView.textColor = [UIColor blackColor];
    self.infoTextView.font
    = [UIFont systemFontOfSize:14.f];//设置字体名字和字体大小
    self.infoTextView.backgroundColor
    = [UIColor whiteColor];//设置它的背景颜色
    self.infoTextView.text = self.model.info;
    self.infoTextView.scrollEnabled = YES;//是否可以拖动
    self.infoTextView.editable = NO;//禁止编辑
    self.infoTextView.showsVerticalScrollIndicator = NO;
    self.infoTextView.showsHorizontalScrollIndicator = NO;
    self.infoTextView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.infoTextView];
}

#pragma mark - ButtonAction
- (IBAction)storyBtnAction:(UIButton *)sender {
    self.topLabel.text = @"音乐故事";
    self.storyBtn.selected = YES;
    self.lrcBtn.selected = NO;
    self.infoBtn.selected = NO;
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

- (IBAction)lrcBtnAction:(UIButton *)sender {
    self.topLabel.text = @"歌词";
    self.storyBtn.selected = NO;
    self.lrcBtn.selected = YES;
    self.infoBtn.selected = NO;
    self.scrollView.contentOffset = CGPointMake(kScreenW, 0);
}

- (IBAction)infoBtnAction:(UIButton *)sender {
    self.topLabel.text = @"歌曲信息";
    self.storyBtn.selected = NO;
    self.lrcBtn.selected = NO;
    self.infoBtn.selected = YES;
    self.scrollView.contentOffset = CGPointMake(kScreenW*2, 0);
}

- (IBAction)backBtnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backItemAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
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

#pragma mark - 控制屏幕旋转
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
