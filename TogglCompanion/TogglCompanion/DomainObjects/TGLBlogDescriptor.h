//
//  TGLBlogDescriptor.h
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/25/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGLBaseObject.h"

@interface TGLBlogDescriptor : TGLBaseObject

@property(nonatomic,copy) NSString* url;

@property(nonatomic,copy) NSString* category;

@property(nonatomic,copy) NSString* title;

@property(nonatomic,copy) NSString* publicationDate;

@end
