//
//  KHFiAdViewController.m
//
//  Created by obumin on 2/12/15.
//  Copyright (c) 2015 Kawai Hiroyuki. All rights reserved.
//

#import "KHFiAdViewController.h"

@interface KHFiAdViewController ()

@property (retain, nonatomic) ADBannerView *iadView;

@end

@implementation KHFiAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 広告ビューを読み込む
- (void)loadAd
{
    [super loadAd];
    // iAd
    //    _adView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    _iadView = [[ADBannerView alloc] initWithFrame:CGRectMake(0,
                                                              self.view.frame.size.height,
                                                              0,
                                                              0)];
    _iadView.delegate = self;
    // adViewのフレーム矩形が変更された時にサブビューのサイズを自動的に変更
    _iadView.autoresizesSubviews = YES;
    // 非表示にしておく
    _iadView.alpha = 0.0f;
    
    [self.view addSubview:_iadView];
    self.adView = _iadView;
    
    [self configureStatusbar];
    
}

#pragma mark ADBannerViewDelegate
// 広告バナーが読み込まれたときの処理
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"visible ad");
    [self adBannerViewDidLoad:banner];
}
// 広告バナーの読み込みに失敗したときの処理
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Not have visible iAd");
    [self adBannerView:banner didFailToReceiveAdWithError:error];
}

@end
