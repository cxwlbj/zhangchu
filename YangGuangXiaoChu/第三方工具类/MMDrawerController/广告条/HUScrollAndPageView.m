//
//  HUScrollAndPageView.m
//  test
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "HUScrollAndPageView.h"



@interface HUScrollAndPageView ()<UIScrollViewDelegate>

{
    UIView *_firstView;
    UIView *_middleView;
    UIView *_lastView;
    
    float _viewWidth;
    float _viewHeight;
    
    NSTimer *_autoScrollTimer;
    
    UITapGestureRecognizer *_tap;
}

@end

@implementation HUScrollAndPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self _initView];
}

- (void)_initView{
    _viewWidth = self.bounds.size.width;
    _viewHeight = self.bounds.size.height;
    //设置scrollview
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _viewWidth, _viewHeight)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(_viewWidth * 3, _viewHeight);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    //设置分页
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth - 60, _viewHeight-30, 50, 30)];
    
    
    _pageControl.userInteractionEnabled = NO;
#pragma mark 设置滑动点的颜色
    
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];

    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    
    _currentPage = 0; //默认为第0页
    
    _pageControl.numberOfPages = _imageViewAry.count;
    
    [self addSubview:_pageControl];
    
    //设置单击手势
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    _tap.numberOfTapsRequired = 1;
    _tap.numberOfTouchesRequired = 1;
    [_scrollView addGestureRecognizer:_tap];
    
}



#pragma mark 单击手势
-(void)handleTap:(UITapGestureRecognizer*)sender
{

    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_currentPage+1];
    }
    
}

#pragma mark 设置imageViewAry
-(void)setImageViewAry:(NSMutableArray *)imageViewAry
{
    if (imageViewAry) {
        _imageViewAry = imageViewAry;

        _currentPage = 0; //默认为第0页
        
        _pageControl.numberOfPages = _imageViewAry.count;
    }
    
    [self reloadData];
}

#pragma mark 刷新view页面
-(void)reloadData
{
    [_firstView removeFromSuperview];
    [_middleView removeFromSuperview];
    [_lastView removeFromSuperview];
    
    //从数组中取到对应的图片view加到已定义的三个view中
    if (_currentPage==0) {
        _firstView = [_imageViewAry lastObject];
        _middleView = [_imageViewAry objectAtIndex:_currentPage];
        _lastView = [_imageViewAry objectAtIndex:_currentPage+1];
    }
    else if (_currentPage == _imageViewAry.count-1)
    {
        _firstView = [_imageViewAry objectAtIndex:_currentPage-1];
        _middleView = [_imageViewAry objectAtIndex:_currentPage];
        _lastView = [_imageViewAry firstObject];
    }
    else
    {
        _firstView = [_imageViewAry objectAtIndex:_currentPage-1];
        _middleView = [_imageViewAry objectAtIndex:_currentPage];
        _lastView = [_imageViewAry objectAtIndex:_currentPage+1];
    }
    
    //设置三个view的frame，加到scrollview上
    _firstView.frame = CGRectMake(0, 0, _viewWidth, _viewHeight);
    _middleView.frame = CGRectMake(_viewWidth, 0, _viewWidth, _viewHeight);
    _lastView.frame = CGRectMake(_viewWidth*2, 0, _viewWidth, _viewHeight);
    [_scrollView addSubview:_firstView];
    [_scrollView addSubview:_middleView];
    [_scrollView addSubview:_lastView];
    
    //设置当前的分页
    _pageControl.currentPage = _currentPage;
    
    //显示中间页
    _scrollView.contentOffset = CGPointMake(_viewWidth, 0);
}

#pragma mark scrollvie停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //手动滑动时候暂停自动替换
    [_autoScrollTimer invalidate];
    _autoScrollTimer = nil;
    
    _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoShowNextImage) userInfo:nil repeats:YES];
    
    //得到当前页数
    float x = _scrollView.contentOffset.x;
    
    //往前翻
    if (x<=0) {
        if (_currentPage-1<0) {
            _currentPage = _imageViewAry.count-1;
        }else{
            _currentPage --;
        }
    }
    
    //往后翻
    if (x>=_viewWidth*2) {
        if (_currentPage==_imageViewAry.count-1) {
            _currentPage = 0;
        }else{
            _currentPage ++;
        }
    }
    
    [self reloadData];
}

#pragma mark 自动滚动
-(void)shouldAutoShow:(BOOL)shouldStart
{
    if (shouldStart)  //开启自动翻页
    {
        if (!_autoScrollTimer) {
            _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoShowNextImage) userInfo:nil repeats:YES];
        }
    }
    else   //关闭自动翻页
    {
        if (_autoScrollTimer.isValid) {
            [_autoScrollTimer invalidate];
            _autoScrollTimer = nil;
        }
    }
}

#pragma mark 展示下一页
-(void)autoShowNextImage
{
    if (_currentPage == _imageViewAry.count-1) {
        _currentPage = 0;
    }else{
        _currentPage ++;
    }
    
    [self reloadData];
}








@end
