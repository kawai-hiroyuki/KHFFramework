//
//  KHFAdTableViewController.m
//  OpenSourceCollection
//
//  Created by obumin on 2014/12/03.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import "KHFAdTableViewController.h"

#define NAVIGATION_BAR_HEIGHT 64

@interface KHFAdTableViewController () <ADBannerViewDelegate>

@property (nonatomic) BOOL isShowAd;
@property (nonatomic) float translucentGap;

@end

@implementation KHFAdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma iAd
- (void)configureAd
{
    // iAd
    self.isShowAd = NO;
    // 画面外に広告を配置しておく
    self.adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0,
                                                                     self.view.frame.size.height,
                                                                     0,
                                                                     0)];
    self.adView.delegate = self;
    self.adView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.adView];
    
    // 一番下のセルが広告に隠れないように空のフッターを追加
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                              0,
                                                                              self.adView.frame.size.width,
                                                                              self.adView.frame.size.height)];
    
    if ([[UINavigationBar appearance] isTranslucent]){
        // 透明でない場合はGapをつける必要がある
        self.translucentGap = NAVIGATION_BAR_HEIGHT;
    } else {
        self.translucentGap = 0;
    }
    NSLog(@"translucentGap=%f", self.translucentGap);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isShowAd)
    {
        // スクロールしても、常に画面下に広告を表示する
        CGRect frame = [[UIScreen mainScreen] applicationFrame];
        float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        float viewHeight = frame.size.height;
        float adViewWidth = self.adView.frame.size.width;
        float adViewHeight = self.adView.frame.size.height;
        
        //        NSLog(@"statusBarHeight=%f", statusBarHeight);
        //        NSLog(@"viewHeight=%f", viewHeight);
        //        NSLog(@"adViewWidth=%f", adViewWidth);
        //        NSLog(@"adViewHeight=%f", adViewHeight);
        //
        // AppDelegateでNavigationBarを透過しないようにしたために
        // statusBarHeightの値が変化してしまった
        // その対策として64(StatusBar:20 NavigationBar:44)の固定値で修正した
        self.adView.frame = CGRectMake(0,
                                           viewHeight - adViewHeight + statusBarHeight - self.translucentGap,
                                           adViewWidth,
                                           adViewHeight);
        //        NSLog(@"size=%f", viewHeight - adViewHeight + statusBarHeight - NAVIGATION_BAR_HEIGHT);
        
        [self.view bringSubviewToFront:self.adView];
    }
}

// 広告を取得できたら画面下に広告を表示する(アニメーション付き)
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    self.isShowAd = YES;
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    float viewHeight = frame.size.height;
    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    float adViewWidth = self.adView.frame.size.width;
    float adViewHeight = self.adView.frame.size.height;
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.adView.frame = CGRectMake(0,
                                                            viewHeight - adViewHeight + statusBarHeight - self.translucentGap,
                                                            adViewWidth,
                                                            adViewHeight);
                         
                         self.adView.alpha = 1.0;
                     }
                     completion:nil];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"didFailToReceiveAdWithError:%@", [error description]);
    self.isShowAd = NO;
}

@end
