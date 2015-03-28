//
//  JobsListViewController.m
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "JobsListViewController.h"
#import "JobTableViewCell.h"

@interface JobsListViewController ()

@end

@implementation JobsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:NSLocalizedString(@"application.name", nil)];
    
    [_tableView registerClass:[JobTableViewCell class] forCellReuseIdentifier:[JobTableViewCell cellIdentifier]];
    [_tableView registerNib:[UINib nibWithNibName:@"JobTableViewCell" bundle:nil] forCellReuseIdentifier:[JobTableViewCell cellIdentifier]];
    [_tableView setRowHeight:[JobTableViewCell getRowHeight]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobTableViewCell *jobCell = [tableView dequeueReusableCellWithIdentifier:[JobTableViewCell cellIdentifier] forIndexPath:indexPath];
    
    [jobCell bindCellWithTitle:@"Title" description:@"Description" imageURL:nil city:@"Girona" endDate:[NSDate date]];
    
    [jobCell setSelectionStyle:UITableViewCellSelectionStyleGray];
    [jobCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return  jobCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}


@end
