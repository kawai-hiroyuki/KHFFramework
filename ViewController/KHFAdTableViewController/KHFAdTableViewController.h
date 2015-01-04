//
//  KHFAdTableViewController.h
//  OpenSourceCollection
//
//  Created by obumin on 2014/12/03.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface KHFAdTableViewController : UIViewController

@property (strong, nonatomic) UITableView *tableView;
// iAd
@property (nonatomic) ADBannerView *adView;

- (void)configureAd;

@end
