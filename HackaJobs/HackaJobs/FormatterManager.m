//
//  FormatterManager.m
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "FormatterManager.h"

static dispatch_once_t once;
static id sharedInstance;

@implementation FormatterManager

+ (instancetype)sharedInstance
{
    dispatch_once(&once, ^
                  {
                      sharedInstance = [[FormatterManager alloc] init];
                  });
    
    return sharedInstance;
}

- (NSDateFormatter*) shortDateNoTimeDateFormatter
{
    if (!_shortDateNoTimeDateFormatter)
    {
        _shortDateNoTimeDateFormatter = [[NSDateFormatter alloc] init];
        [_shortDateNoTimeDateFormatter setDateStyle:NSDateFormatterShortStyle];
        [_shortDateNoTimeDateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [_shortDateNoTimeDateFormatter setCalendar:[NSCalendar currentCalendar]];
    }
    
    return _shortDateNoTimeDateFormatter;
}

@end
