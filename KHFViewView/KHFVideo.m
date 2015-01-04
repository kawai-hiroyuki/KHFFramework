//
//  KHFVideo.m
//  VideoView
//
//  Created by obumin on 2014/12/28.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import "KHFVideo.h"

@implementation KHFVideo

+ (KHFVideo *)videoNamed:(NSString *)name
{
    KHFVideo *video = [[KHFVideo alloc] init];
    video.name = name;
    return video;
}

@end
