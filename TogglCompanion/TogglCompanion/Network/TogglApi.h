//
//  TogglApi.h
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/24/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGLCredentials.h"
#import "TGLUser.h"
#import "TGLTimeEntry.h"
#import "TGLDateUtils.h"

typedef NS_ENUM (NSInteger, HttpMethod)
{
    Get,
    Post,
    Delete,
    Put
};

@interface TogglApi : NSObject

@property(nonatomic) TGLCredentials* credentials;
@property(nonatomic) TGLUser* user;


+(id)sharedInstance;

-(void)login:(TGLCredentials *)credentials withCompletion:(void (^)(TGLUser *, NSError *))completion;

-(void)getTimeEntriesInRange:(NSString *)startDate to:(NSString *)endDate withCompletion:(void (^)(NSArray<TGLTimeEntry *> *, NSError *))completion;

-(void)createTimeEntry:(TGLTimeEntry *)timeEntry withCompletion:(void (^)(TGLTimeEntry *, NSError *))completion;

-(void)deleteTimeEntry:(NSInteger)entryId withCompletion:(void (^)(NSError *))completion;

-(void)updateTimeEntry:(TGLTimeEntry *)update withCompletion:(void (^)(TGLTimeEntry *, NSError *))completion;


@end
