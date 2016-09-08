//
//  EssenceTableViewController.m
//  百思不得姐
//
//  Created by NUK on 16/9/7.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "EssenceTableViewController.h"
#import "EssenceModel.h"
#import "EssenceVideoCell.h"
@interface EssenceTableViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 分页 */
@property (nonatomic ,assign)NSInteger lastTime;
/** 表格 */
@property (nonatomic ,strong)UITableView *tbView;

@property (nonatomic ,strong)EssenceModel *dataModel;

@end

@implementation EssenceTableViewController

- (void)createTabBleView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tbView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    self.tbView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:self.tbView];
    __weak typeof(self) weakSelf = self;
    [self.tbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);//.with.insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
    //下拉刷新
    //上拉加载更多
    self.tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstPate)];
    self.tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMOre)];
    
}
- (void)loadFirstPate{
    self.lastTime = 0;
    [self downloadData];
    
}
- (void)loadMOre{
    self.lastTime = self.dataModel.info.np;
    [self downloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //自定制一个导航栏
    //隐藏系统的导航条
    self.navigationController.navigationBarHidden = YES;
    //UIPageViewController
    [self downloadData];
    [self createTabBleView];
}
- (void)downloadData{
    NSString *urlString = [NSString stringWithFormat:kEVidelUrl,self.lastTime];
    __weak typeof(self) weakSelf = self;
    [BDJDownloader downloadWithUrlString:urlString finish:^(NSData *data) {
        
        EssenceModel *model = [[EssenceModel alloc] initWithData:data error:nil];
        
        
        if (self.lastTime == 0){
            weakSelf.dataModel = model;
        }else{
            
            //这样写也是可以的
            //            NSMutableArray *listArray = [NSMutableArray arrayWithArray: weakSelf.dataModel.list];
            //            [listArray addObject:model.list];
            //
            //
            //
            //            //model.list = (NSArray<Optional,ListModel> *)[NSArray arrayWithArray:listArray];
            //            weakSelf.dataModel = model;
            
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, weakSelf.dataModel.list.count)];
            [model.list insertObjects:weakSelf.dataModel.list atIndexes:indexSet];
            weakSelf.dataModel.list = model.list;
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tbView reloadData];
            [weakSelf.tbView.mj_footer endRefreshing];
            [weakSelf.tbView.mj_header endRefreshing];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}

#pragma mark tabBleViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"videoCellId";
    EssenceVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EssenceVideoCell" owner:nil options:nil]lastObject];
    }
    cell.model = self.dataModel.list[indexPath.row];
    return  cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListModel *model = self.dataModel.list[indexPath.row];
    
    return model.cellHeight.floatValue;
}
//estimated预估cell的高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 600;
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
