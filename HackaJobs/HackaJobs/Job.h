//
//  Job.h
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Owner.h"

@interface Job : NSObject

@property (nonatomic) NSInteger ident;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSURL *pictureURL;
@property (nonatomic, strong) NSURL *jobURL;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
@property (nonatomic, strong) Owner *owner;

- (id) initWithDictionary:(NSDictionary*)dictionary;
- (BOOL) hasLatLong;
- (NSString*) applyURLString;

@end
