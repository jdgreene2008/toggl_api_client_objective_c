//
//  TGLProject.m
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/25/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import "TGLProject.h"

@implementation TGLProject

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super initWithDictionary:dict];
    if(self)
    {
        self.projectId = [(NSNumber*)[dict objectForKey:@"id"] integerValue];
        self.workspaceId = [(NSNumber*)[dict objectForKey:@"wid"] integerValue];
        self.name = [dict objectForKey:@"name"];
        self.billable = [(NSNumber*)[dict objectForKey:@"billable"] boolValue];
        self.isPrivate = [(NSNumber*)[dict objectForKey:@"is_private"] boolValue];
        self.isActive = [(NSNumber*)[dict objectForKey:@"active"] boolValue];
        self.hexColor = [dict objectForKey:@"hex_color"];
    }
    return self;
}

@end
