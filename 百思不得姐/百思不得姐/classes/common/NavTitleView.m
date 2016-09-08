//
//  NavTitleView.m
//  百思不得姐
//
//  Created by NUK on 16/9/7.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "NavTitleView.h"
#import "UIButton+Util.h"





@implementation NavTitleView

- (instancetype)initWithTitles:(NSArray *)titles rightImageName:(NSString *)imageNmae rightHightImageName:(NSString *)hightlightImageName{
    
    if (self = [super init]){
        //左边的滚动视图
        
        
        //右边的按钮
        UIButton *rightBtn = [UIButton createBtnTitle:nil imageName:imageNmae selectImageName:nil hightlightImageName:hightlightImageName target:self action:@selector(clickRight)];
        [self addSubview:rightBtn];
        //约束
        __weak typeof(self)weakSelf = self;
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).offset(6);
            make.right.equalTo(weakSelf).offset(-20);
            make.size.mas_equalTo(CGSizeMake(40, 32));
        }];
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(weakSelf);
            make.left.equalTo(weakSelf).offset(20);
            make.right.equalTo(rightBtn.mas_left);
        }];
        
        //容器视图
        UIView *containerView = [[UIView alloc]init];
        [scrollView addSubview:containerView];
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
            make.height.equalTo(scrollView);
        }];
        //循环添加按钮
        //上一个添加按钮的视图
        UIView *lastView = nil;
        //按钮的宽度
        CGFloat width = 60;
        //两个按钮横向间距
        CGFloat spaceX = 20;
        
        for (int i = 0; i <titles.count;i++){
            NSString *title = titles[i];
            UIButton *btn = [UIButton createBtnTitle:title imageName:nil selectImageName:nil hightlightImageName:nil target:self action:@selector(clickTile:)];
            btn.tag = 300+i;
            [containerView addSubview:btn];
            //约束
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView);
                make.width.mas_equalTo(width);
                if (i==0){
                    make.left.equalTo(containerView);
                }else{
                    make.left.equalTo(lastView.mas_right).offset(spaceX);
                }
            }];
            lastView = btn;
        }
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastView.mas_right);
        }];
        
    }
    
    return self;
}
- (void)clickTile:(UIButton *)btn{
    //滚动视图上的按钮
    NSInteger index = btn.tag - 300;
    
}

- (void)clickRight{
    //点击右边的按钮
    
    
}


@end
