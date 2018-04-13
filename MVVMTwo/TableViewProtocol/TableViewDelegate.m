//
//  TableViewDelegate.m
//  MVVMTwo
//
//  Created by 赵永闯 on 2018/4/13.
//  Copyright © 2018年 zhaoyongchuang. All rights reserved.
//

#import "TableViewDelegate.h"

@implementation TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_array.count>0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:((CustomModel *)[_array objectAtIndex:indexPath.row]).title preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action1];
        UIViewController *viewC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        [viewC presentViewController:alert animated:YES completion:nil];
    }
}

@end
