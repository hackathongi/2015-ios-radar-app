//
//  JobsListViewController.h
//  HackaJobs
//
//  Created by Javier Campaña Pulido on 28/3/15.
//  Copyright (c) 2015 Hackathon Girona. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class FUIAlertView;

@interface SuperViewController : UIViewController
{
    MBProgressHUD* hud;
}

#pragma mark - ActivityIndicator
- (void) showActivityIndicator;
- (void) hideActivityIndicator;

#pragma mark - AlertView
- (void) showMessage:(NSString*)message;
- (void) showAlert:(NSString*)message;

@end
