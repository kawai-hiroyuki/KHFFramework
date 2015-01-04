//
//  KHFVideo.h
//  VideoView
//
//  Created by obumin on 2014/12/28.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHFVideo : NSObject

@property (retain, nonatomic) NSString *name;

+ (KHFVideo *)videoNamed:(NSString *)name;

@end
