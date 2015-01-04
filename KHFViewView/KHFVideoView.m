//
//  KHFVideoView.m
//  VideoView
//
//  Created by obumin on 2014/12/28.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import "KHFVideoView.h"

@interface KHFVideoView ()

@property (strong, nonatomic) AVPlayer *videoPlayer;

@end

@implementation KHFVideoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithVideo:(KHFVideo *)video
{
    self = [super init];
    if (self) {
        self.video = video;
    }
    return self;
}

// AVPlayerLayerが使えますよと教えてあげる
// これなしで、普通のUIViewにくっつけても動かないので大事
+ (Class)layerClass
{
    return [AVPlayerLayer class];
}

- (void)setVideo:(KHFVideo *)video
{
    if (video) {
        NSURL *url = [NSURL URLWithString:video.name];
        NSInteger length = [[url lastPathComponent] length] - [url pathExtension].length - 1;
        NSString *baseFilename = [[url lastPathComponent] substringToIndex:length];
        NSString *moviePath = [[NSBundle mainBundle] pathForResource:baseFilename ofType:[url pathExtension]];
        
        NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
        
        _videoPlayer = [[AVPlayer alloc] initWithURL:movieURL];
        
        AVPlayerLayer* layer = ( AVPlayerLayer* )self.layer;
        layer.videoGravity = AVLayerVideoGravityResizeAspect;
        layer.player       = _videoPlayer;
    }
}

- (void)play
{
    [_videoPlayer play];
}

- (void)pause
{
    [_videoPlayer pause];
}

@end
