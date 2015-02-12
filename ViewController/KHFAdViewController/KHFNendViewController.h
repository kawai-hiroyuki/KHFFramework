//
//  KHFNendViewController.h
//
//  Created by obumin on 2/12/15.
//  Copyright (c) 2015 Kawai Hiroyuki. All rights reserved.
//
//  Nendを表示させる
//
//  AdSupport.framework
//  ImageIO.framework
//  Security.framework

//
//  実装例)
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.nendID = @"a6eca9dd074372c898dd1df549301f277c53f2b9";
//    self.nendSpotID = @"3172";
//
//    [self addAdViewAboveToolbar];
//}


#import <UIKit/UIKit.h>
#import "KHFAdViewController.h"
#import "NADView.h"

@interface KHFNendViewController : KHFAdViewController <NADViewDelegate>
// Nend
@property (strong, nonatomic) NSString *nendID;
@property (strong, nonatomic) NSString *nendSpotID;

@end
