//
//  BDJNavTitleViewController.h
//  百思不得姐
//
//  Created by NUK on 16/9/8.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "BaseViewController.h"

@class SubMenuModel;

@interface BDJNavTitleViewController : BaseViewController
@property (nonatomic ,strong)SubMenuModel *subModel;
/** 导航右边按钮的图片 */
@property (nonatomic ,copy)NSString *rightImageName;
/**  */
@property (nonatomic ,copy)NSString *rightSelectImageName;
/** 判断视图是否显示 */
@property (nonatomic ,assign)BOOL viewShowed;
- (void)showData;
@end
