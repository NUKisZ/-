
//
//  BDJNavTitleViewController.m
//  百思不得姐
//
//  Created by NUK on 16/9/8.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "BDJNavTitleViewController.h"
#import "EssenceTableViewController.h"
#import "MenuModel.h"
#import "NavTitleView.h"
#import "MoviePlayerViewController.h"
@interface BDJNavTitleViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,NavTitleViewDelegate,EssenceTableViewControllerDelegate>
/** 注释 */
@property (nonatomic ,strong)UIPageViewController *pageCtrl;
//
/** pageCtrl 管理的所有的视图控制器 */
@property (nonatomic ,strong)NSArray *vcArray;

/** 导航的标题视图 */
@property (nonatomic ,strong)NavTitleView  *titleView;

@end

@implementation BDJNavTitleViewController

- (void)loadView{
    [super loadView];
    self.viewShowed = YES;
}


- (NSArray *)vcArray{
    if (nil == _vcArray){
        NSMutableArray *array = [NSMutableArray array];
        for (int i=0;i<self.subModel.submenus.count ;i++){
            //推荐
            //视频
            //图片
            //...
            EssenceTableViewController *essenceSubCtrl = [[EssenceTableViewController alloc]init];
            essenceSubCtrl.delegate = self;
            NavTitleModel *model = self.subModel.submenus[i];
            if ([model.url hasSuffix:@"/"]){
                essenceSubCtrl.urlPrefix = model.url;
            }else {
                essenceSubCtrl.urlPrefix = [NSString stringWithFormat:@"%@/",model.url];
            }
            
            [array addObject:essenceSubCtrl];
        }
        
        
        _vcArray = [NSArray arrayWithArray:array];
    }
    
    
    
    return _vcArray;
}
- (void)didPlayVideoWithUrlString:(NSString *)videoString{
        MoviePlayerViewController *movieCtrl = [[MoviePlayerViewController alloc]init];
        movieCtrl.videoString = videoString;
        [self presentViewController:movieCtrl animated:YES completion:nil];

}

- (void)setSubModel:(SubMenuModel *)subModel{
    _subModel = subModel;

    if (self.viewShowed){
        [self showData];
    }
    
    
}
- (void)showData{
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        NavTitleView *titleView = [[NavTitleView alloc]initWithTitles:self.subModel.submenus rightImageName:self.rightImageName rightHightImageName:self.rightSelectImageName];
        [weakSelf.view addSubview:titleView];
        
        weakSelf.titleView = titleView;
        
        titleView.delegate = weakSelf;
        
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view).offset(20);
            make.left.right.equalTo(weakSelf.view);
            make.height.mas_equalTo(44);
        }];
    });
    
    //创建pageController
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf createPageCtrl];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //自定制一个导航栏
    //隐藏系统的导航条
    self.view.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1.0];
    
    
    //pageVC.viewControllers = @[recommendCtrl,videoCtrl];
    //UIPageViewController
    
    
}
- (void)createPageCtrl{
    self.navigationController.navigationBarHidden = YES;
    UIPageViewController *pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageCtrl = pageVC;
    //EssenceViewController *recommendCtrl = [[EssenceViewController alloc]init];
    pageVC.dataSource = self;
    pageVC.delegate = self;
    
    EssenceTableViewController *recommentCtrl = [self.vcArray firstObject];
    [pageVC setViewControllers:@[recommentCtrl] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self.view addSubview:pageVC.view];
    __weak typeof(self) weakSelf = self;
    [pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
}

#pragma mark -UIpageviewctrl的代理
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    //获取当前显示的序号
    UIViewController *vCtrl = [pageViewController.viewControllers lastObject];
    NSInteger index = [self.vcArray indexOfObject:vCtrl];
    self.titleView.selectedIndex = index;
    
}
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


#pragma mark NavTitleView代理
- (void)didClickRightButton:(NavTitleView *)navTitleView{
    NSLog(@"%s",__FUNCTION__);
}
- (void)navTitleView:(NavTitleView *)navTitleView didClickBtnAtIndex:(NSInteger)index withURLString:(NSString *)urlString{
    
    UIViewController *toVCtrl = self.vcArray[index];
    UIViewController *curCtrl = [self.pageCtrl.viewControllers lastObject];
    NSInteger lastIndex = [self.vcArray indexOfObject:curCtrl];
    
    UIPageViewControllerNavigationDirection dir = UIPageViewControllerNavigationDirectionForward;
    if (index < lastIndex){
        dir = UIPageViewControllerNavigationDirectionReverse;
    }else{
        dir = UIPageViewControllerNavigationDirectionForward;
    }
    //从右向左
    [self.pageCtrl setViewControllers:@[toVCtrl ] direction:dir animated:YES completion:nil];
    //UIPageViewControllerNavigationDirectionReverse
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
