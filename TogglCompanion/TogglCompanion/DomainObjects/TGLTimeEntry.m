//
//  TGLTimeEntry.m
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/25/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import "TGLTimeEntry.h"
#import "TGLDateUtils.h"

const NSInteger NO_ENTRY = -1;

@implementation TGLTimeEntry

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    if(self)
    {
        self.info = [dict objectForKey:@"description"];
        self.workspaceId = [(NSNumber*)[dict objectForKey:@"wid"] integerValue];
        self.projectId = [(NSNumber*)[dict objectForKey:@"pid"] integerValue];
        self.entryId = [(NSNumber*)[dict objectForKey:@"id"] integerValue];
        self.taskId = [(NSNumber*)[dict objectForKey:@"tid"] integerValue];
        self.billable = [(NSNumber*)[dict objectForKey:@"billable"] boolValue];
        self.startTime = [dict objectForKey:@"start"];
        self.stopTime = [dict objectForKey:@"stop"];
        self.duration = [(NSNumber*)[dict objectForKey:@"duration"] integerValue];
        self.createdWith = [dict objectForKey:@"created_with"];
    }
    return self;
}

-(void)formatStartDate:(NSDate *)start
{
    self.startTime = [TGLDateUtils formatDate:start];
}

-(void)formatStopDate:(NSDate *)stop
{
    self.stopTime = [TGLDateUtils formatDate:stop];
}

-(NSDictionary*)toJson
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.info forKey:@"description"];
    [dict setValue:[NSNumber numberWithInteger:self.projectId] forKey:@"pid"];
    [dict setValue:[NSNumber numberWithInteger:self.taskId] forKey:@"tid"];
    [dict setObject:self.startTime forKey:@"start"];
    [dict setObject:self.stopTime forKey:@"stop"];
    [dict setValue:[NSNumber numberWithInteger:self.duration] forKey:@"duration"];
    [dict setValue:@"ios test app" forKey:@"created_with"];
    if(self.entryId != NO_ENTRY)
    {
        [dict setObject:[NSNumber numberWithInteger:self.entryId] forKey:@"id"];
    }
    NSMutableDictionary* root = [[NSMutableDictionary alloc] init];
    [root setObject:dict forKey:@"time_entry"];
    return  [NSDictionary dictionaryWithDictionary:root];
}

@end
