//
//  GuideVC.m
//  MoodNote
//
//  Created by qingyun on 16/1/24.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "GuideVC.h"
#import "Common.h"
#import "AppDelegate.h"

@interface GuideVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *guideView;
@property (weak, nonatomic) IBOutlet UIButton *guiEndBtn;
@end

@implementation GuideVC

- (void)viewDidLoad {
    //在此设置ScrollView的contentsize会导致ScrollView无法滚动
    //解决办法是在viewDidAppear中设置ScrollView的contentSize
//    self.guideView.contentSize = CGSizeMake(kScreenW * 4, kScreenH);
    self.guiEndBtn.layer.cornerRadius = 15;
    self.guiEndBtn.clipsToBounds = YES;
    [super viewDidLoad];
}
- (IBAction)guideEndAction:(UIButton *)sender {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app guideEnd];
}
- (IBAction)pageControlAction:(UIPageControl *)sender {
    self.guideView.contentOffset = CGPointMake(kScreenW * self.pageControl.currentPage, 0);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.guideView.contentSize = CGSizeMake(kScreenW * 4, kScreenH);
    self.guideView.delegate = self;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //有可能ScrollView没有减速效果就停止了
    if (!decelerate) {
        //未减速结束
        self.pageControl.currentPage = scrollView.contentOffset.x / kScreenW;
    }else {
        //减速结束
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //此处单独使用有漏洞，可能ScrollView没有减速效果
    self.pageControl.currentPage = scrollView.contentOffset.x / kScreenW;
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
