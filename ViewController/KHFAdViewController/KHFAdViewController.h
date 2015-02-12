//
//  KHFAdViewController.h
//  KHFFramework
//
//  Copyright (c) 2014 Kawai Hiroyuki. All rights reserved.
//
//  Created  by obumin on 2014/09/27.
//  Modified by obumin on 2014/12/23
//  Modified by obumin on 2015/01/11 Admob対応
//   Admob SDK が必要
//   pod 'Google-Mobile-Ads-SDK', '~> 6.10'
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//  Modified by obumin on 2015/01/16
//   バナーサイズを画面サイズによって自動的に変更するように変更
//  Modified by obumin on 2/10/15.
//   Nend対応
//   広告の種類によってViewControllerを切り替えるようにした
//   KHFiAdViewController    iAd
//   KHFAdmobViewController  Admob
//   KHFNendViewController   Nend

#import <UIKit/UIKit.h>

@interface KHFAdViewController : UIViewController

// 共通AdView
@property (retain, nonatomic) UIView *adView;

// Statusbarの下にAdを設置する
- (void)addAdViewUnderStatusbar;
// ツールバーの上に広告を表示する
- (void)addAdViewAboveToolbar;
// ナビゲーションバーの下に広告を表示する
- (void)addAdViewUnderNavigationBar;

// 広告ビューを読み込む
- (void)loadAd;
// StatusBarのサイズが変更したときの処理
- (void)configureStatusbar;

#pragma mark Delegate Method
// 広告バナーが読み込まれたときの処理
- (void)adBannerViewDidLoad:(UIView *)banner;
// 広告バナーの読み込みに失敗したときの処理
- (void)adBannerView:(UIView *)banner didFailToReceiveAdWithError:(NSError *)error;

@end