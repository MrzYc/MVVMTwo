//
//  TableViewDataSource.h
//  MVVMTwo
//
//  Created by 赵永闯 on 2018/4/13.
//  Copyright © 2018年 zhaoyongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic,strong) NSArray *array;


@end
