//
//  JobTableViewCell.m
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "JobTableViewCell.h"
@implementation JobTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [_titleLabel setFont:[FontManager titleFont]];
    [_descriptionLabel setFont:[FontManager defaultFont]];
    [_cityLabel setFont:[FontManager defaultFont]];
    [_endDateLabel setFont:[FontManager defaultFont]];
    
    [_jobImage.layer setCornerRadius:40.0f];
    [_jobImage.layer setMasksToBounds:NO];
    [_jobImage setClipsToBounds:TRUE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) bindCellWithTitle:(NSString*)title description:(NSString*)description imageURL:(NSURL*)imageURL city:(NSString*)city endDate:(NSDate*)endDate
{
    [_titleLabel setText:title];
    [_descriptionLabel setText:description];
    [_cityLabel setText:city];
    [_endDateLabel setText:[[[FormatterManager sharedInstance] shortDateNoTimeDateFormatter] stringFromDate:endDate]];
    [_jobImage setImageWithURL:imageURL];
}

+ (CGFloat) getRowHeight
{
    return 97.0f;
}

+ (NSString*) cellIdentifier
{
    return @"JobTableViewCell";
}

@end
