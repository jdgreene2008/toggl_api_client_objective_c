//
//  TGLBlogDescriptor.m
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/25/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import "TGLBlogDescriptor.h"

@implementation TGLBlogDescriptor

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super initWithDictionary:dict];
    if(self)
    {
        self.url = [dict objectForKey:@"url"];
        self.category = [dict objectForKey:@"category"];
        self.title = [dict objectForKey:@"title"];
        self.publicationDate = [dict objectForKey:@"pub_date"];
    }
    return self;
}

@end
