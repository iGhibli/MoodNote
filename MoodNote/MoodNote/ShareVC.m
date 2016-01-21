//
//  ShareVC.m
//  MoodNote
//
//  Created by qingyun on 16/1/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ShareVC.h"

@interface ShareVC ()
@property (weak, nonatomic) IBOutlet UIImageView *ShareImage;
@property (weak, nonatomic) IBOutlet UIView *iconsView;

@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iconsView.alpha = 1;
    self.view.backgroundColor = [UIColor cyanColor];
    self.view.alpha = 0.5;
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden)];
    [self.view addGestureRecognizer:click];
}

- (void)hidden
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
