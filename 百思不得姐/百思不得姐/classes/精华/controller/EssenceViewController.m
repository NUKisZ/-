//
//  EssenceViewController.m
//  百思不得姐
//
//  Created by NUK on 16/9/5.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "EssenceViewController.h"


@interface EssenceViewController ()

@end

@implementation EssenceViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.rightImageName = @"navigationButtonRandom_26x26_";
    self.rightSelectImageName = @"navigationButtonRandomClick_26x26_";
    if (self.subModel){
        [self showData];
    }
    
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
