//
//  AppDelegate.m
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/24/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import "AppDelegate.h"
#import "TogglApi.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   TGLCredentials* credentials = [[TGLCredentials alloc] initWithUsername:@"" andPassword:@""];
    
    // Login
    [[TogglApi sharedInstance] login:credentials withCompletion:^(TGLUser* user,NSError* error)
    {
        
        // Test create time entry.
        TGLUser* togglUser = ((TogglApi*)[TogglApi sharedInstance]).user;
        TGLTimeEntry* timeEntry = [[TGLTimeEntry alloc] init];
        [timeEntry formatStartDate:[[NSDate alloc] init]];
        [timeEntry formatStopDate:[[NSDate alloc] init]];
        timeEntry.workspaceId = [togglUser.defaultWorkspaceId integerValue];
        [[TogglApi sharedInstance] createTimeEntry:timeEntry withCompletion:^(TGLTimeEntry *entry, NSError * error) {
            if(entry != nil)
            {
                // Print the entry
                [entry logData];
            }
        }];
        
        
        // Test get time entries within a given range
        NSDate* startDate = [TGLDateUtils dateWithOffsetYears:0 days:-5 minutes:0 seconds:0];
        [[TogglApi sharedInstance] getTimeEntriesInRange:[TGLDateUtils formatDate:startDate] to:nil withCompletion:^(NSArray<TGLTimeEntry*>* timeEntries,NSError* error)
         {
             if(timeEntries != nil && timeEntries.count > 0)
             {
                 // Print all time entries returned within range.
                 for(TGLTimeEntry* entry in timeEntries)
                 {
                    [entry logData];
                 }
             }
         }
         ];
    }
     ];
    
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationWillEnterForeground");
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
