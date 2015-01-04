//
//  KHFTime.m
//  Shikoku88
//
//  Created by obumin on 2014/12/24.
//  Copyright (c) 2014年 Kawai Hiroyuki. All rights reserved.
//

#import "KHFTime.h"

@implementation KHFTime

//  cocoa - How do I break down an NSTimeInterval into year, months, days, hours, minutes and seconds on iPhone? - Stack Overflow
//  http://stackoverflow.com/questions/1237778/how-do-i-break-down-an-nstimeinterval-into-year-months-days-hours-minutes-an
+ (NSDateComponents *)convertTimeComponentsFromInterval:(NSTimeInterval)timeInterval
{
    // The time interval
    //    NSTimeInterval theTimeInterval = ...;
    
    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
    // Create the NSDates
    NSDate *date1 = [[NSDate alloc] init]; // NOW
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:timeInterval sinceDate:date1];
    
    // Get conversion to months, days, hours, minutes
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit;
    
    NSDateComponents *components = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
    
    NSLog(@"Break down: %lumin %luhours %ludays %lumoths",[components minute], [components hour], [components day], [components month]);
    return components;
}

@end
