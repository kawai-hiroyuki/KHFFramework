//
//  KHFiAdViewController.h
//
//  Created by obumin on 2/12/15.
//  Copyright (c) 2015 Kawai Hiroyuki. All rights reserved.
//
//  iAdを表示させる
//
//  実装例)
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    // ツールバーの上に広告を表示する
//    [self addAdViewAboveToolbar];
//}


#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "KHFAdViewController.h"

@interface KHFiAdViewController : KHFAdViewController <ADBannerViewDelegate>

@end
