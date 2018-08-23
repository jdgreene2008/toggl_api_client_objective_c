//
//  TGLProject.h
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/25/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGLBaseObject.h"
#import "TGLTask.h"

@interface TGLProject : TGLBaseObject

@property(nonatomic,assign) NSInteger projectId;

@property(nonatomic,assign) NSInteger workspaceId;

@property(nonatomic,copy) NSString* name;

@property(nonatomic,assign) BOOL billable;

@property(nonatomic,assign) BOOL isPrivate;

@property(nonatomic,assign) BOOL isActive;

@property(nonatomic,copy) NSString* hexColor;

@property(nonatomic) NSArray<TGLTask*>* tasks;

@end
