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
#import "EssenceTextCell.h"
#import "EssenceImageCell.h"
#import "EssenceAudioCell.h"
#import "EssenceGifCell.h"
#import "MoviePlayerViewController.h"
@interface EssenceTableViewController ()<UITableViewDelegate,UITableViewDataSource,EssenceVideoCellDelegate>
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
//图片cell
- (UITableViewCell *)createImageCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    [[SDImageCache sharedImageCache] clearMemory];
    static NSString *cellId = @"imageCellId";
    EssenceImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EssenceImageCell" owner:nil options:nil]lastObject];
    }
    ListModel *model = self.dataModel.list[indexPath.row];
    cell.model = model;
    return cell;
}
//声音cell
- (UITableViewCell *)createVoiceCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    [[SDImageCache sharedImageCache] clearMemory];
    static NSString *cellId = @"audioCellId";
    EssenceAudioCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EssenceAudioCell" owner:nil options:nil]lastObject];
    }
    ListModel *model = self.dataModel.list[indexPath.row];
    cell.model = model;
    return cell;
}
//文字cell
- (UITableViewCell *)createTextCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    [[SDImageCache sharedImageCache] clearMemory];
    static NSString *cellId = @"textCellId";
    EssenceTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EssenceTextCell" owner:nil options:nil]lastObject];
    }
    ListModel *model = self.dataModel.list[indexPath.row];
    cell.model = model;
    return cell;
    
}
//gifcell
- (UITableViewCell *)createGifCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    [[SDImageCache sharedImageCache] clearMemory];
    static NSString *cellId = @"gifCellId";
    EssenceGifCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EssenceGifCell" owner:nil options:nil]lastObject];
    }
    ListModel *model = self.dataModel.list[indexPath.row];
    cell.model = model;
    return cell;
}
//html
- (UITableViewCell *)createHtmlCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc]init];
}

//视频cell
- (UITableViewCell *)createVideoCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    [[SDImageCache sharedImageCache] clearMemory];
    static NSString *cellId = @"videoCellId";
    EssenceVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EssenceVideoCell" owner:nil options:nil]lastObject];
    }
    cell.delegate = self;
    cell.model = self.dataModel.list[indexPath.row];
    return  cell;

}
- (void)didSelectorVideoWithUrl:(NSString *)videoString{
    [self.delegate didPlayVideoWithUrlString:videoString];
//    MoviePlayerViewController *movieCtrl = [[MoviePlayerViewController alloc]init];
//    movieCtrl.videoString = videoString;
//    [self presentViewController:movieCtrl animated:YES completion:nil];
    
    
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
    NSMutableString *urlString = [NSMutableString stringWithString:self.urlPrefix];
    
    [urlString appendFormat:kEssenceSuffixUrl,self.lastTime];
    
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
            weakSelf.dataModel = model;
            
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
    UITableViewCell *cell = nil;
    ListModel *model = self.dataModel.list[indexPath.row];
    if ([model.type isEqualToString:@"video"]){
        cell = [self createVideoCellForTableView:tableView atIndexPath:indexPath];
    }else if ([model.type isEqualToString:@"image"]){
        cell = [self createImageCellForTableView:tableView atIndexPath:indexPath];
    }else if ([model.type isEqualToString:@"gif"]){
        cell = [self createGifCellForTableView:tableView atIndexPath:indexPath];
    }else if ([model.type isEqualToString:@"text"]){
        cell = [self createTextCellForTableView:tableView atIndexPath:indexPath];
    }else if ([model.type isEqualToString:@"html"]){
        cell = [self createHtmlCellForTableView:tableView atIndexPath:indexPath];
    }else if ([model.type isEqualToString:@"audio"]){
        cell = [self createVoiceCellForTableView:tableView atIndexPath:indexPath];
    }
    else{
        cell = [[UITableViewCell alloc]init];
    }
    return cell;
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
