//
//  KHFTime.h
//  Shikoku88
//
//  Created by obumin on 2014/12/24.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHFTime : NSObject

// NSTimeIntervalを読みやすいように変換する
// NSDateComponents *components = [KHFTime convertTimeComponentsFromInterval:timeInterval];
// NSLog(@"%lumin, [components minute]);
// NSLog(@"%luhours, [components hour]);
// NSLog(@"%ludays, [components day]);
// NSLog(@"%lumoths", [components month]);
+ (NSDateComponents *)convertTimeComponentsFromInterval:(NSTimeInterval)timeInterval;

@end
