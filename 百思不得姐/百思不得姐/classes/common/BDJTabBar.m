//
//  BDJTabBar.m
//  百思不得姐
//
//  Created by NUK on 16/9/5.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "BDJTabBar.h"
#import "UIButton+Util.h"

@implementation BDJTabBar

- (instancetype)init{
    if (self = [super init]){
        //创建添加按钮
        UIButton *btn = [UIButton createBtnTitle:nil imageName:@"tabBar_publish_icon" selectImageName:@"tabBar_publish_click_icon" hightlightImageName:@"tabBar_publish_click_icon" target:self action:@selector(publishAction)];
        [self addSubview:btn];
        
        //设置约束
        
        
    }
    return self;
}

- (void)publishAction{
    
    
}
//这个方法是用来给视图重新布局的
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //修改约束
    CGFloat btnW = kScreenWidth/5;
    //__block是为是在闭包里面能使用
    __block int index = 0;
    for (UIView *subView in self.subviews){
        if ([subView isKindOfClass:[UIControl class]]){
            //更新原来 的约束
            [subView mas_updateConstraints:^(MASConstraintMaker *make) {
                //make.left.equalTo(btnW*1);
                
                //修改序号
                if ([subView isKindOfClass:[UIButton class]]){
                    
                    CGFloat offsetX = kScreenWidth/2 - 40/2;
                    
                    subView.frame = CGRectMake(offsetX, 4, 40, 40);
                    
                }else{
                    //默认的tabBarItem的按钮
                    
                    if (index>1){
                        subView.x = btnW*(index+1);
                        
                        
                    }else{
                        subView.x = btnW*index;
                    }

                    //修改宽度
                    subView.width=btnW;
                    index++;
                }
                
                
            }];
            
        }
    }
    /*
     if ([subView isKindOfClass:[UIColor class]]){
     //更新原来 的约束
     [subView mas_updateConstraints:^(MASConstraintMaker *make) {
     //make.left.equalTo(btnW*1);
     
     //修改序号
     if ([subView isKindOfClass:[UIButton class]]){
     make.left.mas_equalTo(btnW*2);
     make.top.mas_equalTo(4);
     make.size.mas_equalTo(CGSizeMake(40, 40));
     }else{
     //默认的tabBarItem的按钮
     if (index>1){
     make.left.mas_equalTo(btnW*(index+1));
     }else{
     make.left.mas_equalTo(btnW*index);
     }
     
     index++;
     }
     
     
     }];
     
     //1.创建新的约束 并添加
     //subView mas_makeConstraints:<#^(MASConstraintMaker *make)block#>
     //2.重新创建约束,同时删除之前的约束
     // subView mas_remakeConstraints:<#^(MASConstraintMaker *make)block#>
     //3.更新约束 ,同时保留之前的约束
     //subView mas_updateConstraints:<#^(MASConstraintMaker *make)block#>
     }

     */
    
    
}

@end
