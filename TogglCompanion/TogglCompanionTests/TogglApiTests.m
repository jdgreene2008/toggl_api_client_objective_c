//
//  TogglApiTests.m
//  TogglCompanionTests
//
//  Created by Jarvis Greene on 7/28/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TogglApi.h"

@interface TogglApiTests : XCTestCase
@property(nonatomic) TogglApi* api;
@end

@implementation TogglApiTests

- (void)setUp {
    [super setUp];
    self.api = [TogglApi sharedInstance];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLogin {
    TGLCredentials* credentials = [[TGLCredentials alloc] initWithUsername:@"" andPassword:@""];
    [self.api login:credentials withCompletion:^(TGLUser* user,NSError* error){
        
    }];
}




@end
