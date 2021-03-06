//
//  JobDetailViewController.m
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "JobDetailViewController.h"
#import <SVWebViewController/SVWebViewController.h>

@interface JobDetailViewController ()

@end

@implementation JobDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:NSLocalizedString(@"job.detail", nil)];
    
    [_containerView setBackgroundColor:[UIColor whiteColor]];
    [_applyJobButton setBackgroundColor:[UIColor colorWithRed:217.0f/255.0f green:35.0f/255.0f blue:22.0f/255.0f alpha:1.0f]];
    
    [_imageView.layer setCornerRadius:40.0f];
    [_imageView.layer setMasksToBounds:NO];
    [_imageView setClipsToBounds:TRUE];
    
    [_applyJobButton setTitle:NSLocalizedString(@"job.apply", nil) forState:UIControlStateNormal];
    [_applyJobButton.layer setCornerRadius:10.0f];
    [_applyJobButton.layer setMasksToBounds:NO];
    [_applyJobButton setClipsToBounds:TRUE];
    
    [self loadData];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [_scrollView setContentSize:_containerView.frame.size];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Data
- (void) loadData
{
    [_titleLabel setText:_selectedJob.title];
    [_cityLabel setText:_selectedJob.city];
    [_ownerLabel setText:_selectedJob.owner.name];
    [_descriptionLabel setText:_selectedJob.desc];
    [_dateLabel setText:[[[FormatterManager sharedInstance] shortDateNoTimeDateFormatter] stringFromDate:_selectedJob.endDate]];
    [_imageView setImageWithURL:_selectedJob.pictureURL];
}

#pragma mark - Button Actions
- (IBAction)applyJob:(id)sender
{    
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:[_selectedJob applyURLString]];
    [webViewController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [webViewController.navigationBar setTranslucent:FALSE];
    [webViewController setBarsTintColor:[UIColor whiteColor]];
    
    [self presentViewController:webViewController animated:YES completion:NULL];
}

@end
