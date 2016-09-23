//
//  NavTitleView.m
//  百思不得姐
//
//  Created by NUK on 16/9/7.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "NavTitleView.h"
#import "UIButton+Util.h"
#import "MenuModel.h"



@interface NavTitleView ()
/** 所有按钮对应的对象 */
@property (nonatomic ,strong)NSArray *titleModels;
/** 选中下面的红线 */
@property (nonatomic ,strong)UIView *lineView;
/** 滚动视图里面的容器视图 */
@property (nonatomic ,strong)UIView *containerView;

@end

@implementation NavTitleView
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    
    if (_selectedIndex != selectedIndex){
        //取消选中之前的按钮
        UIButton *lastBtn = [self.containerView viewWithTag:300+_selectedIndex];
        lastBtn.selected = NO;
        
        //选中当前的按钮
        UIButton *curBtn = [self.containerView viewWithTag:300+selectedIndex];
        curBtn.selected = YES;
        //修改下划线的位置
        CGFloat btnW = self.btnWidth;
        CGFloat spaceX = self.btnSpaceX;
        [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            CGFloat x=(btnW+spaceX)*selectedIndex;
            make.left.mas_equalTo(x);
        }];
        //修改滚动视图的contentOffset的值
        //默认将当前的选中按钮居中
        UIScrollView *scrollView = (UIScrollView *)self.containerView.superview;
        CGFloat offsetX = curBtn.centerX - scrollView.centerX;
        
        //如果contentOffset超出了滚动视图的左边,就显示到最左边
        if (offsetX<0){
            offsetX = 0;
        }
        ////如果contentOffset超出了滚动视图的右边,就显示到最右边
        
        if (offsetX > (scrollView.contentSize.width - scrollView.bounds.size.width)){
            offsetX = scrollView.contentSize.width - scrollView.bounds.size.width;
        }
        
        //scrollView.contentOffset = CGPointMake(offsetX, 0);
        [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    _selectedIndex = selectedIndex;
}

- (instancetype)initWithTitles:(NSArray *)titleModels rightImageName:(NSString *)imageNmae rightHightImageName:(NSString *)hightlightImageName{
    
    
    
    if (self = [super init]){
        
        if (titleModels.count > 0){
            //左边的滚动视图
            self.titleModels = titleModels;
            //右边的按钮
            UIButton *rightBtn = [UIButton createBtnTitle:nil imageName:imageNmae selectImageName:nil hightlightImageName:hightlightImageName target:self action:@selector(clickRight)];
            [self addSubview:rightBtn];
            //约束
            __weak typeof(self)weakSelf = self;
            [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf).offset(6);
                make.right.equalTo(weakSelf).offset(-20);
                make.size.mas_equalTo(CGSizeMake(30, 30));
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
            CGFloat width = self.btnWidth;
            //两个按钮横向间距
            CGFloat spaceX = self.btnSpaceX;
            
            for (int i = 0; i <titleModels.count;i++){
                NavTitleModel *model = titleModels[i];
                NSString *title = model.name;
                UIButton *btn = [UIButton createBtnTitle:title imageName:nil selectImageName:nil hightlightImageName:nil target:self action:@selector(clickTile:)];
                btn.tag = 300+i;
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                [containerView addSubview:btn];
                if (i==0){
                    btn.selected = YES;
                    
                }
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
            //添加下面的红线;
            self.lineView = [[UIView alloc]init];
            self.lineView.backgroundColor = [UIColor redColor];
            [containerView addSubview:self.lineView];
            self.containerView = containerView;
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(2);
                make.bottom.equalTo(containerView);
            }];
        }
        
        
        
        
        
        
        
    }
    
    return self;
}
///获取按钮的宽度

- (CGFloat)btnWidth{
    return 60;
}

//获取按钮之间横向间距的间距
- (CGFloat)btnSpaceX{
    return 20;
}

- (void)clickTile:(UIButton *)btn{
    //滚动视图上的按钮
    NSInteger index = btn.tag - 300;
    if (self.selectedIndex != index){
        self.selectedIndex = index;
        NavTitleModel *model = self.titleModels[index];
        [self.delegate navTitleView:self didClickBtnAtIndex:index withURLString:model.url];
    }
    
    
    
}

- (void)clickRight{
    //点击右边的按钮
    [self.delegate didClickRightButton:self];
    
}


@end
