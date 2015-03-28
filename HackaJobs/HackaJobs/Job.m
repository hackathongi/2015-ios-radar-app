//
//  Job.m
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "Job.h"

@implementation Job

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    if (!self)
    {
        self = [super init];
    }

    if ([dictionary isKindOfClass:[NSDictionary class]])
    {
        self.title = [dictionary objectForKeyNotNull:@"title"];
        self.desc = [dictionary objectForKeyNotNull:@"description"];
        self.city = [dictionary objectForKeyNotNull:@"city"];
        
        if ([dictionary objectForKeyNotNull:@"id"])
        {
            self.ident = [[dictionary objectForKeyNotNull:@"id"] integerValue];
        }
        
        if ([dictionary objectForKeyNotNull:@"owner"])
        {
            self.owner = [[Owner alloc] initWithDictionary:[dictionary objectForKeyNotNull:@"owner"]];
        }
        
        if ([dictionary objectForKeyNotNull:@"latitude"])
        {
            self.latitude = [[dictionary objectForKeyNotNull:@"latitude"] floatValue];
        }
        
        if ([dictionary objectForKeyNotNull:@"longitude"])
        {
            self.longitude = [[dictionary objectForKeyNotNull:@"longitude"] floatValue];
        }
        
        if ([dictionary objectForKeyNotNull:@"picture_url"])
        {
            self.pictureURL = [NSURL URLWithString:[dictionary objectForKeyNotNull:@"picture_url"]];
        }
        
        if ([dictionary objectForKeyNotNull:@"start_date"])
        {
            NSString *startDateString = [dictionary objectForKeyNotNull:@"start_date"];
            
            self.startDate = [[[FormatterManager sharedInstance] apiDateFormatter] dateFromString:startDateString];
        }
        
        if ([dictionary objectForKeyNotNull:@"end_date"])
        {
            NSString *startDateString = [dictionary objectForKeyNotNull:@"end_date"];
            
            self.endDate = [[[FormatterManager sharedInstance] apiDateFormatter] dateFromString:startDateString];
        }
        
        if ([dictionary objectForKeyNotNull:@"job_url"])
        {
            self.jobURL = [NSURL URLWithString:[dictionary objectForKeyNotNull:@"job_url"]];
        }
        
        [self reloadLatLongIfNeeded];
    }
    
    return self;
}

- (BOOL) hasLatLong
{
    return _latitude != 0 && _longitude != 0;
}

- (void) reloadLatLongIfNeeded
{
    if (![self hasLatLong])
    {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:[self city]
                     completionHandler:^(NSArray* placemarks, NSError* error)
         {
             for (CLPlacemark* aPlacemark in placemarks)
             {
                 // Process the placemark.
                 self.latitude = aPlacemark.location.coordinate.latitude;
                 self.longitude = aPlacemark.location.coordinate.longitude;
             }
         }];
    }
}

- (NSString*) applyURLString
{
    return [NSString stringWithFormat:@"%@%@%i", INFO_URL, JOB_PAGE_URL, self.ident];
}

@end
