//
//  KHFNendViewController.m
//
//  Created by obumin on 2/12/15.
//  Copyright (c) 2015 Kawai Hiroyuki. All rights reserved.
//
/*
 https://www.nend.net/m/help/index/22
 【iOSアプリ向け用】
 
 バナー型	API Key	spotID	Lang
 320 x 50	a6eca9dd074372c898dd1df549301f277c53f2b9	3172	ja/en
 320 x 100	eb5ca11fa8e46315c2df1b8e283149049e8d235e	70996	ja
 300 x 100	25eb32adddc4f7311c3ec7b28eac3b72bbca5656	70998	ja
 300 x 250	88d88a288fdea5c01d17ea8e494168e834860fd6	70356	ja
 728 x 90	2e0b9e0b3f40d952e6000f1a8c4d455fffc4ca3a	70999	ja
 アイコン型	2349edefe7c2742dfb9f434de23bc3c7ca55ad22	101281	ja/en
 インタースティシャル	308c2499c75c4a192f03c02b2fcebd16dcb45cc9	213208	ja/en
 */

#import "KHFNendViewController.h"

@interface KHFNendViewController ()

@property (nonatomic, retain) NADView * nadView;

@end

@implementation KHFNendViewController

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
    // (2) NADView の作成
    self.nadView = [[NADView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    // (3) ログ出力の指定
    [self.nadView setIsOutputLog:YES];
    // (4) set apiKey, spotId.
    //    [self.nadView setNendID:@"[管理画面より発行された apiKey]" spotID:@"[管理画面より発行された spotID]"];
    // バナー
    [self.nadView setNendID:self.nendID
                     spotID:self.nendSpotID];
    [self.nadView setDelegate:self]; //(5)
    [self.nadView load]; //(6)
    [self.view addSubview:self.nadView]; // 最初から表示する場合
    self.adView = self.nadView;
}


#pragma mark - NADViewの広告ロードが初めて成功した際に通知されます
- (void)nadViewDidFinishLoad:(NADView *)adView
{
    [self adBannerViewDidLoad:adView];
}

#pragma mark - 広告受信が成功した際に通知されます
- (void)nadViewDidReceiveAd:(NADView *)adView
{
}

#pragma mark - 広告受信に失敗した際に通知されます
- (void)nadViewDidFailToReceiveAd:(NADView *)adView
{
    [self adBannerView:adView didFailToReceiveAdWithError:adView.error];
}

#pragma mark - 広告バナークリック時に通知されます
- (void)nadViewDidClickAd:(NADView *)adView
{
}

@end
