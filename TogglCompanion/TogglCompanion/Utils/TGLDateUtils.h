//
//  DateUtils.h
//  TogglCompanion
//
//  Created by Jarvis Greene on 8/16/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGLDateUtils : NSObject

+(NSString*)formatDate:(NSDate*)date;

+(NSDate*)dateWithOffsetYears:(NSInteger)yearsOffset days:(NSInteger)daysOffset minutes:(NSInteger)minutesOffset seconds:(NSInteger)secondsOffset;

@end
