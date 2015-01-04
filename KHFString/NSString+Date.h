//
//  NSDate+Custom.h
//  TravelMemoSample
//
//  Created by obumin on 2014/10/02.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)

+ (NSString *)standardFormatTime;
+ (NSString *)standardFormatTime:(NSDate *)date;
+ (NSString *)standardFormatDate;
+ (NSString *)standardFormatDate:(NSDate *)date;

@end
