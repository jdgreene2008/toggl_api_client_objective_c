//
//  DateUtils.m
//  TogglCompanion
//
//  Created by Jarvis Greene on 8/16/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import "TGLDateUtils.h"

NSString* const API_DATE_FORMAT = @"yyyy-MM-dd'T'HH:mm:ssXXX";

@implementation TGLDateUtils

+(NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:API_DATE_FORMAT];
    return [formatter stringFromDate:date];
}

+(NSDate*)dateWithOffsetYears:(NSInteger)yearsOffset days:(NSInteger)daysOffset minutes:(NSInteger)minutesOffset seconds:(NSInteger)secondsOffset
{
NSCalendar *calendar = [NSCalendar currentCalendar];
NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitMonth) fromDate:[NSDate date]];
    NSLog(@"Date Components: Year: %ld, Month %ld",
          (long)[dateComponents year],(long)[dateComponents month]);
[dateComponents setDay:dateComponents.day + daysOffset];
[dateComponents setYear:dateComponents.year + yearsOffset];
[dateComponents setMinute:dateComponents.minute + minutesOffset];
return [calendar dateFromComponents:dateComponents];
}

@end
