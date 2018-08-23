//
//  TGLCredentials.h
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/25/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGLCredentials : NSObject

@property(nonatomic,copy) NSString* username;

@property(nonatomic,copy) NSString* password;

-(instancetype) initWithUsername:(NSString*)username andPassword:(NSString*)password;

/**
 * Class instance init - this initializer should not be called since all exposed properties are read only
 *
 * @return instance of class
 */
- (instancetype)init NS_UNAVAILABLE;

@end
