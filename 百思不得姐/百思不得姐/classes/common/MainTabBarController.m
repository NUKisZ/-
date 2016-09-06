//
//  MainTabBarController.m
//  百思不得姐
//
//  Created by NUK on 16/9/5.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "MainTabBarController.h"
#import "BDJTabBar.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UITabBar appearance].tintColor = [UIColor colorWithWhite:64.0/255.0 alpha:1.0];
    
    [self createViewControllers];
    
    //使用自定制tabBar
    [self setValue:[[BDJTabBar alloc]init] forKey:@"tabBar"];
    
}
//添加子视图控制器
/**
 

*/
- (void)addViewContrller:(NSString *)clsName title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName{
    
    
    Class cls = NSClassFromString(clsName);
    UIViewController *ctrl = [[cls alloc]init];
    //设置图片和文字
    ctrl.tabBarItem.title = title;
    ctrl.tabBarItem.image = [UIImage imageNamed:imageName];
    ctrl.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //ctrl.navigationItem.title = title;
    
    UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:ctrl];
    //添加子视图控制器的方式
    [self addChildViewController:navCtrl];
    
    
    
}
- (void)createViewControllers{
    
    //精华
    //EssenceViewController
    //tabBar_essence_icon
    [self addViewContrller:@"EssenceViewController" title:@"精华" imageName:@"tabBar_essence_icon" selectImageName:@"tabBar_essence_click_icon"];
    
    
    //最新
    //NewsViewController
    //tabBar_new_icon
    
    [self addViewContrller:@"NewsViewController" title:@"最新" imageName:@"tabBar_new_icon" selectImageName:@"tabBar_new_click_icon"];
    
    //关注
    //FollowViewController
    //tabBar_friendTrends_icon
    
    [self addViewContrller:@"FollowViewController" title:@"关注" imageName:@"tabBar_friendTrends_icon" selectImageName:@"tabBar_friendTrends_click_icon"];
    
    //我
    //ProfileViewController
    //tabBar_me_icon
    [self addViewContrller:@"ProfileViewController" title:@"我" imageName:@"tabBar_me_icon" selectImageName:@"tabBar_me_click_icon"];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
