//
//  More2ViewController.m
//  YangGuangXiaoChu
//
//  Created by imac on 15/10/4.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "More2ViewController.h"
#import "CollectionReusableView.h"
@interface More2ViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    UIView *_slideView;//滑动的view
    
    UIView *testView;
    
    NSArray *_shiPuData;
    NSArray *_shiCaiData;
}


@end

@implementation More2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//
    self.automaticallyAdjustsScrollViewInsets = NO;
//
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, _scrollView.height);
    
    //初始化中间标题视图
    [self _initTitleView];
    [self _initTabelView];
    [self loadHotData];
    [self loadNewData];
}

- (void)_initTitleView
{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 60)];
    [leftBtn addTarget:self action:@selector(fanHuiItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    testView = [[[NSBundle mainBundle] loadNibNamed:@"TitleView" owner:nil options:nil] lastObject];

    self.navigationItem.titleView = testView;
    
    UIButton *btn1 = (UIButton *)[testView viewWithTag:200];
    UIButton *btn2 = (UIButton *)[testView viewWithTag:201];
    [btn1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    _slideView = (UIView *)[testView viewWithTag:202];
    
    
    if (self.titleArr) {
        [btn1 setTitle:self.titleArr[0] forState:UIControlStateNormal];
        [btn2 setTitle:self.titleArr[1] forState:UIControlStateNormal];
    }
    
    
}

- (void)btnAction:(UIButton *)btn
{
    [_scrollView setContentOffset:CGPointMake((btn.tag - 200) * kScreenWidth, 0) animated:YES];

}

#pragma mark  scrollView滑动时触动的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        return;
    }

    UIButton *btn1 = (UIButton *)[testView viewWithTag:200];
    UIButton *btn2 = (UIButton *)[testView viewWithTag:201];
    
    CGFloat x = (scrollView.contentOffset.x / kScreenWidth) * (btn2.left - btn1.left);
    _slideView.right = btn1.right + x;

}




//#pragma mark 构造UITableView
- (void)_initTabelView
{

    for (int i = 0; i < 2; i++) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((kScreenWidth - 60)/4, 40);
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.headerReferenceSize = CGSizeMake(40, 40);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
        collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        collectionView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:collectionView];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.tag = 600 + i;
        //注册单元格
        collectionView.bounces = NO;
        [collectionView registerNib:[UINib nibWithNibName:@"more" bundle:nil] forCellWithReuseIdentifier:@"moreCell"] ;
        
        [collectionView registerNib:[UINib nibWithNibName:@"CollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
    }
    
    
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 15, 5, 15);//分别为上、左、下、右
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        CollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        
        if (collectionView.tag == 600) {
            NSDictionary *dic = _shiPuData[indexPath.section];
            headerView.label.text = [dic objectForKey:@"text"];
        }else if(collectionView.tag == 601){
            NSDictionary *dic = _shiCaiData[indexPath.section];
            headerView.label.text = [dic objectForKey:@"text"];
        }
        
        
        
        reusableview = headerView;
        
    }
    
    return reusableview;
    
    
    
}



//定义单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    if (collectionView.tag == 600) {
        NSDictionary *dic = _shiPuData[section];
        NSArray *arr = [dic objectForKey:@"data"];

        return arr.count;
    }else if(collectionView.tag == 601){
        
        NSDictionary *dic = _shiCaiData[section];
        NSArray *arr = [dic objectForKey:@"data"];
        return arr.count;
        
    }

    return 0;
}
//定义组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    if (collectionView.tag == 600) {
        return _shiPuData.count;
    }else if(collectionView.tag == 601){
        return _shiCaiData.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"moreCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 3;
    cell.layer.borderWidth = 1;
    
    
    if (indexPath.section % 2 != 0) {
        cell.layer.borderColor = [UIColor orangeColor].CGColor;
    }else{
        cell.layer.borderColor = [UIColor greenColor].CGColor;
    }
    
    UILabel *label = (UILabel *)[cell viewWithTag:1234];


    if (collectionView.tag == 600) {
        
        NSDictionary *dic = _shiPuData[indexPath.section];
        NSArray *arr = [dic objectForKey:@"data"];
        label.text = [arr[indexPath.row] objectForKey:@"text"];
        
    }else if(collectionView.tag == 601){
        NSDictionary *dic = _shiCaiData[indexPath.section];
        NSArray *arr = [dic objectForKey:@"data"];
        label.text = [arr[indexPath.row] objectForKey:@"text"];
    }
    
    
    return cell;
    
}



#pragma mark 加载热门数据
- (void)loadHotData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"CategoryIndex" forKey:@"methodName"];
    
    [params setObject:@"4.01" forKey:@"version"];
    [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
        
        
        _shiPuData = [[data objectForKey:@"data"] objectForKey:@"data"];
        
        UICollectionView *collcetionView = (UICollectionView *)[_scrollView viewWithTag:600];
         
         
         
         [collcetionView reloadData];
    }];
}



#pragma mark 加载新品数据
- (void)loadNewData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"MaterialSubtype" forKey:@"methodName"];
    [params setObject:@2 forKey:@"type"];
    [DataService requestURL:@"http://api.izhangchu.com/" Params:params Method:@"POST" Block:^(id data) {
        
        [params setObject:@"4.01" forKey:@"version"];
        
        NSArray *arr = [[data objectForKey:@"data"] objectForKey:@"data"];
        _shiCaiData = arr;
        
        UICollectionView *collcetionView = (UICollectionView *)[_scrollView viewWithTag:601];
        
        
        
        [collcetionView reloadData];
        
    }];
    
}


- (void)fanHuiItemAction:(UIBarButtonItem *)item
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"coll" object:nil];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
//    self.navigationController.navigationBarHidden = NO;
    UICollectionView *tableView1 = (UICollectionView *)[_scrollView viewWithTag:500];
    
    [tableView1 reloadData];
    UICollectionView *tableView2 = (UICollectionView *)[_scrollView viewWithTag:501];
    
    [tableView2 reloadData];
    
}
#pragma mark 单元格被点击时触发的事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (collectionView.tag == 600) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        BtnBaseViewController *btnVC = [storyBoard instantiateViewControllerWithIdentifier:@"btnVC"];
        btnVC.params = @"CategorySearch";
        
        NSDictionary *dic = _shiPuData[indexPath.section];
        NSArray *arr = [dic objectForKey:@"data"];
        
        
        btnVC.navTitle =[arr[indexPath.row] objectForKey:@"text"];
        btnVC.cat_id = [NSString stringWithFormat:@"%@",[arr[indexPath.row] objectForKey:@"id"]];
        [self.navigationController pushViewController:btnVC animated:YES];

    }
}


@end
