//
//  FourthViewController.h
//  college+
//
//  Created by Amit Barman on 4/8/12.
//  Copyright (c) 2012 Apollo Software. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface FourthViewController : UIViewController <UIActionSheetDelegate,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

- (IBAction) supportButton;
- (IBAction) aboutButton;

@end
