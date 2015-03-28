//
//  JobsMapViewController.m
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//

#import "JobsMapViewController.h"
#import "JobDetailViewController.h"
#import <SVWebViewController/SVWebViewController.h>

@interface JobsMapViewController ()

@end

@implementation JobsMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // Do any additional setup after loading the view from its nib.
    [self setTitle:NSLocalizedString(@"application.name", nil)];
    
    UIBarButtonItem *closeMapButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(closeMap)];
    [self.navigationItem setRightBarButtonItem:closeMapButton];
    
    UIBarButtonItem *buttonShowInfo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"info"] style:UIBarButtonItemStylePlain target:self action:@selector(showInfo)];
    [self.navigationItem setLeftBarButtonItem:buttonShowInfo];
    
    [_mapView setDelegate:self];
    
    [self loadMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) closeMap
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void) showInfo
{
    SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithAddress:INFO_URL];
    [webViewController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [webViewController.navigationBar setTranslucent:FALSE];
    [webViewController setBarsTintColor:[UIColor whiteColor]];
    
    [self presentViewController:webViewController animated:YES completion:NULL];
}

#pragma mark - Load Map
- (void) loadMap
{
    mapPoints = [[NSMutableArray alloc] init];
    
    for (Job *job in _jobsList.items)
    {
        if ([job hasLatLong])
        {
            MKPointAnnotation * point = [[MKPointAnnotation alloc] init];
            point.coordinate = CLLocationCoordinate2DMake(job.latitude, job.longitude);
            point.title = job.title;
            point.subtitle = job.desc;
            
            [mapPoints addObject:point];
        }
    }
    
    [self.mapView showAnnotations:mapPoints animated:NO];
}

#pragma mark - MKMapView Delegate
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    NSUInteger index = [mapPoints indexOfObject:annotation];
    MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinLocation"];

    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [infoButton setTag:index];
    newAnnotation.canShowCallout = YES;
    newAnnotation.rightCalloutAccessoryView = infoButton;
    
    return newAnnotation;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    Job *selectedJob = [_jobsList.items objectAtIndex:((UIButton*)control).tag];
    
    JobDetailViewController *jobDetailVC = [[JobDetailViewController alloc] initWithNibName:@"JobDetailView" bundle:nil];
    
    [jobDetailVC setSelectedJob:selectedJob];
    
    [self.navigationController pushViewController:jobDetailVC animated:TRUE];
}

@end
