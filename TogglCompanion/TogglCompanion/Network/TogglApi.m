//
//  TogglApi.m
//  TogglCompanion
//
//  Created by Jarvis Greene on 7/24/18.
//  Copyright © 2018 JarvisDesigns. All rights reserved.
//

#import "TogglApi.h"

const NSString* BASE_URL = @"https://www.toggl.com/api/v8";
const NSString* BASE_TIME_ENTRIES_URL = @"https://www.toggl.com/api/v8/time_entries";

@implementation TogglApi

BOOL sessionInitialized = NO;

+ (id)sharedInstance
{
    static TogglApi* sharedApi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedApi = [[self alloc] init];
    });

    return sharedApi;
}

- (id)init
{
    self = [super init];
    return self;
}

-(NSString*) base64Encode:(NSString*)input
{
    NSData *nsdata = [input dataUsingEncoding:NSUTF8StringEncoding];
    return [nsdata base64EncodedStringWithOptions:0];
}

-(void)initializeSession
{
   
}

-(void)checkSessionInitialization
{
    if(!sessionInitialized){
        [self initializeSession];
    }
}

-(void)performRequest:(NSString*)url withHttpMethod:(HttpMethod)httpMethod withParams:(NSDictionary*)paramsDict withData:(NSData* _Nullable)data withCompletion:(void(^)(NSData* data,NSURLResponse* response,
                                                                                                   NSError* error))completion
{
    NSString* username = _credentials.username;
    NSString* password = _credentials.password;
    NSString* credentialsToEncode = [NSString stringWithFormat:@"%@:%@",username,password];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
   
    NSURL *requestUrl = [NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLComponents* components = [NSURLComponents componentsWithURL:requestUrl resolvingAgainstBaseURL:true];
    if(paramsDict != nil)
    {
        NSMutableArray* paramsArray = [[NSMutableArray alloc] init];
        for(id key in paramsDict)
        {
            [paramsArray addObject:[NSURLQueryItem queryItemWithName:key value:[paramsDict objectForKey:key]]];
        }
        components.queryItems = [NSArray arrayWithArray:paramsArray];
    }
    requestUrl = components.URL;
   
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];

    [request setHTTPMethod:[self getHttpMethodString:httpMethod]];
    [request setValue:[NSString stringWithFormat:@"Basic %@",
                       [self base64Encode:credentialsToEncode]] forHTTPHeaderField:@"Authorization"];
    [request setValue:[NSString stringWithFormat:@"Application/json"] forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Application/json"] forHTTPHeaderField:@"Accept"];

    
    NSLog(@"Request URL: %@",[requestUrl absoluteString]);
    if(httpMethod == Post && data != nil)
    {
        request.HTTPBody = data;
        NSLog(@"Request Body:\n%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }
    NSURLSessionDataTask *getDataTask = [session dataTaskWithRequest:request completionHandler:completion];
    [getDataTask resume];
}

-(NSString*)getHttpMethodString:(HttpMethod)method
{
    switch (method)
    {
        case Post:
            return @"POST";
        case Delete:
            return @"DELETE";
        case Put:
            return @"PUT";
        default:
            return @"GET";
    }
}

-(void)login:(TGLCredentials *)credentials withCompletion:(void (^)(TGLUser *, NSError *))completion
{
    self.credentials = credentials;
    NSString* url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/me?with_related_data=true"];
    [self performRequest:url withHttpMethod:Get withParams:nil withData:nil withCompletion:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        TGLUser* userResponse;
        if (response != nil)
        {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if([jsonDict objectForKey:@"data"] != nil)
            {
                TGLUser* userResponse = [[TGLUser alloc] initWithDictionary:jsonDict[@"data"]];
                self.user = userResponse;
           //     [self.user logData];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(userResponse,error);
        });
        
    }];
}

-(void)getTimeEntriesInRange:(NSString *)startDate to:(NSString *)endDate withCompletion:(void (^)(NSArray<TGLTimeEntry *> *, NSError *))completion
{
    NSMutableDictionary* params = nil;
    if(startDate != nil || endDate != nil)
    {
        params = [[NSMutableDictionary alloc] init];
        if(startDate != nil)
        {
            [params setObject:startDate forKey:@"start_date"];
        }
        if(endDate != nil)
        {
            [params setObject:endDate forKey:@"end_date"];
        }
    }
    NSString* url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/time_entries"];
    [self performRequest:url withHttpMethod:Get withParams:[NSDictionary dictionaryWithDictionary:params] withData:nil withCompletion:^(NSData *data, NSURLResponse *response, NSError *error)
     {
         NSMutableArray<TGLTimeEntry*>* results = [[NSMutableArray alloc] init];
         if (response != nil)
         {
             if([response isKindOfClass:[NSHTTPURLResponse class]])
             {
                 NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
                 NSLog(@"Received response code %ld", (long)httpResponse.statusCode);
                 NSLog(@"Body:\n%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
             }
             NSArray<NSDictionary*> *timeEntries = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             if(timeEntries != nil)
             {
                 for(NSDictionary* entryJson in timeEntries)
                 {
                     [results addObject:[[TGLTimeEntry alloc] initWithDictionary:entryJson]];
                 }
             }
         }
         dispatch_async(dispatch_get_main_queue(), ^{
            completion(results,error);
         });
         
     }];
    
}

-(void)createTimeEntry:(TGLTimeEntry *)timeEntry withCompletion:(void (^)(TGLTimeEntry *, NSError *))completion
{
    NSString* url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/time_entries"];
    NSError* serializationError = nil;
    [self performRequest:url withHttpMethod:Post withParams:nil withData:[NSJSONSerialization dataWithJSONObject:[timeEntry toJson] options:0 error:&serializationError] withCompletion:^(NSData *data, NSURLResponse *response, NSError *error)
     {
         TGLTimeEntry* entry;
         if (response != nil)
         {
             if([response isKindOfClass:[NSHTTPURLResponse class]])
             {
                 NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
                 NSLog(@"Received response code %ld", (long)httpResponse.statusCode);
                 NSLog(@"Body:\n%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
             }
             NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             if([jsonDict objectForKey:@"data"] != nil)
             {
              //   entry = [[TGLTimeEntry alloc] initWithDictionary:jsonDict[@"data"]];
              //   NSLog(@"Time Entry: %@",[entry logData]);
             }
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             completion(entry,error);
         });
         
     }];
    
}

-(void)deleteTimeEntry:(NSInteger)entryId withCompletion:(void (^)(NSError *))completion
{
    NSString* url = [NSString stringWithFormat:@"%@%@/%ld",BASE_URL,@"/time_entries",(long)entryId];
    [self performRequest:url withHttpMethod:Delete withParams:nil withData:nil withCompletion:^(NSData *data, NSURLResponse *response, NSError *error)
     {
         if (response != nil)
         {
             if([response isKindOfClass:[NSHTTPURLResponse class]])
             {
                 NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
                 NSLog(@"Received response code %ld", (long)httpResponse.statusCode);
                 NSLog(@"Body:\n%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
             }
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             completion(error);
         });
         
     }];
}

-(void)updateTimeEntry:(TGLTimeEntry *)update withCompletion:(void (^)(TGLTimeEntry *, NSError *))completion
{
    NSString* url = [NSString stringWithFormat:@"%@%@/%ld",BASE_URL,@"/time_entries",update.entryId];
    NSError* serializationError = nil;
    [self performRequest:url withHttpMethod:Put withParams:nil withData:[NSJSONSerialization dataWithJSONObject:[update toJson] options:0 error:&serializationError] withCompletion:^(NSData *data, NSURLResponse *response, NSError *error)
     {
         TGLTimeEntry* entry;
         if (response != nil)
         {
             if([response isKindOfClass:[NSHTTPURLResponse class]])
             {
                 NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
                 NSLog(@"Received response code %ld", (long)httpResponse.statusCode);
                 NSLog(@"Body:\n%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
             }
             NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             if([jsonDict objectForKey:@"data"] != nil)
             {
                    entry = [[TGLTimeEntry alloc] initWithDictionary:jsonDict[@"data"]];
             }
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             completion(entry,error);
         });
         
     }];
}

-(void)getTasks:(NSInteger)projectId withCompletion:(void (^)(NSArray<TGLTask *> *, NSError *))completion
{
    NSString* url = [NSString stringWithFormat:@"%@%@%ld%@",BASE_URL,@"/projects/",(long)projectId,@"/tasks"];
    [self performRequest:url withHttpMethod:Get withParams:nil withData:nil withCompletion:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSMutableArray<TGLTask*>* results = [[NSMutableArray alloc] init];
        if (response != nil)
        {
            if([response isKindOfClass:[NSHTTPURLResponse class]])
            {
                NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
                NSLog(@"Received response code %ld", (long)httpResponse.statusCode);
                NSLog(@"Body:\n%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            }
            NSArray<NSDictionary*> *tasks = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if(tasks != nil)
            {
                for(NSDictionary* entryJson in tasks)
                {
                    [results addObject:[[TGLTask alloc] initWithDictionary:entryJson]];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(results,error);
        });
        
    }];
    
}

@end
