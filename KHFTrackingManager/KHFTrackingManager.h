//
//  TrackingManager.h
//  GoogleAnalyticsSample
//
//  Created by obumin on 2014/11/16.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//
//  https://developers.google.com/analytics/devguides/collection/ios/v3/?hl=ja
//
//  Google アナリティクス SDK では CoreData と SystemConfiguration のフレームワークが使われるため、アプリの対象リンク ライブラリに次のファイルを追加する必要があります。
//  libGoogleAnalyticsServices.a
//  AdSupport.framework
//  CoreData.framework
//  SystemConfiguration.framework
//  libz.dylib
//  libsqlite3.dylib
//
//

#import <Foundation/Foundation.h>

@interface KHFTrackingManager : NSObject

// Google Analyticsの初期化
+ (void)initWithTrackingId:(NSString *)trackingId;

// スクリーン名計測用メソッド
+ (void)sendScreenTracking:(NSString *)screenName;

// イベント計測用メソッド
+ (void)sendEventTracking:(NSString *)category action:(NSString *)action label:(NSString *)label value:(NSNumber *)value screen:(NSString *)screen;
@end
