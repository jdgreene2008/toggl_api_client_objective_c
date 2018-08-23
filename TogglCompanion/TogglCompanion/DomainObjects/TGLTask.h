//
//  TGLTask.h
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/25/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGLBaseObject.h"

@interface TGLTask : TGLBaseObject

@property(nonatomic,copy) NSString* name;

@property(nonatomic,assign) NSInteger projectId;

@property(nonatomic,assign) NSInteger workspaceId;

@property(nonatomic,assign) NSInteger userId;

@property(nonatomic,assign) NSInteger estimatedSeconds;

@property(nonatomic,assign) BOOL isActive;

@property(nonatomic,copy) NSString* at;

@property(nonatomic,assign) NSInteger trackedSeconds;

@end
