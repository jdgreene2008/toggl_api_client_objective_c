//
//  TGLUser.h
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/25/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import "TGLBaseObject.h"
#import "TGLBlogDescriptor.h"
#import "TGLProject.h"
#import "TGLTimeEntry.h"
#import "TGLTask.h"

@interface TGLUser : TGLBaseObject

@property(nonatomic,copy) NSString* apiToken;

@property(nonatomic,copy) NSString* defaultWorkspaceId;

@property(nonatomic,copy) NSString* email;

@property(nonatomic,copy) NSString* fullname;

@property(nonatomic,copy) NSString* timeOfDayFormat;

@property(nonatomic,assign) NSInteger beginningOfWeek;

@property(nonatomic,copy) NSString* language;

@property(nonatomic,copy) NSString* imageUrl;

@property(nonatomic,copy) NSString* timeZone;

@property(nonatomic) TGLBlogDescriptor* blogPost;

@property(nonatomic) NSArray<TGLProject*>* projects;

@property(nonatomic) NSArray<TGLTimeEntry*>* timeEntries;

@end
