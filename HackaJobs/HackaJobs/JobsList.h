//
//  JobsList.h
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Job.h"

@interface JobsList : NSObject

@property (nonatomic, strong) NSArray *items;

- (id) initWithArray:(NSArray*)array;

@end
