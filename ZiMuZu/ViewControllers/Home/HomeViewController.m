//
//  HomeViewController.m
//  ZiMuZu
//
//  Created by 张洋威 on 16/3/28.
//  Copyright © 2016年 太阳花互动. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "DramaLayout.h"
#import "AHKActionSheet.h"


@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *rowTitleArray;

@end

@implementation HomeViewController

static NSString *cellID = @"HomeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rowTitleArray = @[@"Top 10", @"United States", @"United Kingdom", @"Japan", @"Movie", @"Other"];
    [_tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sortButtonItemAction:(UIBarButtonItem *)sender {
    AHKActionSheet *actionSheet = [[AHKActionSheet alloc] initWithTitle:nil];
    
    
    actionSheet.blurTintColor = [UIColor colorWithWhite:0.0f alpha:0.85f];
    actionSheet.blurRadius = 12.0f;
    actionSheet.buttonHeight = 60.0f;
    actionSheet.cancelButtonHeight = 70.0f;
    actionSheet.animationDuration = 0.25f;
    actionSheet.cancelButtonShadowColor = [UIColor colorWithWhite:0.0f alpha:0.1f];
    actionSheet.separatorColor = [UIColor colorWithWhite:1.0f alpha:0.3f];
    actionSheet.selectedBackgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    UIFont *defaultFont = kCustomFontWithSize(17);
    actionSheet.buttonTextAttributes = @{ NSFontAttributeName : defaultFont,
                                          NSForegroundColorAttributeName : [UIColor whiteColor] };
    actionSheet.disabledButtonTextAttributes = @{ NSFontAttributeName : defaultFont,
                                                  NSForegroundColorAttributeName : [UIColor grayColor] };
    actionSheet.destructiveButtonTextAttributes = @{ NSFontAttributeName : defaultFont,
                                                     NSForegroundColorAttributeName : [UIColor redColor] };
    actionSheet.cancelButtonTextAttributes = @{ NSFontAttributeName : defaultFont,
                                                NSForegroundColorAttributeName : [UIColor whiteColor] };
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Info", nil)
                              image:[UIImage imageNamed:@"Icon1"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                NSLog(@"Info tapped");
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Add to Favorites", nil)
                              image:[UIImage imageNamed:@"Icon2"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                NSLog(@"Favorite tapped");
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Share", nil)
                              image:[UIImage imageNamed:@"Icon3"]
                               type:AHKActionSheetButtonTypeDefault
                            handler:^(AHKActionSheet *as) {
                                NSLog(@"Share tapped");
                            }];
    
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Delete", nil)
                              image:[UIImage imageNamed:@"Icon4"]
                               type:AHKActionSheetButtonTypeDestructive
                            handler:^(AHKActionSheet *as) {
                                NSLog(@"Delete tapped");
                            }];
    
    [actionSheet show];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _rowTitleArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.rowTitle = _rowTitleArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZMZHelper dramaCellHeight] + 47;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
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
