//
//  JobsMapViewController.h
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "SuperViewController.h"
#import "JobsList.h"

@interface JobsMapViewController : SuperViewController <MKMapViewDelegate>
{
    NSMutableArray *mapPoints;
}

@property (nonatomic, strong) JobsList *jobsList;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end