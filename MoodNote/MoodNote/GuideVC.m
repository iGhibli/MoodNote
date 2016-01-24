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

@interface GuideVC ()

@property (weak, nonatomic) IBOutlet UIScrollView *guideView;
@property (weak, nonatomic) IBOutlet UIButton *guiEndBtn;
@end

@implementation GuideVC

- (void)viewDidLoad {
    self.guiEndBtn.layer.cornerRadius = 15;
    self.guiEndBtn.clipsToBounds = YES;
    [super viewDidLoad];
    self.guideView.contentSize = CGSizeMake(kScreenW * 4, kScreenH);
}
- (IBAction)guideEndAction:(UIButton *)sender {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app guideEnd];
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

@end
