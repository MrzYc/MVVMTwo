//
//  TableViewModel.h
//  MVVMTwo
//
//  Created by 赵永闯 on 2018/4/13.
//  Copyright © 2018年 zhaoyongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^callback) (NSArray *array);

@interface TableViewModel : NSObject

//tableview头部刷新网络请求
- (void)headerRefreshRequestWithCallback:(callback)callback;
//tableView底部刷新的网络请求
- (void)footerRefreshRequestWithCallback:(callback)callback;

@end
