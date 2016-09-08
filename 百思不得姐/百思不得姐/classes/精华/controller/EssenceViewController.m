//
//  EssenceViewController.m
//  百思不得姐
//
//  Created by NUK on 16/9/5.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "EssenceViewController.h"
#import "EssenceTableViewController.h"
#import "MenuModel.h"
#import "NavTitleView.h"

@interface EssenceViewController ()<UIPageViewControllerDataSource>
/** 注释 */
@property (nonatomic ,strong)UIPageViewController *pageCtrl;
//
/** pageCtrl 管理的所有的视图控制器 */
@property (nonatomic ,strong)NSArray *vcArray;

@end

@implementation EssenceViewController
- (NSArray *)vcArray{
    if (nil == _vcArray){
        //推荐
        EssenceTableViewController *recommendCtrl = [[EssenceTableViewController alloc]init];
        //视频
        EssenceTableViewController *videoCtrl = [[EssenceTableViewController alloc]init];
        //图片
        EssenceTableViewController *picCtrl = [[EssenceTableViewController alloc]init];
        _vcArray = @[recommendCtrl,videoCtrl,picCtrl];
    }
    
    
    
    return _vcArray;
}

- (void)setSubModel:(SubMenuModel *)subModel{
    _subModel = subModel;
    //显示导航的界面标题列表;
    //navigationButtonRandom_26x26_
    //navigationButtonRandomClick_26x26_
    
    //review_post_nav_icon_20x17_
    //review_post_nav_icon_click_20x17_
    NSMutableArray *titles = [NSMutableArray array];
    for (NavTitleModel *tModel in subModel.submenus){
        [titles addObject:tModel.name];
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        NavTitleView *titleView = [[NavTitleView alloc]initWithTitles:titles rightImageName:@"navigationButtonRandom_26x26_" rightHightImageName:@"navigationButtonRandomClick_26x26_"];
        [weakSelf.view addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view).offset(20);
            make.left.right.equalTo(weakSelf.view);
            make.height.mas_equalTo(44);
        }];
    });
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //自定制一个导航栏
    //隐藏系统的导航条
    self.view.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1.0];
    self.navigationController.navigationBarHidden = YES;
    UIPageViewController *pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageCtrl = pageVC;
    //EssenceViewController *recommendCtrl = [[EssenceViewController alloc]init];
    pageVC.dataSource = self;
    
    EssenceTableViewController *recommentCtrl = [self.vcArray firstObject];
    [pageVC setViewControllers:@[recommentCtrl] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self.view addSubview:pageVC.view];
    __weak typeof(self) weakSelf = self;
    [pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    //pageVC.viewControllers = @[recommendCtrl,videoCtrl];
    //UIPageViewController
    
    
}

#pragma mark -UIpageviewctrl的代理
//返回某个视图控制器后面的视图控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger curIndex = [self.vcArray indexOfObject:viewController];
    if (curIndex < self.vcArray.count-1){
        EssenceTableViewController *nextCtrl = self.vcArray[curIndex+1];
        return nextCtrl;
    }
    return  nil;
}
//返回某个视图控制器前面的视图控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger curIndex = [self.vcArray indexOfObject:viewController];
    if (curIndex > 0){
        EssenceTableViewController *preCtrl = self.vcArray[curIndex-1];
        return preCtrl;
    }
    return  nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
