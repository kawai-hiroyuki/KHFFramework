//
//  KHFVideoView.h
//  VideoView
//
//  Created by obumin on 2014/12/28.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import "KHFVideo.h"

@interface KHFVideoView : UIView

@property (retain, nonatomic) KHFVideo *video;

- (instancetype)initWithVideo:(KHFVideo *)video;

- (void)play;
- (void)pause;

@end
