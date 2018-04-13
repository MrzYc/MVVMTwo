//
//  YCRefreshHeader.m
//  MVVMTwo
//
//  Created by 赵永闯 on 2018/4/13.
//  Copyright © 2018年 zhaoyongchuang. All rights reserved.
//

#import "YCRefreshHeader.h"

@interface YCRefreshHeader() {
    float lastPosition;
    
    float contentHeight;
    float headerHeight;
    BOOL isRefresh;
    
    UILabel *headerLabel;
    UIView *headerView;
    UIImageView *headerIV;
    UIActivityIndicatorView *activityView;
}

@end

@implementation YCRefreshHeader

//设置刷新状态
-(void)header{
    //是否是刷新状态
    isRefresh=NO;
    //最新的位置
    lastPosition=0;
    //头部高度
    headerHeight=35;
    float scrollWidth=_scrollView.frame.size.width;
    float imageWidth = 13;
    float imageHeight = headerHeight;
    float labelWidth = 130;
    float labelHeight=headerHeight;
    
    //设置刷新的头部视图
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -headerHeight-10, _scrollView.frame.size.width, headerHeight)];
    headerView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:headerView];
    
    //设置刷新显示的文字视图
    headerLabel=[[UILabel alloc] initWithFrame:CGRectMake((scrollWidth-labelWidth)/2, 0, labelWidth, labelHeight)];
    headerLabel.backgroundColor = [UIColor orangeColor];
    [headerView addSubview:headerLabel];
    headerLabel.textAlignment=NSTextAlignmentCenter;
    headerLabel.text=@"下拉可刷新";
    headerLabel.font=[UIFont systemFontOfSize:14];
    
    //设置刷新的是图标
    headerIV=[[UIImageView alloc] initWithFrame:CGRectMake((scrollWidth-labelWidth)/2-imageWidth, 0, imageWidth, imageHeight)];
    [headerView addSubview:headerIV];
    headerIV.image=[UIImage imageNamed:@"down"];
    
    //设置刷新状态
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame=CGRectMake((scrollWidth-labelWidth)/2-imageWidth, 0, imageWidth, imageHeight);
    [headerView addSubview:activityView];
    
    //初始化刷新状态
    activityView.hidden=YES;
    headerIV.hidden=NO;
    
    //为scrollView设置KVO的观察者对象，keyPath为contentOffset属性
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

//当属性的值发生变化时，自动调用此方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![@"contentOffset" isEqualToString:keyPath]) return;
    //获取_scrollView的contentSize
    contentHeight=_scrollView.contentSize.height;
    //判断是否在拖动_scrollView
    if (_scrollView.dragging) {
        int currentPostion = _scrollView.contentOffset.y;
        //判断是否正在刷新  否则不做任何操作
        if (!isRefresh) {
            [UIView animateWithDuration:0.3 animations:^{
                //当currentPostion 小于某个值时 变换状态
                if (currentPostion<-headerHeight*1.5) {
                    headerLabel.text=@"松开以刷新";
                    headerIV.transform = CGAffineTransformMakeRotation(M_PI);
                }else{
                    int currentPostion = _scrollView.contentOffset.y;
                    //判断滑动方向 以让“松开以刷新”变回“下拉可刷新”状态
                    if (currentPostion - lastPosition > 5) {
                        lastPosition = currentPostion;
                        headerIV.transform = CGAffineTransformMakeRotation(M_PI*2);
                        headerLabel.text=@"下拉可刷新";
                        //                        NSLog(@"lastPosition = %.2f  currentPostion = %.2d", lastPosition, currentPostion);
                        //                        NSLog(@"-------");
                    }else if (lastPosition - currentPostion > 5)
                    {
                        lastPosition = currentPostion;
                        //                        NSLog(@"lastPosition = %.2f  currentPostion = %.2d", lastPosition, currentPostion);
                        //                        NSLog(@"++++++++");                        
                    }
                }
            }];
        }
    }else{
        //进入刷新状态
        if ([headerLabel.text isEqualToString:@"松开以刷新"]) {
            [self beginRefreshing];
        }
    }
}
//开始刷新操作  如果正在刷新则不做操作
-(void)beginRefreshing{
    if (!isRefresh) {
        isRefresh=YES;
        headerLabel.text=@"正在载入…";
        headerIV.hidden=YES;
        activityView.hidden=NO;
        [activityView startAnimating];
        //设置刷新状态_scrollView的位置
        [UIView animateWithDuration:0.3 animations:^{
            //设置scollView的刷新状态
            _scrollView.contentInset = UIEdgeInsetsMake(headerHeight * 1.5, 0, 0, 0);
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
            _scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
            headerIV.hidden=NO;
            headerIV.transform = CGAffineTransformMakeRotation(M_PI*2);
            [activityView stopAnimating];
            activityView.hidden=YES;
        }];
    });
}

//记得移除观察者
-(void)dealloc{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}


@end
