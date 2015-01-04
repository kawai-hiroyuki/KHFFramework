//
//  KHFLocationController.h
//  ChitaShikoku
//
//  Created by obumin on 2014/10/08.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//
//  CLLocationManager Singleton | Michael Babiy
//  http://www.michaelbabiy.com/cllocationmanager-singleton/
//
//  [[KHFLocationController sharedController]setDelegate:self];
//  [[KHFLocationController sharedController].locationManager startUpdatingLocation];
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol KHFLocationControllerDelegate <NSObject>

@required
- (void)locationControllerDidUpdateLocation:(CLLocation *)location;
@optional
- (void)locationControllerDidFailWithError:(NSError *)error;
- (void)locationControllerDidFinishDeferredUpdatesWithError:(NSError *)error;
- (void)alertlocationServicesDisabled;

@end

// 現在地管理クラス(self)の状態
typedef NS_ENUM(NSInteger, KHFLocationControllerStatus) {
    KHFLocationControllerStatusIdle = 0,             // 初期化など準備中
    KHFLocationControllerStatusLocationUpdating,     // 更新中
    KHFLocationControllerStatusLocationUpdated,      // 更新された
    KHFLocationControllerStatusLocationCanceled,     // 更新中にキャンセルされた
    KHFLocationControllerStatusLocationTimeout,      // 更新中にタイムアウトした
    KHFLocationControllerStatusLocationFailed        // 更新できなかった
};

@interface KHFLocationController : NSObject
// 現在地管理のCoreLocationクラス
@property (strong, nonatomic, readonly) CLLocationManager *locationManager;
// 現在地の緯度経度
@property (strong, nonatomic, readonly) CLLocation *location;
@property (strong, nonatomic, readonly) CLHeading *heading;
// 現在地管理クラス(self)の状態を返す
@property (assign, nonatomic, readonly) KHFLocationControllerStatus status;
// 現在地更新のときに一定時間でタイムアウトする
@property (assign, nonatomic) NSTimeInterval timeoutInterval;
// デリゲート
@property (weak, nonatomic) id<KHFLocationControllerDelegate> delegate;
// インスタンスを取得する（Singleton)
+ (KHFLocationController *)sharedInstance;
// 認証されているかチェックする
+ (BOOL)authorizationStatus;
// 現在地の更新を開始する
- (void)startUpdatingLocation;
// 現在地の更新を終了する
- (void)stopUpdatingLocation;
// 機種がロケーションサービスを許可しているかチェックする
+ (BOOL)locationServicesEnabled;
// 現在地が更新中かチェックする
- (BOOL)isLocationUpdating;
// 警告を表示する
- (void)showAlertLocationServicesDisabled:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message;
@end
