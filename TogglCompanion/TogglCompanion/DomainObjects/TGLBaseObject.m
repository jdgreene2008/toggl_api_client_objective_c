//
//  TGLBaseObject.m
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/25/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import "TGLBaseObject.h"
#import <objc/runtime.h>


@implementation TGLBaseObject

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    return self;
}

-(void)logData
{
    NSLog(@"\n----- Logging Class %@",[[self class] description]);
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([self class], &numberOfProperties);
    for (NSUInteger i = 0; i < numberOfProperties; i++) {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        NSLog(@"Property %@ Value: %@", name, [self valueForKey:name]);
    }
}

@end
