//
//  SecondViewController.h
//  nutrition+
//
//  Created by Amit Barman on 1/4/12.
//  Copyright (c) 2012 Apollo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyCLController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface SecondViewController : UIViewController <UIActionSheetDelegate,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate,MyCLControllerDelegate>{
    MyCLController *locationController;
     IBOutlet UILabel *locationLabel;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UILabel *label2,*lbname,*lvicinity,*licon,*street;
    IBOutlet UIImageView *map;
    IBOutlet UIStepper *zoomer,*pan;
    IBOutlet UIBarButtonItem *toggle;
    IBOutlet UIButton *streetview;
    IBOutlet UIToolbar *toolbar1;
    
    NSString *bname;
    NSString *icon;
    NSString *vicinity;
}
- (IBAction)loadSat;
- (IBAction)loadHybrid;
- (IBAction)zoomMap;
- (IBAction)panStreet;
- (IBAction)smsLoad;
- (IBAction)loadStreet;
- (IBAction)mailLoad;
- (IBAction)share;
- (IBAction)searchBars;
- (IBAction)refresh;
- (IBAction)toggleAPI;

- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;

@end


