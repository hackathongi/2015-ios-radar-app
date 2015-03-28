//
//  JobsList.m
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "JobsList.h"

@implementation JobsList

- (id) initWithArray:(NSArray*)array
{
    if (!self)
    {
        self = [super init];
    }
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
    if ([array isKindOfClass:[NSArray class]])
    {
        for (id object in array)
        {
            if ([object isKindOfClass:[NSDictionary class]])
            {
                Job *job = [[Job alloc] initWithDictionary:object];
                
                [mutableArray addObject:job];
            }
        }
    }
    
    self.items = [[NSArray alloc] initWithArray:mutableArray];
    
    return self;
}

@end
