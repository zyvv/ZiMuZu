//
//  ZMZViewController.m
//  ZiMuZu
//
//  Created by 张洋威 on 16/3/30.
//  Copyright © 2016年 YangWei Zhang. All rights reserved.
//

#import "ZMZViewController.h"

@interface ZMZViewController ()

@end

@implementation ZMZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *backgroundColor = [UIColor colorWithRGB:0x0f1011];
    self.view.backgroundColor = backgroundColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIColor *navigationBarColor = [UIColor colorWithRGBA:0x1717174c];
//    self.navigationController.navigationBar.backgroundColor = navigationBarColor;
    self.navigationController.navigationBar.barTintColor = navigationBarColor;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = nil;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    NSDictionary *textAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                     NSFontAttributeName: kCustomFontWithSize(18)};
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    self.navigationController.navigationBar.tintColor = nil;
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
