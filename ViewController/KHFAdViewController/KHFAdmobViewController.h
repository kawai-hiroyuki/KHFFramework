//
//  KHFAdmobViewController.h
//
//  Created by obumin on 2/12/15.
//  Copyright (c) 2015 Kawai Hiroyuki. All rights reserved.
//
//  Admobを表示させる
//
//  実装例)
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.adUnitID = @"ca-app-pub-9519424358678937/1730643807";
//    self.testDevices = @[@"a68dfad83a8b7fccf8b9efa35f05bc64",    // iPhone4
//                         @"cfffc4d2341fca3cfba76c04f947d339",    // iPad mini
//                         GAD_SIMULATOR_ID];                      // Simulator
//
//    [self addAdViewAboveToolbar];
//}

#import <UIKit/UIKit.h>
#import <GADBannerView.h>
#import "KHFAdViewController.h"

@interface KHFAdmobViewController : KHFAdViewController <GADBannerViewDelegate>

// Admob
@property (strong, nonatomic) NSString *adUnitID;
@property (strong, nonatomic) NSArray *testDevices;

@end
