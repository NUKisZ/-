//
//  ProfileViewController.m
//  百思不得姐
//
//  Created by NUK on 16/9/5.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "ProfileViewController.h"
#import "MDButton.h"

@interface ProfileViewController ()<MDButtonDelegate>

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.btn = [[MDButton alloc]initWithFrame:CGRectMake(100, 200, 80, 40) type:MDButtonTypeFloatingAction rippleColor:[UIColor redColor]];
    self.btn.mdButtonDelegate = self;
    
    [self.view addSubview:self.btn];
}
- (void)rotationStarted:(id)sender{
    if (self.btn == sender){
        NSLog(@"==");
    }
}
- (void)rotationCompleted:(id)sender{
    if (self.btn == sender){
        NSLog(@"++");
    }
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
