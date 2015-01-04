//
//  KHFAdViewController.h
//  AdCollection
//
//  Created by obumin on 2014/09/27.
//  Modified by obumin on 2014/12/23
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface KHFAdViewController : UIViewController

@property (retain, nonatomic) ADBannerView *adView;

// トップにiAdを設置する（StatusBarとかぶる）
//- (void)addAdViewAtTop;
// 下にiAdを設置する（Toolbarとかぶる）
//- (void)addAdViewAtBottom;
// Statusbarの下にiAdを設置する
- (void)addAdViewUnderStatusbar;
// ツールバーの上に広告を表示する
- (void)addAdViewAboveToolbar;
// ナビゲーションバーの下に広告を表示する
- (void)addAdViewUnderNavigationBar;

//- (void)statusBarWillChange:(id)sender;
//- (void)statusBarDidChange:(id)sender;

@end
