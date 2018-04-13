
//
//  TableViewController.m
//  MVVMTwo
//
//  Created by 赵永闯 on 2018/4/13.
//  Copyright © 2018年 zhaoyongchuang. All rights reserved.
//

#import "TableViewController.h"
#import "YCRefreshFooter.h"
#import "YCRefreshHeader.h"
#import "TableViewModel.h"
#import "TableViewDataSource.h"
#import "TableViewDelegate.h"


@interface TableViewController ()
{
    YCRefreshHeader *refreshHeader;
    YCRefreshFooter *refreshFooter;
    NSMutableArray *totalSource;
    TableViewModel *tableViewModel;
    UITableView *tableView;
    TableViewDataSource *tableViewDataSource;
    TableViewDelegate *tableViewDelegate;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    self.title=@"MVVM";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen-64) style:UITableViewStylePlain];
    //添加tableView
    [self.view addSubview:tableView];
    
    tableViewDataSource=[[TableViewDataSource alloc] init];
    tableViewDelegate = [[TableViewDelegate alloc] init];
    //设置tableView的数据代理
    tableView.dataSource = tableViewDataSource;
    //设置tableView的事件代理
    tableView.delegate=tableViewDelegate;
    tableViewModel= [[TableViewModel alloc] init];
    totalSource = 0;
    
    //   YiRefreshHeader  头部刷新按钮的使用
    refreshHeader=[[YCRefreshHeader alloc] init];
    //设置刷新控件的ScrollView
    refreshHeader.scrollView = tableView;
    [refreshHeader header];
    __weak typeof(self) weakSelf = self;
    refreshHeader.beginRefreshingBlock=^(){
        //设置刷新事件回调
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf headerRefreshAction];
    };
    
    //是否在进入该界面的时候就开始进入刷新状态
    [refreshHeader beginRefreshing];
    
    //YiRefreshFooter  底部刷新按钮的使用
    refreshFooter=[[YCRefreshFooter alloc] init];
    refreshFooter.scrollView=tableView;
    [refreshFooter footer];
    
    refreshFooter.beginRefreshingBlock=^(){
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf footerRefreshAction];
    };
    
}

- (void)headerRefreshAction
{
    [tableViewModel headerRefreshRequestWithCallback:^(NSArray *array){
        totalSource=(NSMutableArray *)array;
        tableViewDataSource.array=totalSource;
        tableViewDelegate.array=totalSource;
        [refreshHeader endRefreshing];
        [tableView reloadData];
    }];

}


- (void)footerRefreshAction
{
    [tableViewModel footerRefreshRequestWithCallback:^(NSArray *array){
        [totalSource addObjectsFromArray:array] ;
        tableViewDataSource.array=totalSource;
        tableViewDelegate.array=totalSource;
        [refreshFooter endRefreshing];
        [tableView reloadData];
        
    }];
    
}



@end
