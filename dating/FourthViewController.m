//
//  FourthViewController.m
//  college+
//
//  Created by Amit Barman on 4/8/12.
//  Copyright (c) 2012 Apollo Software. All rights reserved.
//

#import "FourthViewController.h"

@implementation FourthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Support", @"Support");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

+(BOOL) isIPad {
    BOOL isIPad=NO;
    NSString* model = [UIDevice currentDevice].model;
    if ([model rangeOfString:@"iPad"].location != NSNotFound) {
        return YES;
    }
    return isIPad;
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    //message.hidden = NO;
    switch (result)
    {
        case MessageComposeResultCancelled:
            //        message.text = @"Result: canceled";
            NSLog(@"Result: canceled");
            break;
        case MessageComposeResultSent:
            //      message.text = @"Result: sent";
            NSLog(@"Result: sent");
            break;
        case MessageComposeResultFailed:
            //    message.text = @"Result: failed";
            NSLog(@"Result: failed");
            break;
        default:
            //  message.text = @"Result: not sent";
            NSLog(@"Result: not sent");
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)supportButton
{
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    picker.mailComposeDelegate = self; 
    
    NSString *string = @"support@apolloss.com";// email is dynamic as per 
    
    [picker setToRecipients:[NSArray arrayWithObjects:string, nil]];
    
    
    [picker setToRecipients:[NSArray arrayWithObjects:string, nil]];
    [picker setSubject:@"support for college+"];
    [picker setMessageBody:@"" isHTML:YES];
    picker.navigationBar.barStyle = UIBarStyleDefault; 
    [self presentModalViewController:picker animated:YES];
    [picker release];
}


- (IBAction) aboutButton
{
    UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"About college+" message:@"© Copyright 2012, Apollo Software Solutions, All Rights Reserved. college+™ is a registered trademark of Amit Apollo Barman™." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
    
    [fullAlert show];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
