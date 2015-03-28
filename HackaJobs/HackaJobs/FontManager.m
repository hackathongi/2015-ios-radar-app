//
//  FontManager.m
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "FontManager.h"

@implementation FontManager

+ (UIFont*) titleFont
{
    return [UIFont boldSystemFontOfSize:16.0f];
}

+ (UIFont*) defaultFont
{
    return [UIFont systemFontOfSize:14.0f];
}

+ (UIFont*) buttonFont
{
    return [UIFont systemFontOfSize:18.0f];
}

+ (UIFont*) italicFont
{
    return [UIFont italicSystemFontOfSize:14.0f];
}
@end
