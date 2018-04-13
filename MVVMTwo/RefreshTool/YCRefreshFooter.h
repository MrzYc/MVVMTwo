//
//  YCRefreshFooter.h
//  MVVMTwo
//
//  Created by 赵永闯 on 2018/4/13.
//  Copyright © 2018年 zhaoyongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^BeginRefreshingBlock)(void);

@interface YCRefreshFooter : NSObject

@property UIScrollView *scrollView;

@property (nonatomic, copy) BeginRefreshingBlock beginRefreshingBlock;

//初始化底部控件
-(void)footer;
//结束底部刷新
-(void)endRefreshing;
//开始底部刷新
-(void)beginRefreshing;

@end
