//
//  ScheduleViewController.m
//  ZiMuZu
//
//  Created by 张洋威 on 16/3/28.
//  Copyright © 2016年 太阳花互动. All rights reserved.
//

#import "ScheduleViewController.h"
#import "SDHeaderView.h"
#import "SDDatePickerView.h"
#import "HomeCell.h"

@interface ScheduleViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

static NSString *homeCellID = @"HomeCell";

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [_tableView registerNib:[UINib nibWithNibName:homeCellID bundle:nil] forCellReuseIdentifier:homeCellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (IBAction)showCalendarView:(UIBarButtonItem *)sender {
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellID];
//    cell.rowTitle = _rowTitleArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZMZHelper dramaCellSizeWithType:DramaCellLayoutTypeHorizontal].height + 47;
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
