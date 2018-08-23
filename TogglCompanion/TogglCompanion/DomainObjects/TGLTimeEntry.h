//
//  TGLTimeEntry.h
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/25/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import "TGLBaseObject.h"

@interface TGLTimeEntry : TGLBaseObject

-(NSDictionary*)toJson;

/**
 Format the start date using the format: yyy-MM-dd'T'HH:mm:ssXXX
 */
-(void)formatStartDate:(NSDate*)start;

/**
 Format the stop date using the format: yyy-MM-dd'T'HH:mm:ssXXX
 */
-(void)formatStopDate:(NSDate*)stop;

@property(nonatomic,copy) NSString* info;

@property(nonatomic,assign) NSInteger workspaceId;

@property(nonatomic,assign) NSInteger projectId;

@property(nonatomic,assign) NSInteger entryId;

@property(nonatomic,assign) NSInteger taskId;

@property(nonatomic,assign) BOOL billable;

@property(nonatomic,copy) NSString* startTime;

@property(nonatomic,copy) NSString* stopTime;

@property(nonatomic,assign) NSInteger duration;

@property(nonatomic,copy) NSString* createdWith;

@end
