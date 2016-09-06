//
//  BDJDownloader.h
//  百思不得姐
//
//  Created by NUK on 16/9/5.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FINISHBLOCK)(NSData *data);
typedef void (^FAILBLOCK) (NSError *error);

@interface BDJDownloader : NSObject


//GET请求下载
//- (void)downloadWithUrlString:(NSString *)urlString finish:(void (^)(NSData *data))finishBlock failure:(void(^)(NSError *error))failBlock;
+ (void)downloadWithUrlString:(NSString *)urlString finish:(FINISHBLOCK)finishBlock failure:(FAILBLOCK)failBlock;
@end
