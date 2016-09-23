//
//  EssenceTableViewController.h
//  百思不得姐
//
//  Created by NUK on 16/9/7.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol EssenceTableViewControllerDelegate <NSObject>

- (void)didPlayVideoWithUrlString:(NSString *)videoString;

@end
@interface EssenceTableViewController : UIViewController
/** 网络请求的前缀 */
@property (nonatomic ,copy)NSString *urlPrefix;
@property (nonatomic ,weak)id<EssenceTableViewControllerDelegate> delegate;

@end
