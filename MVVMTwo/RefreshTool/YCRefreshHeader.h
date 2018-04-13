//
//  YCRefreshHeader.h
//  MVVMTwo
//
//  Created by 赵永闯 on 2018/4/13.
//  Copyright © 2018年 zhaoyongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^BeginRefreshingBlock)(void);

typedef void (^BlcokName)(void);

@interface YCRefreshHeader : NSObject

@property UIScrollView *scrollView;
@property (nonatomic, copy) BeginRefreshingBlock beginRefreshingBlock;

//初始化头部刷新页面
-(void)header;
//结束刷新
-(void)endRefreshing;
//开始刷新
-(void)beginRefreshing;

@end
