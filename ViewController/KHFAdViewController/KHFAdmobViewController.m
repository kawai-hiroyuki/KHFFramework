//
//  KHFAdmobViewController.m
//
//  Created by obumin on 2/12/15.
//  Copyright (c) 2015 Kawai Hiroyuki. All rights reserved.
//

#import "KHFAdmobViewController.h"

@interface KHFAdmobViewController ()

@property (retain, nonatomic) GADBannerView *admobView;

@end

@implementation KHFAdmobViewController

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
    // 画面サイズによって自動的にバナーサイズを変更する
    // スマート バナー - Google Mobile Ads SDK — Google Developers
    // https://developers.google.com/mobile-ads-sdk/docs/admob/smart-banners?hl=ja
    _admobView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    
    // 広告ユニット ID を指定する
    //    _admobView.adUnitID = @"ca-app-pub-9519424358678937/5999393004";
    _admobView.adUnitID = self.adUnitID;
    
    // ユーザーに広告を表示した場所に後で復元する UIViewController をランタイムに知らせて
    // ビュー階層に追加する
    _admobView.rootViewController = self;
    // Delegateを設定
    _admobView.delegate = self;
    // 一般的なリクエストを行って広告を読み込む
    GADRequest *req = [GADRequest request];
    req.testDevices = self.testDevices;
    [_admobView loadRequest:req];
    
    [self.view addSubview:_admobView];
    self.adView = _admobView;
    
    [self configureStatusbar];

}

#pragma mark GADBannerViewDelegate
// 広告バナーが読み込まれたときの処理
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLog(@"visible admob");
    [self adBannerViewDidLoad:view];
}
// 広告バナーの読み込みに失敗したときの処理
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"Not have visible admob");
    [self adBannerView:view didFailToReceiveAdWithError:error];
}


@end
