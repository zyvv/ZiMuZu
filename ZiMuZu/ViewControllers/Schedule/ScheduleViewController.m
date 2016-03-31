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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellID];
        cell.rowTitle = @"Today";
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return [ZMZHelper dramaCellHeight] + 47;
    }
    return 1000;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 100;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        SDDatePickerView *dataPickerView = [[[NSBundle mainBundle] loadNibNamed:@"SDDatePickerView" owner:self options:nil] lastObject];
//        dataPickerView.frame = CGRectMake(0, 0, kScreenWidth, 100);
        return dataPickerView;
    }
    return nil;
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
