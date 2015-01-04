//
//  KHFLocationController.m
//  ChitaShikoku
//
//  Created by obumin on 2014/10/08.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import "KHFLocationController.h"
#define KHF_LOCATION_MANAGER_TIMEOUT_INTERVAL    15.0

@interface KHFLocationController () <CLLocationManagerDelegate>

// 内部からは読み書き可能にする
@property (assign, nonatomic, readwrite) KHFLocationControllerStatus status;
@property (strong, nonatomic, readwrite) CLLocationManager *locationManager;
@property (strong, nonatomic, readwrite) CLLocation *location;
@property (strong, nonatomic, readwrite) CLHeading *heading;

@end

@implementation KHFLocationController

#pragma mark - Initialization
// インスタンスを取得する (Singleton)
+ (KHFLocationController *)sharedInstance
{
    static KHFLocationController *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[self alloc] initSharedInstance];
    });
    return sharedSingleton;
}

// private
// インスタンスを生成する
- (id)initSharedInstance {
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        // 取得精度の指定
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        // 取得頻度（指定したメートル移動したら再取得する）
//        _locationManager.distanceFilter = 5;    // 5m移動するごとに取得
        _locationManager.distanceFilter = 30; // Meters.
        
        self.timeoutInterval = KHF_LOCATION_MANAGER_TIMEOUT_INTERVAL;
        self.status = KHFLocationControllerStatusIdle;
        self.location = _locationManager.location;
//        // 現在位置の使用認証画面を表示する (iOS8)
//        if ([_locationManager
//             respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//            NSLog(@"requestWhenInUseAuthorization");
//            [_locationManager requestWhenInUseAuthorization];
//        }
    }
    return self;
}

// private
// initを外部から呼び出せないようにする
- (id)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

#pragma mark - Location Manager Delegate Method

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"didUpdateLocations");
    CLLocation *location = locations.lastObject;
    
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (location.horizontalAccuracy < 0) {
        return;
    }
    
    // test the age of the location measurement to determine if the measurement is cached
    // in most cases you will not want to rely on cached measurements
    //
    NSTimeInterval locationAge = -[location.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) {
        return;
    }
    
    self.location = location;
    self.heading = manager.heading;
    // ステータスをUpdatedにする
    [self stopUpdatingLocationWithStatus:KHFLocationControllerStatusLocationUpdated];
    // delegateに通知する
    if ([self.delegate
         respondsToSelector:@selector(locationControllerDidUpdateLocation:)]) {
        [self.delegate locationControllerDidUpdateLocation:location];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Failed to get your location.");
    self.location = nil;
    self.heading = nil;
    
    [self stopUpdatingLocationWithStatus:KHFLocationControllerStatusLocationFailed];
    // delegateに通知する
    if ([self.delegate
         respondsToSelector:@selector(locationControllerDidFailWithError:)]) {
        [self.delegate locationControllerDidFailWithError:error];
    }
    
}

/**
 * Tells the delegate that updates will no longer be deferred.
 * 更新が終了（通知されなくなった）した時に通知される
 */
- (void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error
{
    [self stopUpdatingLocationWithStatus:KHFLocationControllerStatusLocationUpdated];
    // delegateに通知する
    if ([self.delegate
         respondsToSelector:@selector(locationControllerDidFinishDeferredUpdatesWithError:)]) {
        [self.delegate locationControllerDidFinishDeferredUpdatesWithError:error];
    }
}


//  iOS 8 の位置情報のプライバシー設定に対応する – I'm Sei.
//  http://im-sei.tumblr.com/post/91824653043/ios-8
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
            {
                [self.locationManager requestWhenInUseAuthorization];
            };
            break;
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
            // delegateに通知する
            if ([self.delegate
                 respondsToSelector:@selector(alertlocationServicesDisabled)]) {
                // 上記のコードでアラートが表示される
                [self.delegate alertlocationServicesDisabled];
            }
            break;
        case kCLAuthorizationStatusAuthorized:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            break;
        default:
            break;
    }
}

// アラートを表示する
//
//
- (void)showAlertLocationServicesDisabled:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message
{
    
    if (NSClassFromString(@"UIAlertController")) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", nil)
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action){
                                                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                                                    [[UIApplication sharedApplication] openURL:url];
                                                }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Close", nil)
                                                  style:UIAlertActionStyleCancel
                                                handler:nil]];
        if (viewController) {
            [viewController presentViewController:alert animated:YES completion: nil];
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:title
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"Close", nil)
                          otherButtonTitles:nil, nil]
         show];
        
    }
}

// 認証状況をチェックする
+ (BOOL)authorizationStatus
{
    BOOL result = NO;
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
            // 位置情報サービスへのアクセスを許可するか選択されていない
            NSLog(@"kCLAuthorizationStatusNotDetermined");
            result = NO;
            break;
        case kCLAuthorizationStatusRestricted:
            // 設定 > 一般 > 機能制限で利用が制限されている
            NSLog(@"kCLAuthorizationStatusRestricted");
            result = NO;
            break;
        case kCLAuthorizationStatusDenied:
            // ユーザーがこのアプリでの位置情報サービスへのアクセスを許可していない
            NSLog(@"kCLAuthorizationStatusDenied");
            result = NO;
            break;
        case kCLAuthorizationStatusAuthorized:
            // 位置情報サービスへのアクセスが許可されている
            NSLog(@"kCLAuthorizationStatusAuthorized");
            result = YES;
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            // 位置情報サービスへのアクセスがアプリ起動中にのみ許可されている
            NSLog(@"kCLAuthorizationStatusAuthorizedWhenInUse");
//        case kCLAuthorizationStatusAuthorizedAlways:
//            NSLog(@"kCLAuthorizationStatusAuthorizedAlways");
            result = YES;
            break;
        default:
            break;
    }

    return result;
}

// 更新を開始する
- (void)startUpdatingLocation
{
    if (![KHFLocationController locationServicesEnabled]) {
        // delegateに通知する
        if ([self.delegate
             respondsToSelector:@selector(alertlocationServicesDisabled)]) {
            // 上記のコードでアラートが表示される
            [self.delegate alertlocationServicesDisabled];
        }
        return;
    }
    
    if (self.status == KHFLocationControllerStatusLocationUpdating) {
        NSLog(@"LocationUpdating");
        return;
    }
    
    self.status = KHFLocationControllerStatusLocationUpdating;
    // 現在値を更新する
    [self.locationManager startUpdatingLocation];
    // 一定時間になったらタイムアウトする
    [self performSelector:@selector(timeoutUpdatingLocation)
                              withObject:nil
                              afterDelay:self.timeoutInterval];
    
}

// 更新を止める
- (void)stopUpdatingLocation
{
    switch (self.status) {
        case KHFLocationControllerStatusLocationUpdating:
            [self stopUpdatingLocationWithStatus:KHFLocationControllerStatusLocationCanceled];
            break;
            
        default:
            break;
    }
}

// private
// 時間切れのときの処理
- (void)timeoutUpdatingLocation
{
    [self stopUpdatingLocationWithStatus:KHFLocationControllerStatusLocationTimeout];
}

// private
- (void)stopUpdatingLocationWithStatus:(KHFLocationControllerStatus)status
{
    self.status = status;
    switch (status) {
        case KHFLocationControllerStatusLocationCanceled:
            // キャンセル
            break;
        case KHFLocationControllerStatusLocationFailed:
            // ロケーション取得に失敗
            break;
        default:
            // それ以外は継続して現在地を測定
            return;
    }
    // 更新を終了する
    [self.locationManager stopUpdatingLocation];
}

// 機種がロケーションサービスを許可しているかチェックする
+ (BOOL)locationServicesEnabled
{
    return [CLLocationManager locationServicesEnabled];
}

// 現在地が更新中かチェックする
- (BOOL)isLocationUpdating
{
    return (self.status == KHFLocationControllerStatusLocationUpdating);
}
@end