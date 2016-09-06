//
//  UIButton+Util.m
//  百思不得姐
//
//  Created by NUK on 16/9/5.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "UIButton+Util.h"

@implementation UIButton (Util)
+ (UIButton *)createBtnTitle:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName hightlightImageName:(NSString *)hightlightImageName target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title!=nil){
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (imageName != nil){
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (selectImageName != nil){
        [btn setBackgroundImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
        
    }
    if (hightlightImageName != nil){
        [btn setBackgroundImage:[UIImage imageNamed:hightlightImageName] forState:UIControlStateHighlighted];
    }
    if (target && action){
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    
    return btn;
}
@end
