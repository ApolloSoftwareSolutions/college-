//
//  FirstViewController.h
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

@interface FirstViewController : UIViewController <UIActionSheetDelegate,MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate,MFMessageComposeViewControllerDelegate,MyCLControllerDelegate>
{
    MyCLController *locationController;
    IBOutlet UILabel *locationLabel;   
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UILabel *label2,*lbname,*lvicinity,*licon;
    IBOutlet UIImageView *iv;
    UIImagePickerController *imagePickerController;
    
    NSString *bname;
    NSString *icon;
    NSString *vicinity;

}
- (IBAction)savePicture;
- (IBAction)findPhoto:(id) sender;
- (IBAction)takePhoto:(id) sender;
- (IBAction)trash;
- (IBAction)smsLoad;
- (IBAction)mailLoad;
- (IBAction)share;
- (IBAction)searchBars;
- (UIImage *)resizeImage:(UIImage *)image;
- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;

@end
