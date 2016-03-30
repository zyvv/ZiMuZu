//
//  ZMZTabBarController.m
//  ZiMuZu
//
//  Created by 张洋威 on 16/3/30.
//  Copyright © 2016年 YangWei Zhang. All rights reserved.
//

#import "ZMZTabBarController.h"

@interface ZMZTabBarController ()

@end

@implementation ZMZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *barTintColor = [UIColor colorWithRGB:0x020202];
    self.tabBar.barTintColor = barTintColor;
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
