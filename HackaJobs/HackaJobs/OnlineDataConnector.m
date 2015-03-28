//
//  JobsListViewController.h
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "OnlineDataConnector.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFNetworking.h"

#import "JobsList.h"

@implementation OnlineDataConnector

#pragma mark - Manage Errors
+ (NSError*) defaultErrorOnCallWS
{
    return [self errorWithMessage:NSLocalizedString(@"error.errorCallingWS", nil) andCode:400];
}

+ (NSError*) errorWithMessage:(NSString*)message andCode:(NSInteger)errorCode
{
    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
    [errorDetail setValue:message forKey:NSLocalizedDescriptionKey];
    
    NSError* error = [NSError errorWithDomain:NSLocalizedString(@"application.name", nil) code:errorCode userInfo:errorDetail];
    
    return error;
}

#pragma mark - Init
+ (instancetype)sharedInstance
{
    static OnlineDataConnector *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        // Network activity indicator manager setup
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        // Session configuration setup
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024     // 10MB. memory cache
                                                          diskCapacity:50 * 1024 * 1024     // 50MB. on disk cache
                                                              diskPath:nil];
        
        sessionConfiguration.URLCache = cache;
        sessionConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
        sessionConfiguration.timeoutIntervalForRequest = 30.0f;
        
        // Initialize the session
        _sharedInstance = [[OnlineDataConnector alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL] sessionConfiguration:sessionConfiguration];
    });
    
    return _sharedInstance;
}

// Redefinition of method for Init Reachability & Serialization
- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (!self) return nil;
    
    // Configuraciones adicionales de la sesión
    self.requestSerializer = [AFPropertyListRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
    
    // Reachability
    [self.reachabilityManager startMonitoring];
    
    // Allow Invalid Certificates
    [self.securityPolicy setAllowInvalidCertificates:YES];
    
    return self;
}

- (void) cancelCurrentRequests
{
    for (NSURLSessionTask* task in self.tasks)
    {
        [task cancel];
    }
}

#pragma mark - Jobs
- (void) getJobsWithSuccess:(void (^)(JobsList *jobsList))successBlock
                    failure:(void (^)(NSError *error))failureBlock
{
    [self GET:JOBS_URL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         JobsList *jobs = [[JobsList alloc] initWithArray:responseObject];
         
         if (successBlock)
             successBlock(jobs);
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         if (failureBlock)
             failureBlock([OnlineDataConnector defaultErrorOnCallWS]);
     }];
}
@end
