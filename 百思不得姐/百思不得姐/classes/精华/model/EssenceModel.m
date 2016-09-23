//
//  EssenceModel.m
//  百思不得姐
//
//  Created by NUK on 16/9/5.
//  Copyright © 2016年 NUK. All rights reserved.
//

#import "EssenceModel.h"

@implementation EssenceModel

@end

@implementation InfoModel

@end

@implementation ListModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"listId"}];
}

@end

@implementation CommentModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"commentId"}];
}

@end

@implementation TagModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"tagId"}];
}

@end

@implementation UserModel

@end

@implementation VideoModel

@end
@implementation ImageModel

@end
@implementation GifModel

@end
@implementation AudioModel
@end

