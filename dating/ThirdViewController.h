//
//  ThirdViewController.h
//  college+
//
//  Created by Amit Barman on 4/8/12.
//  Copyright (c) 2012 Apollo Software. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface ThirdViewController : UIViewController <UIWebViewDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>
{
    IBOutlet UILabel *collegeDesc,*collegeTitle;  
    IBOutlet UITextField *collegeName;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UILabel *label2,*lbllink,*lblInfo;
    IBOutlet UIWebView *wWw;
}
- (IBAction)loadFood;
- (IBAction)search;
- (IBAction)copyCollege;
- (IBAction)smsLoad;
- (IBAction)dismissKeyboard: (id)sender;
- (IBAction)mailLoad;
- (IBAction)share;
- (IBAction)clear;
@property (nonatomic, retain) UIWebView *wWw;
@end
