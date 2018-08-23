//
//  TGLUser.m
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/25/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import "TGLUser.h"

@implementation TGLUser

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super initWithDictionary:dict];
    if(self)
    {
        self.apiToken = [dict objectForKey:@"api_token"];
        self.defaultWorkspaceId = [dict objectForKey:@"default_wid"];
        self.email = [dict objectForKey:@"email"];
        self.fullname = [dict objectForKey:@"fullname"];
        self.language = [dict objectForKey:@"language"];
        self.imageUrl = [dict objectForKey:@"image_url"];
        self.beginningOfWeek = [(NSNumber*)[dict objectForKey:@"beginning_of_week"] integerValue];
        self.blogPost = [[TGLBlogDescriptor alloc] initWithDictionary:dict[@"new_blog_post"]];
        
        NSArray *projects = [dict objectForKey:@"projects"];
        if(projects != nil && projects.count > 0)
        {
            NSMutableArray<TGLProject*>* projectsTemp = [[NSMutableArray alloc] initWithCapacity:projects.count];
            for(NSDictionary* projectJson in projects)
            {
                TGLProject* tempProject =[[TGLProject alloc] initWithDictionary:projectJson];
                if(tempProject.isActive)
                {
                [projectsTemp addObject:tempProject];
                }
            }
            self.projects = [[NSArray alloc] initWithArray:projectsTemp];
        }
    }
    return self;
}

@end
