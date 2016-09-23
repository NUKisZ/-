//
//  EssenceVideoCell.m
//  百思不得姐
//
//  Created by NUK on 16/9/6.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "EssenceGifCell.h"
#import "EssenceModel.h"

@interface EssenceGifCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;


@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIView *tagView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (weak, nonatomic) IBOutlet UIButton *hateButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
//图片的高度

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bigImageViewHCon;

//comment的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewHCon;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewYCon;



@end




@implementation EssenceGifCell

- (IBAction)favoriteButtonAction:(id)sender {
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
    NSString *picName = [model.gif.images firstObject];
    
    
    self.bigImageView.contentMode = UIViewContentModeTop;
    self.bigImageView.layer.masksToBounds = YES;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:picName]];
    
    
    
    CGFloat h =self.bigImageView.frame.size.width * model.gif.height / model.gif.width;
    if (h>300){
        h = 300;
    }
    self.bigImageViewHCon.constant = h;
    
    //热评
    
    //修改背景视图的显示状态和高度
    if (model.top_comment == nil) {
        //隐藏
        self.commentView.hidden = YES;
        
    }else{
        
        //显示 (因为cell重用可能隐藏了评论)
        self.commentView.hidden = NO;
        
        NSString *commentStr = [NSString stringWithFormat:@"%@:%@",model.top_comment.u.name, model.top_comment.content];
        self.commentLabel.text = commentStr;
        
    }
    
    
    
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
