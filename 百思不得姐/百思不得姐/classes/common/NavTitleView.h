//
//  NavTitleView.h
//  百思不得姐
//
//  Created by NUK on 16/9/7.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NavTitleView;
@protocol NavTitleViewDelegate <NSObject>

//点击滚动视图上的按钮

- (void)navTitleView:(NavTitleView *)navTitleView didClickBtnAtIndex:(NSInteger)index withURLString:(NSString *)urlString;
//点击右边的按钮
- (void)didClickRightButton:(NavTitleView *)navTitleView;



@end




@interface NavTitleView : UIView

//重新实现初始化的方法

/*
 titles左边滚动视图上面的标题
 imageNmae右边按钮上的图片
 */
- (instancetype)initWithTitles:(NSArray *)titleModels rightImageName:(NSString *)imageNmae rightHightImageName:(NSString *)hightlightImageName;


/** 代理 */
@property (nonatomic ,weak)id<NavTitleViewDelegate> delegate;

/** 选中按钮的序号 */
@property (nonatomic ,assign)NSInteger selectedIndex;

@end
