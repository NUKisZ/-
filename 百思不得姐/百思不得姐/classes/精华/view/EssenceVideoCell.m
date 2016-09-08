//
//  EssenceVideoCell.m
//  百思不得姐
//
//  Created by NUK on 16/9/6.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "EssenceVideoCell.h"
#import "EssenceModel.h"

@interface EssenceVideoCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videlImageView;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playNumLabel;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (weak, nonatomic) IBOutlet UIButton *hateButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
//图片的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoImageHCon;
//comment的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewHCon;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewYCon;



@end




@implementation EssenceVideoCell

- (IBAction)favoriteButtonAction:(id)sender {
}
- (IBAction)videoPlayButton:(id)sender {
}
- (IBAction)loveButtonAction:(id)sender {
}
- (IBAction)hateButtonAction:(id)sender {
}
- (IBAction)shareButtonAction:(id)sender {
}
- (IBAction)commentButtonAction:(id)sender {
}

- (void)setModel:(ListModel *)model{
    _model = model;
    self.userImageView.layer.cornerRadius = 15;
    self.userImageView.layer.masksToBounds = YES;
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[model.u.header firstObject]]];
    self.nameLabel.text = model.u.name;
    self.descLabel.text = model.passtime;
    self.contentLabel.text = model.text;
    //视频的图片
    NSString *picName = [model.video.thumbnail_small firstObject];
    [self.videlImageView sd_setImageWithURL:[NSURL URLWithString:picName]];
    //视频图片
    self.videoImageHCon.constant = self.videlImageView.size.width*model.video.height/model.video.width;
    
    
    //播放的次数
    
    self.playNumLabel.text = [NSString stringWithFormat:@"%ld播放",model.video.playcount];
    
    //视频时长
    NSMutableString *timeStr = [NSMutableString string];
    NSInteger duration = model.video.duration;
    //小时
    if (duration > 3600){
        [timeStr appendFormat:@"%02ld:",duration/3600 ];
        duration = duration/3600;
    }
    //分钟
    if (duration > 60){
        [timeStr appendFormat:@"%02ld:",duration/60];
        duration = duration/60;
    }
    [timeStr appendFormat:@"%02ld",duration];
    self.playTimeLabel.text = timeStr;
    
    //热评
    
    
    
    
    
    //标签
    NSMutableString *tagStr = [NSMutableString string];
    for (TagModel *tag in model.tags){
        [tagStr appendFormat:@"%@ ",tag.name];
        
    }
    self.tagLabel.text = tagStr;
    
    //顶一下
    [self.loveButton setTitle:model.up forState:UIControlStateNormal];
    [self.loveButton setTitle:model.up forState:UIControlStateSelected];
    
    //踩一下
    [self.hateButton setTitle:[NSString stringWithFormat:@"%ld",model.down] forState:UIControlStateNormal];
    [self.loveButton setTitle:[NSString stringWithFormat:@"%ld",model.down] forState:UIControlStateSelected];
    
    //分享
    [self.shareButton setTitle:[NSString stringWithFormat:@"%ld",model.forward] forState:UIControlStateNormal];
    [self.shareButton setTitle:[NSString stringWithFormat:@"%ld",model.forward] forState:UIControlStateSelected];
    
    //评论
    [self.commentButton setTitle:model.comment forState:UIControlStateNormal];
    [self.commentButton setTitle:model.comment forState:UIControlStateSelected];
    
    //强制刷新cell,也就是按照数据全部显示一次.
    [self layoutIfNeeded];
    
    //修改背景视图的显示状态
    if (model.top_comment == nil){
        //隐藏
        self.commentView.hidden = YES;
        self.commentViewHCon.constant = 0;
        self.commentViewYCon.constant = 0;
    }else{
        //显示
        self.commentViewYCon.constant = 14;
        self.commentViewHCon.constant = self.commentLabel.height+8;
    }
    
    //强制刷新cell,也就是按照数据全部显示一次.
    [self layoutIfNeeded];

    _model.cellHeight = @((CGFloat)CGRectGetMaxY(self.commentButton.frame)+10);
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
