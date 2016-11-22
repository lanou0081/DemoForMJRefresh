//
//  NextViewController.m
//  DemoForMJRefresh
//
//  Created by Rickie_Lambert on 16/10/29.
//  Copyright © 2016年 DemoForExcise. All rights reserved.
//

#import "NextViewController.h"
#import "MJRefresh.h"
#import "LastViewController.h"

@interface NextViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation NextViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.alpha = 0.3;
    
    _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
    
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    _myTableView.mj_footer.automaticallyChangeAlpha = YES;
    
    // 在头部加载 下拉刷新
    _myTableView.mj_footer =  [MJRefreshBackFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [_myTableView.mj_footer endRefreshing];
        });
    }];
}

- (void)lastClicked
{
    LastViewController *last = [[LastViewController alloc] init];
    [self.navigationController pushViewController:last animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellFortest1111";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@" %ld -nextView- %ld", (long)indexPath.section, (long)indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@" Header in %ld", (long)section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LastViewController *last = [[LastViewController alloc] init];
    [self.navigationController pushViewController:last animated:YES];
}


@end
