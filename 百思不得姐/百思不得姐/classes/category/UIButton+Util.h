//
//  UIButton+Util.h
//  百思不得姐
//
//  Created by NUK on 16/9/5.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Util)
//创建按钮的便利方法
+ (UIButton *)createBtnTitle:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName hightlightImageName:(NSString *)hightlightImageName target:(id)target action:(SEL)action;
@end
