//
//  NSDictionary+Utility.m
//  GlamERP
//
//  Created by Javier Campaña Pulido on 30/01/14.
//  Copyright (c) 2014 Ingenium Mobile Studio, S.L. All rights reserved.
//

#import "NSDictionary+Utility.h"

@implementation NSDictionary (Utility)

- (id)objectForKeyNotNull:(NSString *)key
{
    
    id object = [self objectForKey:key];
    
    if (object == [NSNull null])
        return nil;
    
    return object;
}

@end
