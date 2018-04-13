//
//  TableViewDataSource.m
//  MVVMTwo
//
//  Created by 赵永闯 on 2018/4/13.
//  Copyright © 2018年 zhaoyongchuang. All rights reserved.
//

#import "TableViewDataSource.h"
#import "CustomTableViewCell.h"

@implementation TableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.titleLabel.text = ((CustomModel *)[_array objectAtIndex:indexPath.row]).title;
    return cell;
}


@end
