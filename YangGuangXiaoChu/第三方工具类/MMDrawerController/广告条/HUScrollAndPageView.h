//
//  HUScrollAndPageView.h
//  test
//
//  Created by imac on 15/9/27.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUScrollAndPageView : UIView

{
    __unsafe_unretained id  _delegate;
}

@property (nonatomic, assign) id  delegate;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *imageViewAry;

@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, readonly) UIPageControl *pageControl;


//是否开启自动变换
-(void)shouldAutoShow:(BOOL)shouldStart;

@end


@protocol HUcrollViewViewDelegate

@optional
- (void)didClickPage:(HUScrollAndPageView *)view atIndex:(NSInteger)index;

@end





