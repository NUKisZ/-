//
//  EssenceViewController.m
//  百思不得姐
//
//  Created by NUK on 16/9/5.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "EssenceViewController.h"
#import "EssenceModel.h"

@interface EssenceViewController ()
/** 分页 */
@property (nonatomic ,assign)NSInteger lastTime;

@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self downloadData];
}
- (void)downloadData{
    NSString *urlString = [NSString stringWithFormat:kERecommendUrl,self.lastTime];
    [BDJDownloader downloadWithUrlString:urlString finish:^(NSData *data) {
        EssenceModel *model = [[EssenceModel alloc] initWithData:data error:nil];
        NSLog(@"=====");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
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
