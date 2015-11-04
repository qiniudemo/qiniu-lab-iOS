//
//  FirstVC.m
//  QNAaronTest
//
//  Created by   何舒 on 15/10/13.
//  Copyright © 2015年   何舒. All rights reserved.
//

#import "FirstVC.h"

@interface FirstVC ()

@property (nonatomic, strong) NSArray * catalogList;
@property (nonatomic, assign) NSInteger tableViewNum;

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"七牛实验室";
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Catalog List" ofType:@"plist"];
    self.catalogList = [[NSArray alloc] initWithContentsOfFile:plistPath];
    self.tableViewNum = 0;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KDeviceHeight, 60)];
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, KDeviceHeight, 30)];
    title.font = [UIFont systemFontOfSize:20];
    NSDictionary * dic = self.catalogList[section];
    title.text = dic[@"title"];
    [view addSubview:title];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.catalogList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        NSDictionary * dic = [self.catalogList objectAtIndex:section];
        NSArray * array = dic[@"function"];
        return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString * cellName = @"Cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        }
        NSDictionary * dic = self.catalogList[indexPath.section][@"function"][indexPath.row];
        cell.textLabel.text = dic[@"functionName"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = self.catalogList[indexPath.section][@"function"][indexPath.row];
    Class className = NSClassFromString(dic[@"functionVCName"]);
    BaseVC *baseVC=[[className alloc] init];
    
    [self.navigationController pushViewController:baseVC animated:YES];
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
