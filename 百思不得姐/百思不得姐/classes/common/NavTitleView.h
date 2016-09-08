//
//  NavTitleView.h
//  百思不得姐
//
//  Created by NUK on 16/9/7.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NavTitleViewDelegate <NSObject>

//点击滚动视图上的按钮



//点击右边的按钮

@end

@interface NavTitleView : UIView

//重新实现初始化的方法

/*
 titles左边滚动视图上面的标题
 imageNmae右边按钮上的图片
 */
- (instancetype)initWithTitles:(NSArray *)titles rightImageName:(NSString *)imageNmae rightHightImageName:(NSString *)hightlightImageName;

@end
