//
//  TableViewModel.m
//  MVVMTwo
//
//  Created by 赵永闯 on 2018/4/13.
//  Copyright © 2018年 zhaoyongchuang. All rights reserved.
//

#import "TableViewModel.h"
#import "CustomModel.h"

@implementation TableViewModel

- (instancetype)init {
    
    if(self == [super init]) {
        
    }
    return self;
}


- (void)headerRefreshRequestWithCallback:(callback)callback {
    //后台执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //模拟网络请求过程
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程刷新UI页面
            NSMutableArray *arr=[NSMutableArray array];
            for (int i=0; i<16; i++) {
                int x = arc4random() % 100;
                NSString *string=[NSString stringWithFormat:@"    (random%d) MVVM的应用!",x];
                CustomModel *model=[[CustomModel alloc] init];
                model.title=string;
                [arr addObject:model];
            }
            callback(arr);
        });
    });
}


- (void )footerRefreshRequestWithCallback:(callback)callback
{
    //后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程刷新视图
            NSMutableArray *arr=[NSMutableArray array];
            for (int i=0; i<10; i++) {
                int x = arc4random() % 100;
                NSString *string=[NSString stringWithFormat:@"    (random%d)  MVVM的应用!",x];
                CustomModel *model=[[CustomModel alloc] init];
                model.title=string;
                [arr addObject:model];
            }
            callback(arr);
        });
    });
}

@end
