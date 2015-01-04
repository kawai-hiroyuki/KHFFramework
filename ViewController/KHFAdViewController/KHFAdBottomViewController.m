//
//  HKiAdBottomViewController.m
//  AdCollection
//
//  Created by obumin on 2014/09/27.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import "KHFAdBottomViewController.h"
#import <iAd/iAd.h>

@interface KHFAdBottomViewController () <ADBannerViewDelegate>
@property (retain, nonatomic) ADBannerView *adView;
@end

@implementation KHFAdBottomViewController

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
    
    [self configureAd];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureAd
{
    // iAd
    _adView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    _adView.delegate = self;
    //    _adView.hidden = YES;
    
    // 画面(ビュー)の下に表示する場合
    _adView.frame = CGRectMake(0, self.view.frame.size.height - _adView.frame.size.height, _adView.frame.size.width, _adView.frame.size.height);
    
    // adViewのフレーム矩形が変更された時にサブビューのサイズを自動的に変更
    _adView.autoresizesSubviews = YES;
    
    // 横向き、縦向きに回転した際に、自動的に広告の横幅を調整し、画面上に固定
    // ※画面下に表示する場合は、コメントアウト。
    //_adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    
    // 横向き、縦向きに回転した際に、自動的に広告の横幅を調整し、画面下に固定
    // ※画面上に表示する場合は、コメントアウト。
    _adView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    // 非表示にしておく
    _adView.alpha = 0.0f;
    
    [self.view addSubview:_adView];
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


@end
