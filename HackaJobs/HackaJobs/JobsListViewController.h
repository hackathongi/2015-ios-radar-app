//
//  JobsListViewController.h
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "SuperViewController.h"
#import "JobsList.h"

@interface JobsListViewController : SuperViewController <UITableViewDataSource, UITableViewDelegate>
{
    JobsList *jobs;
    UIRefreshControl *refreshControl;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
