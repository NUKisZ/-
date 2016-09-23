//
//  NewsViewController.m
//  百思不得姐
//
//  Created by NUK on 16/9/5.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

//这个方法是用来初始化self.view
//- (void)loadView{
//    [super loadView];
//    self.rightImageName = @"review_post_nav_icon_20x17_";
//    self.rightSelectImageName = @"review_post_nav_icon_click_20x17_";
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightImageName = @"review_post_nav_icon_20x17_";
    self.rightSelectImageName = @"review_post_nav_icon_click_20x17_";
    //显示导航标题数据
    if (self.subModel) {
        [self showData];
    }
    //review_post_nav_icon_20x17_
    //review_post_nav_icon_click_20x17_
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
