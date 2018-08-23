//
//  TGLCredentials.m
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/25/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import "TGLCredentials.h"

@implementation TGLCredentials

-(instancetype)initWithUsername:(NSString *)username andPassword:(NSString *)password
{
    self = [super init];
    if(self)
    {
    self.username = username;
    self.password = password;
    }
    return self;
}

@end
