//
//  JobsListViewController.h
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//


#import "SuperViewController.h"

@interface SuperViewController ()

@end

@implementation SuperViewController

#pragma mark - ActivityIndicator
- (void) showActivityIndicator
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = NSLocalizedString(@"loading", nil);
}

- (void) showActivityIndicatorSync
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = NSLocalizedString(@"sync", nil);
}

- (void) hideActivityIndicator
{
    [hud hide:YES];
}

#pragma mark - AlertView
- (void) showMessage:(NSString*)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"message", nil)
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
    
    [alertView show];
}

- (void) showAlert:(NSString*)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert", nil)
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
    
    [alertView show];
}

@end
