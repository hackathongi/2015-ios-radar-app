//
//  JobTableViewCell.h
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *jobImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;

- (void) bindCellWithTitle:(NSString*)title description:(NSString*)description imageURL:(NSURL*)imageURL city:(NSString*)city endDate:(NSDate*)endDate;

+ (CGFloat) getRowHeight;
+ (NSString*) cellIdentifier;

@end