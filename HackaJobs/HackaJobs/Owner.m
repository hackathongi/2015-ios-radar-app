//
//  Owner.m
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "Owner.h"

@implementation Owner

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    if (!self)
    {
        self = [super init];
    }
    
    if ([dictionary isKindOfClass:[NSDictionary class]])
    {
        self.name = [dictionary objectForKeyNotNull:@"name"];
        self.email = [dictionary objectForKeyNotNull:@"email"];

        if ([dictionary objectForKeyNotNull:@"id"])
        {
            self.ident = [[dictionary objectForKeyNotNull:@"id"] integerValue];
        }
    }
    
    return self;
}

@end
