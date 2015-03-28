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
#import "JobsMapViewController.h"
#import <SVWebViewController/SVWebViewController.h>

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
    
    UIBarButtonItem *buttonShowMap = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"location"] style:UIBarButtonItemStylePlain target:self action:@selector(showMap)];
    [self.navigationItem setRightBarButtonItem:buttonShowMap];
    
    UIBarButtonItem *buttonShowInfo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"info"] style:UIBarButtonItemStylePlain target:self action:@selector(showInfo)];
    [self.navigationItem setLeftBarButtonItem:buttonShowInfo];
    
    [self loadData:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Show Map & info
- (void) showMap
{
    JobsMapViewController *jobsMapVC = [[JobsMapViewController alloc] initWithNibName:@"JobsMapView" bundle:nil];
    [jobsMapVC setJobsList:jobs];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:jobsMapVC];
    [navController.navigationBar setTranslucent:FALSE];
    
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:navController animated:TRUE completion:nil];
}

- (void) showInfo
{
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:INFO_URL];
    [webViewController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [webViewController.navigationBar setTranslucent:FALSE];
    [webViewController setBarsTintColor:[UIColor whiteColor]];
    
    [self presentViewController:webViewController animated:YES completion:NULL];
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
