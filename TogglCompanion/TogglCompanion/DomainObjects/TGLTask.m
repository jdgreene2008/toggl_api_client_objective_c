//
//  TGLTask.m
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/25/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import "TGLTask.h"

@implementation TGLTask

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    if(self)
    {
        self.name = [dict objectForKey:@"name"];
        self.projectId = [(NSNumber*)[dict objectForKey:@"pid"] integerValue];
        self.workspaceId = [(NSNumber*)[dict objectForKey:@"wid"] integerValue];
        self.userId = [(NSNumber*)[dict objectForKey:@"uid"] integerValue];
        self.estimatedSeconds = [(NSNumber*)[dict objectForKey:@"uid"] integerValue];
        self.isActive = [(NSNumber*)[dict objectForKey:@"active"] boolValue];
        self.at = [dict objectForKey:@"at"];
        self.trackedSeconds = [(NSNumber*)[dict objectForKey:@"tracked_seconds"] integerValue];
    }
    return self;    return self;
}

@end
