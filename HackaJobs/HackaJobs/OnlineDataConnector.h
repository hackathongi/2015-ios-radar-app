//
//  JobsListViewController.h
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <Foundation/Foundation.h>

#import "JobsList.h"

@interface OnlineDataConnector : AFHTTPSessionManager

+ (instancetype)sharedInstance;
- (void) cancelCurrentRequests;

#pragma mark - Manage Errors
+ (NSError*) defaultErrorOnCallWS;
+ (NSError*) errorWithMessage:(NSString*)message andCode:(NSInteger)errorCode;

#pragma mark - Jobs
- (void) getJobsWithSuccess:(void (^)(JobsList *jobsList))successBlock
                    failure:(void (^)(NSError *error))failureBlock;

@end
