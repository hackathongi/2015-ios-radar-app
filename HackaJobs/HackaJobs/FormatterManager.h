//
//  FormatterManager.h
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormatterManager : NSObject

@property (nonatomic, strong) NSDateFormatter *shortDateNoTimeDateFormatter;

+ (instancetype)sharedInstance;

- (NSDateFormatter*) shortDateNoTimeDateFormatter;

@end
