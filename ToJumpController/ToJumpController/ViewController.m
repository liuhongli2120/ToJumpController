//
//  ViewController.m
//  ToJumpController
//
//  Created by 刘宏立 on 2016/11/23.
//  Copyright © 2016年 lhl. All rights reserved.
//

#import "ViewController.h"
#import "MineModel.h"
#import "HLUniversityCell.h"

static NSString *cellId = @"cellId";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController {
    NSArray *_funcList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"小浣熊跳转控制器";
    [self loadPlistData];
    [self setupUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *group = _funcList[indexPath.section];
    _selectedModel = group[indexPath.row];
    
    NSLog(@"name = %@,  city = %@, %zd -- %zd", _selectedModel.name, _selectedModel.city, _funcList[indexPath.section], group[indexPath.row]);
    
    if ([_selectedModel.name isEqualToString:@"北京大学"]) {
        
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _funcList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *group = _funcList[section];
    return group.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    NSArray *group = _funcList[indexPath.section];
    
    
    
    MineModel *model = group[indexPath.row];
    
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.city;
    
    return cell;
}

#pragma mark - loadPlistData(加载数据)
- (void)loadPlistData {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"myUniversityName.plist" withExtension:nil];
    NSArray *array = [[NSArray alloc]initWithContentsOfURL:url];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSArray *list in array) {
        NSMutableArray *group = [NSMutableArray array];
        for (NSDictionary *dict in list) {
            MineModel *model = [[MineModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [group addObject:model];
        }
        [arrayM addObject:group];
    }
    _funcList = arrayM.copy;
}



#pragma mark - 设置界面
- (void)setupUI {
    UITableView *tv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tv];
    
    
    [tv registerClass:[HLUniversityCell class] forCellReuseIdentifier:cellId];
    
    tv.dataSource = self;
    tv.delegate = self;
}


@end
