//
//  NSDate+Custom.m
//  TravelMemoSample
//
//  Created by obumin on 2014/10/02.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

+ (NSString *)standardFormatTime
{
    NSDate* date = [NSDate date];
    return [self standardFormatTime:date];
}

+ (NSString *)standardFormatTime:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}

+ (NSString *)standardFormatDate
{
    NSDate* date = [NSDate date];
    return [self standardFormatDate:date];
}

+ (NSString *)standardFormatDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    return [formatter stringFromDate:date];
}
@end
