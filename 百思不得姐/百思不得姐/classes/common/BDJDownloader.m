//
//  BDJDownloader.m
//  百思不得姐
//
//  Created by NUK on 16/9/5.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "BDJDownloader.h"

@implementation BDJDownloader


+ (void)downloadWithUrlString:(NSString *)urlString finish:(FINISHBLOCK)finishBlock failure:(FAILBLOCK)failBlock{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil){
            failBlock(error);
        }else{
            NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
            if (httpRes.statusCode == 200){
                finishBlock(data);
            }else{
                NSError *tmpError = [NSError errorWithDomain:urlString code:httpRes.statusCode userInfo:@{@"msg":@"请求数据失败"}];
                failBlock(tmpError);
            }
            
        }
        
    }];
    [task resume];
}


@end
