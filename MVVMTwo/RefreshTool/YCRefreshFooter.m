//
//  YCRefreshFooter.m
//  MVVMTwo
//
//  Created by 赵永闯 on 2018/4/13.
//  Copyright © 2018年 zhaoyongchuang. All rights reserved.
//

#import "YCRefreshFooter.h"

@interface YCRefreshFooter() {
    float contentHeight;
    float scrollFrameHeight;
    float footerHeight;
    float scrollWidth;
    BOOL isAdd;
    BOOL isRefresh;
    
    
    UIView *footerView;
    UIActivityIndicatorView *activityView;
}

@end

@implementation YCRefreshFooter

- (void)footer {
    scrollWidth = _scrollView.frame.size.width;
    footerHeight = 35;
    scrollFrameHeight = _scrollView.frame.size.height;
    //初始化刷新状态
    isAdd=NO;
    isRefresh=NO;
    
    footerView=[[UIView alloc] init];
    //设置底部刷新控件
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![@"contentOffset" isEqualToString:keyPath]) return;
    contentHeight=_scrollView.contentSize.height;
    
    if (!isAdd) {
        isAdd=YES;
        
        footerView.frame = CGRectMake(0, contentHeight, scrollWidth, footerHeight);
        [_scrollView addSubview:footerView];
        activityView.frame = CGRectMake((scrollWidth - footerHeight)/2, 0, footerHeight, footerHeight);
        [footerView addSubview:activityView];
    }
    
    footerView.frame = CGRectMake(0, contentHeight, scrollWidth, footerHeight);
    activityView.frame = CGRectMake((scrollWidth-footerHeight)/2, 0, footerHeight, footerHeight);
    int currentPostion = _scrollView.contentOffset.y;
    
    //进入刷新状态
    if ((currentPostion > (contentHeight - scrollFrameHeight))&&(contentHeight > scrollFrameHeight)) {
        [self beginRefreshing];
    }
}

//开始刷新操作  如果正在刷新则不做操作
-(void)beginRefreshing{
    if (!isRefresh) {
        isRefresh=YES;
        [activityView startAnimating];
        //设置刷新状态_scrollView的位置
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentInset=UIEdgeInsetsMake(0, 0, footerHeight, 0);
        }];
        //block回调
        _beginRefreshingBlock();
    }
}
//关闭刷新操作
-(void)endRefreshing{
    isRefresh=NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            [activityView stopAnimating];
            _scrollView.contentInset=UIEdgeInsetsMake(0, 0, footerHeight, 0);
            footerView.frame=CGRectMake(0, contentHeight, WScreen, footerHeight);
        }];
    });
}

//移除观察者
-(void)dealloc{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];    
}

@end
