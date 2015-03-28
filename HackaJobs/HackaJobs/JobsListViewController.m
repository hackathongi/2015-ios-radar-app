//
//  JobsListViewController.m
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "JobsListViewController.h"
#import "JobTableViewCell.h"
#import "JobDetailViewController.h"
#import "OnlineDataConnector.h"

@interface JobsListViewController ()

@end

@implementation JobsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:NSLocalizedString(@"application.name", nil)];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadDataFromRefreshControl) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refreshControl];
    
    [_tableView registerClass:[JobTableViewCell class] forCellReuseIdentifier:[JobTableViewCell cellIdentifier]];
    [_tableView registerNib:[UINib nibWithNibName:@"JobTableViewCell" bundle:nil] forCellReuseIdentifier:[JobTableViewCell cellIdentifier]];
    [_tableView setRowHeight:[JobTableViewCell getRowHeight]];
    
    [self loadData:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Data
- (void) loadDataFromRefreshControl
{
    [self loadData:false];
}

- (void) loadData:(BOOL)showingActivityIndicator
{
    jobs = [[JobsList alloc] init];
    
    if (showingActivityIndicator)
        [self showActivityIndicator];
    
    [[OnlineDataConnector sharedInstance] getJobsWithSuccess:^(JobsList *jobsList) {
        
        if (showingActivityIndicator)
            [self hideActivityIndicator];
        else
            [refreshControl endRefreshing];
        
        jobs = jobsList;
        
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        
        if (showingActivityIndicator)
            [self hideActivityIndicator];
        else
            [refreshControl endRefreshing];
        
        [self showAlert:[error localizedDescription]];
    }];
}

#pragma mark UITableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [jobs.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobTableViewCell *jobCell = [tableView dequeueReusableCellWithIdentifier:[JobTableViewCell cellIdentifier] forIndexPath:indexPath];
    
    Job *current = [jobs.items objectAtIndex:[indexPath row]];
    
    [jobCell bindCellWithTitle:current.title description:current.desc imageURL:current.pictureURL city:current.city endDate:current.endDate];
    
    [jobCell setSelectionStyle:UITableViewCellSelectionStyleGray];
    [jobCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return  jobCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
    Job *selectedJob = [jobs.items objectAtIndex:[indexPath row]];
    
    JobDetailViewController *jobDetailVC = [[JobDetailViewController alloc] initWithNibName:@"JobDetailView" bundle:nil];
    
    [jobDetailVC setSelectedJob:selectedJob];

    [self.navigationController pushViewController:jobDetailVC animated:TRUE];
}

@end
