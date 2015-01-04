//
//  HKiAdViewController.m
//  AdCollection
//
//  Created by obumin on 2014/09/27.
//  Modified by obumin on 2014/12/23
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import "KHFAdViewController.h"

@interface KHFAdViewController () <ADBannerViewDelegate>

@property (weak) id statusBarWillChange;
@property (weak) id statusBarDidChange;
@end

@implementation KHFAdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear
{
    // Viewが消えたときにNSNotificationCenterを削除する
    [[NSNotificationCenter defaultCenter] removeObserver:self.statusBarWillChange];
    [[NSNotificationCenter defaultCenter] removeObserver:self.statusBarDidChange];
}

// iAdのインスタンスを作成する
- (void)configureAd
{
    // iAd
    _adView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    _adView.delegate = self;
    // adViewのフレーム矩形が変更された時にサブビューのサイズを自動的に変更
    _adView.autoresizesSubviews = YES;
    // 非表示にしておく
    _adView.alpha = 0.0f;
    
    [self.view addSubview:_adView];
    
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
    [self configureAd];
    
    // 横向き、縦向きに回転した際に、自動的に広告の横幅を調整し、画面上に固定
    // ※画面下に表示する場合は、コメントアウト。
    _adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
}

// 下にiAdを設置する（Toolbarとかぶる）
- (void)addAdViewAtBottom
{
    [self configureAd];
    
    // 画面(ビュー)の下に表示する場合
    _adView.frame = CGRectMake(0, self.view.frame.size.height - _adView.frame.size.height, _adView.frame.size.width, _adView.frame.size.height);
    // 横向き、縦向きに回転した際に、自動的に広告の横幅を調整し、画面下に固定
    // ※画面上に表示する場合は、コメントアウト。
    _adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

// Statusbarの下にiAdを設置する
- (void)addAdViewUnderStatusbar
{
    [self configureAd];
    
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
    [self configureAd];
    
    CGFloat toolbarHeight = 0;
    if (!self.navigationController.isToolbarHidden) {
        // Toolbarがある場合はツールバーのサイズを取得する
        toolbarHeight = self.navigationController.toolbar.frame.size.height;
    }
    
    // 画面(ビュー)の下に表示する場合
    CGFloat y = self.view.frame.size.height // 全体の高さ
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
    [self configureAd];
    
    // 画面(ビュー)の下に表示する場合
    CGFloat y = [UIApplication sharedApplication].statusBarFrame.size.height
    + self.navigationController.navigationBar.frame.size.height; // ツールの高さを引く
    
    _adView.frame = CGRectMake(0, y, _adView.frame.size.width, _adView.frame.size.height);
    
    // 横向き、縦向きに回転した際に、自動的に広告の横幅を調整し、画面上に固定
    // ※画面下に表示する場合は、コメントアウト。
    _adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
}


#pragma mark ADBannerViewDelegate

// iAd
// 広告バナーが読み込まれたときの処理
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         _adView.alpha = 1.0;
                     }];
    _adView.hidden = NO;
}

// 広告バナーの読み込みに失敗したときの処理
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Not have visible ad");
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
