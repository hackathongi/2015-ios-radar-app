//
//  Owner.h
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Owner : NSObject

@property (nonatomic) NSInteger ident;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;

- (id) initWithDictionary:(NSDictionary*)dictionary;

@end
