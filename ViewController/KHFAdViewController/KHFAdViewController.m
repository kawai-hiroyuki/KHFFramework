//
//  KHFAdViewController.m
//
//  Created by obumin on 2/10/15.
//  Copyright (c) 2015 Kawai Hiroyuki. All rights reserved.
//

#import "KHFAdViewController.h"

@interface KHFAdViewController ()

// Statusbarに透過があるかどうか
@property (nonatomic) float translucentGap;

@property (weak) id statusBarWillChange;
@property (weak) id statusBarDidChange;

@end

@implementation KHFAdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[UINavigationBar appearance] isTranslucent]){
        // 透明でない場合はGapをつける必要がある
        // statusbarとnavigationbarのサイズを引く
        self.translucentGap = [UIApplication sharedApplication].statusBarFrame.size.height
        + self.navigationController.navigationBar.frame.size.height;
    } else {
        self.translucentGap = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear
{
    // Viewが消えたときにNSNotificationCenterを削除する
    [[NSNotificationCenter defaultCenter] removeObserver:self.statusBarWillChange];
    [[NSNotificationCenter defaultCenter] removeObserver:self.statusBarDidChange];
}

// 広告ビューを読み込む（継承クラスで実際の処理を行う）
- (void)loadAd
{
    // Nop
}

// StatusBarのサイズが変更したときの処理
- (void)configureStatusbar
{
    // StatusBarのサイズが変更したときの処理
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    self.statusBarWillChange = [center
                                addObserverForName:UIApplicationWillChangeStatusBarFrameNotification
                                object:nil
                                queue:[NSOperationQueue mainQueue]
                                usingBlock:^(NSNotification *note) {
                                    NSLog(@"UIApplicationWillChangeStatusBarFrameNotification !!!");
                                    [self statusBarWillChange:note];
                                }
                                ];
    self.statusBarDidChange = [center
                               addObserverForName:UIApplicationDidChangeStatusBarFrameNotification
                               object:nil
                               queue:[NSOperationQueue mainQueue]
                               usingBlock:^(NSNotification *note) {
                                   NSLog(@"UIApplicationDidChangeStatusBarFrameNotification !!!");
                                   [self statusBarDidChange:note];
                               }
                               ];
}

// トップにiAdを設置する（StatusBarとかぶる）
- (void)addAdViewAtTop
{
    [self loadAd];
    
    // 横向き、縦向きに回転した際に、自動的に広告の横幅を調整し、画面上に固定
    // ※画面下に表示する場合は、コメントアウト。
    _adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
}

// 下にiAdを設置する（Toolbarとかぶる）
- (void)addAdViewAtBottom
{
    [self loadAd];
    
    // 画面(ビュー)の下に表示する場合
    _adView.frame = CGRectMake(0, self.view.frame.size.height - _adView.frame.size.height, _adView.frame.size.width, _adView.frame.size.height);
    // 横向き、縦向きに回転した際に、自動的に広告の横幅を調整し、画面下に固定
    // ※画面上に表示する場合は、コメントアウト。
    _adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

// Statusbarの下にiAdを設置する
- (void)addAdViewUnderStatusbar
{
    [self loadAd];
    
    // 画面(ビュー)の下に表示する場合
    // http://dendrocopos.jp/wp/archives/298
    CGFloat y = [UIApplication sharedApplication].statusBarFrame.size.height;
    _adView.frame = CGRectMake(0, y, _adView.frame.size.width, _adView.frame.size.height);
    
    // 横向き、縦向きに回転した際に、自動的に広告の横幅を調整し、画面上に固定
    // ※画面下に表示する場合は、コメントアウト。
    _adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
}

// ツールバーの上に広告を表示する
- (void)addAdViewAboveToolbar
{
    [self loadAd];
    
    CGFloat toolbarHeight = 0;
    if (!self.navigationController.isToolbarHidden) {
        // Toolbarがある場合はツールバーのサイズを取得する
        toolbarHeight = self.navigationController.toolbar.frame.size.height;
    }
    
    // 画面(ビュー)の下に表示する場合
    CGFloat y = self.view.frame.size.height // 全体の高さ
    //    + [UIApplication sharedApplication].statusBarFrame.size.height  // Statusbarのサイズを足す
    - toolbarHeight                         // ツールバーの高さを引く
    - _adView.frame.size.height;            // AdViewの高さを引く
    
    
    _adView.frame = CGRectMake(0, y, _adView.frame.size.width, _adView.frame.size.height);
    
    // 横向き、縦向きに回転した際に、自動的に広告の横幅を調整し、画面下に固定
    // ※画面上に表示する場合は、コメントアウト。
    _adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

// ナビゲーションバーの下に広告を表示する
- (void)addAdViewUnderNavigationBar
{
    [self loadAd];
    
    // 画面(ビュー)の下に表示する場合
    CGFloat y = [UIApplication sharedApplication].statusBarFrame.size.height
    + self.navigationController.navigationBar.frame.size.height; // ツールの高さを引く
    
    _adView.frame = CGRectMake(0, y, _adView.frame.size.width, _adView.frame.size.height);
    
    // 横向き、縦向きに回転した際に、自動的に広告の横幅を調整し、画面上に固定
    // ※画面下に表示する場合は、コメントアウト。
    _adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
}

#pragma mark Delegate Method
// 広告バナーが読み込まれたときの処理
- (void)adBannerViewDidLoad:(UIView *)banner
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         _adView.alpha = 1.0;
                     }];
    
    self.adView.hidden = NO;
}

// 広告バナーの読み込みに失敗したときの処理
- (void)adBannerView:(UIView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    _adView.frame = CGRectMake(0,
                               self.view.frame.size.height,
                               0,
                               0);
    _adView.alpha = 0.0;
    _adView.hidden = YES;
}

#pragma mark UI
- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame{
    NSLog(@"appHeightDidChange=%f",[UIApplication sharedApplication].statusBarFrame.size.height);
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame{
    NSLog(@"appHeightWillChange=%f",[UIApplication sharedApplication].statusBarFrame.size.height);
}

- (IBAction)statusBarWillChange:(id)sender
{
    NSLog(@"statusBarWillChange");
}

- (IBAction)statusBarDidChange:(id)sender
{
    NSLog(@"statusBarDidChange");
}

@end
