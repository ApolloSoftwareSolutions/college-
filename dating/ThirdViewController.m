//
//  ThirdViewController.m
//  college+
//
//  Created by Amit Barman on 4/8/12.
//  Copyright (c) 2012 Apollo Software. All rights reserved.
//

#import "ThirdViewController.h"

@implementation ThirdViewController
@synthesize wWw;

NSString *str;
int nextVal;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Search Colleges", @"Search Colleges");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (IBAction)nextValue
{ 
    if (nextVal > 25) nextVal = -1;
    
    nextVal++;
    
    NSString *tit = [NSString stringWithFormat:@"Search Results for %@", [collegeName text]];
    [collegeTitle setText:tit];
    collegeTitle.text = tit;
    
    label2.text = @"searching colleges...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(searchCollege) withObject:nil afterDelay:0.01];
    
}

- (IBAction)prevValue
{ 
    if (nextVal == 0) nextVal = 1;
    
    nextVal--;
    
    NSString *tit = [NSString stringWithFormat:@"Search Results for %@", [collegeName text]];
    [collegeTitle setText:tit];
 
    collegeTitle.text = tit;
    
    label2.text = @"searching colleges...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(searchCollege) withObject:nil afterDelay:0.01];
    
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
- (IBAction) smsLoad
{
    label2.text = @"loading SMS...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(sms) withObject:nil afterDelay:0.01];

}

- (IBAction)loadCollege
{
    label2.text = @"loading college...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(loadCollege1) withObject:nil afterDelay:0.01];
}
- (IBAction)copyCollege
{
    NSString *outputText = [[NSString alloc] initWithFormat:@"%@: %@ URL:%@",collegeTitle.text,lblInfo.text,lbllink.text];
    
    UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];
    appPasteBoard.persistent = YES;
    [appPasteBoard setString:outputText];
    
    UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"college+: College Info" message:@"College Info link copied to clipboard" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
    
    [fullAlert show];
}

- (IBAction) mailLoad
{
    label2.text = @"loading e-mail...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(mail) withObject:nil afterDelay:0.01];
    
}

- (void) mail
{
    NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [collegeDesc text]];
    int numLtrs = [urlpath length];
    
    
    
    if (numLtrs > 1)
    {    
        NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [collegeDesc text]];
        NSString *urlString = [NSString stringWithFormat:urlpath];
        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
        [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1" forHTTPHeaderField:@"User-Agent"];
        
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self; 
        
        NSString *subText = [[NSString alloc] initWithFormat:@"college+: %@",collegeTitle.text];
        NSString *msgText = [[NSString alloc] initWithFormat:@"<a href=\"%@\"></a><br>%@",lbllink.text,collegeDesc.text];
        
        [picker setSubject:subText];
        [picker setMessageBody:msgText isHTML:YES];
        picker.navigationBar.barStyle = UIBarStyleDefault; 
        [self presentModalViewController:picker animated:YES];
    }
    else
    {
        UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"college+: College Info" message:@"College Info not available or results do not exist." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        nextVal = 0;
        
        [fullAlert show];
        
    }
    
    
    activityIndicator.hidden = 1;label2.hidden=1;
    
    
}

- (void) sms
{
    
    NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [collegeDesc text]];
    int numLtrs = [urlpath length];
    
    if (numLtrs > 1)
    {  
        @try
        {
            NSString *outputText = [[NSString alloc] initWithFormat:@"URL: %@ %@ ",lbllink.text,lblInfo.text];
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sms:11111"]]){
                //do stuff for sms
                MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
                picker.messageComposeDelegate = self;
                
                //picker.recipients = [NSArray arrayWithObject:@"123456789"];   // your recipient number or self for testing
                picker.body = outputText;
                [activityIndicator stopAnimating];
                
                [self presentModalViewController:picker animated:YES];
                [picker release];
                
            }else{
                [activityIndicator stopAnimating];
                NSLog(@"I don't suport sms");
                UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"college+: SMS" message:@"Sorry. I don't support SMS™ on this device." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
                
                [fullAlert show];
            }
        }
        @catch (NSException *e) {
            UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"college+: SMS" message:@"Sorry. I don't support SMS™ on this device." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
            
            [fullAlert show];
            
        }
    }
    else
    {
               UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"college+: College Info" message:@"College Info not available or results do not exist." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
         nextVal = 0;
        
        [fullAlert show];
        
    }
    
    [activityIndicator stopAnimating];
    activityIndicator.hidden = 1;label2.hidden=1;
    
    
}

- (void) loadCollege1
{
    wWw.hidden = false;
    NSString *request = [NSString stringWithFormat:@"http://www.fatsecret.com/calories-nutrition/search?q=%@&pg=%d",[collegeName text],nextVal];
   
    NSString *escapedUrl = [request   
                            stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *URL = [NSURL URLWithString:escapedUrl];
    
    NSError *error;
    NSString *XML = [NSString stringWithContentsOfURL:URL encoding:NSASCIIStringEncoding error:&error];
    
    @try {
        [collegeDesc setText:@""];
        
        NSString *link = [[[[XML componentsSeparatedByString:@"prominent\" href=\""] objectAtIndex:1] componentsSeparatedByString:@"\""] objectAtIndex:0];
        
        str = [[[[XML componentsSeparatedByString:@"- Calories"] objectAtIndex:1] componentsSeparatedByString:@"| Protein: "] objectAtIndex:0];
   
        NSString *str2 = [NSString stringWithFormat:@"Calories%@",str];
        
        [lblInfo setText:str2];
        
        NSLog(@"Request: %@", str);
        NSString *request = [NSString stringWithFormat:@"http://www.fatsecret.com/calories-nutrition%@",link];
        
        [lbllink setText:request];

        NSLog(@"Request: %@", request);

        NSString *escapedUrl = [request   
                                stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *URL = [NSURL URLWithString:escapedUrl];
        
        NSError *error;
        NSString *XML = [NSString stringWithContentsOfURL:URL encoding:NSASCIIStringEncoding error:&error];
        
        NSString *link2 = [[[[XML componentsSeparatedByString:@"<div class=\"nutpanel\">"] objectAtIndex:1] componentsSeparatedByString:@"Your daily values "] objectAtIndex:0];
       
        NSString *chart = [[[[XML componentsSeparatedByString:@"cfp_breakdown_container\" style=\"width:255px\">"] objectAtIndex:1] componentsSeparatedByString:@"</table>"] objectAtIndex:0];
        
        chart = [chart stringByReplacingOccurrencesOfString:@"/static/" withString:@"http://www.fatsecret.com/static/"]; 
        
        NSString *title = [[[[XML componentsSeparatedByString:@"<title>"] objectAtIndex:1] componentsSeparatedByString:@"</title>"] objectAtIndex:0];
        
        NSLog(@"%@", link2);
        
           NSLog(@"%@", title);
        title = [title stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""]; 
        title = [title stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; 
        [collegeTitle setText:title];
        
        //http://www.fatsecret.com/static/css/default_16.css?v=3
        //
        
        
        NSString* wwwTextAppend = [NSString stringWithFormat:@"<link rel=\"stylesheet\" href=\"http://www.fatsecret.com/static/css/default_16.css?v=3\" type=\"text/css\"/>"];
        
        NSString* wwwText = [NSString stringWithFormat:@"%@<font face=\"Arial\">%@</font><br><br>%@", wwwTextAppend,link2,chart];
        [collegeDesc setText:wwwText];
        
        [wWw loadHTMLString:wwwText baseURL:nil];
        
        //[wWw loadHTMLString:translation baseURL:nil];
        
                
        NSLog(@"%@",request);
        
    }
    @catch (NSException *e) {
        NSString *answer = @"Invalid Query.";
        
             [self performSelector:@selector(clear) withObject:nil afterDelay:0.01];
        
        NSLog(@"%@", answer);
        //[collegeDesc setText:answer];
          UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"college+: College Info" message:@"College Info not available or results do not exist." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [fullAlert show];
        
         nextVal = 0;
        NSLog(@"Exception: %@", e);
    }
    activityIndicator.hidden = 1;label2.hidden=1;   
     
    [collegeName resignFirstResponder];
}

-(IBAction)dismissKeyboard: (id)sender {
    [sender resignFirstResponder];

    
    NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [collegeName text]];
    int numLtrs = [urlpath length];
    
    
     nextVal = 0;
    if (numLtrs > 1)
    {    
    label2.text = @"searching colleges...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(search) withObject:nil afterDelay:0.01];
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (IBAction)search
{
    
    nextVal = 0;
    
    NSString *tit = [NSString stringWithFormat:@"Search Results for %@", [collegeName text]];
 
    [collegeTitle setText:tit];
    collegeTitle.text = tit;
    
    label2.text = @"searching colleges...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(searchCollege) withObject:nil afterDelay:0.01];
  }

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
  
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        
        NSURL *URL = [request URL]; 
        NSString *urlString = [URL absoluteString];
        NSLog(@"url is: %@ ", urlString);
     
        if([urlString hasPrefix:@"http"])
        {
        
        NSString *tit = [NSString stringWithFormat:@"%@",urlString];
        
        @try {
            [collegeDesc setText:@""];
            
 
            NSString *request = [NSString stringWithFormat:@"%@",tit];
            
            [lbllink setText:request];
            
            NSLog(@"Request: %@", request);
            
            NSString *escapedUrl = [request   
                                    stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSURL *URL = [NSURL URLWithString:escapedUrl];
            
            NSError *error;
            NSString *XML = [NSString stringWithContentsOfURL:URL encoding:NSASCIIStringEncoding error:&error];
            
            XML = [XML stringByReplacingOccurrencesOfString:@"<a " withString:@"<p "]; 
            XML = [XML stringByReplacingOccurrencesOfString:@"</a>" withString:@"</f>"]; 
            
            
            NSString *desc = [[[[XML componentsSeparatedByString:@"<div class=\"aside aside-quick-stats\">"] objectAtIndex:1] componentsSeparatedByString:@"</div>"] objectAtIndex:0];
            NSString *image;
            
              @try {
            image = [[[[XML componentsSeparatedByString:@"<dt>Photos</dt>"] objectAtIndex:1] componentsSeparatedByString:@"</dd>"] objectAtIndex:0];
           
            image = [image stringByReplacingOccurrencesOfString:@"src=\"" withString:@"src=\"http://colleges.usnews.rankingsandreviews.com"]; 
              }
            @catch (NSException *e) {
                image = @"<dd>";
                
             
            }
            NSString *title = [[[[XML componentsSeparatedByString:@"<meta name=\"usn_name\" content=\""] objectAtIndex:1] componentsSeparatedByString:@"\""] objectAtIndex:0];
            
            NSString *summary = [[[[XML componentsSeparatedByString:@"<h3 class=\"Summary even\">"] objectAtIndex:1] componentsSeparatedByString:@"</table>"] objectAtIndex:0];
            
            NSLog(@"%@", title);
        
            [collegeTitle setText:title];
  
            
            NSString* wwwTextAppend = [NSString stringWithFormat:@"<link type=\"text/css\" rel=\"stylesheet\" media=\"all\" href=\"http://static.usnews.com/css/cin-global.css\" /><link type=\"text/css\" rel=\"stylesheet\" media=\"all\" href=\"http://static.usnews.com/css/cin-education.css\" /><link type=\"text/css\" rel=\"stylesheet\" media=\"all\" href=\"http://static.usnews.com/css/education-colleges-school.css\" /><div class=\"aside aside-quick-stats\">"];
            
            NSString* wwwText = [NSString stringWithFormat:@"%@%@</div><h3 class=\"Summary even\">%@</table>%@</dd>", wwwTextAppend,desc,summary,image];
           
            [collegeDesc setText:wwwText];
            
            [wWw loadHTMLString:wwwText baseURL:nil];
            
            NSLog(@"%@",request);
            
        }
        @catch (NSException *e) {
            NSString *answer = @"Invalid Query.";
            
            [self performSelector:@selector(clear) withObject:nil afterDelay:0.01];
            
            NSLog(@"%@", answer);
            //[collegeDesc setText:answer];
                     UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"college+: College Info" message:@"College Info not available or results do not exist." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
             nextVal = 0;
            [fullAlert show];
            NSLog(@"Exception: %@", e);
        }
        activityIndicator.hidden = 1;label2.hidden=1;  
        }
    }   
    return YES;   
}


- (void)searchCollege
{
    wWw.hidden = false;
       NSString *request = [NSString stringWithFormat:@"http://colleges.usnews.rankingsandreviews.com/best-colleges/search.result/name+%@",[collegeName text]];
    
    [lbllink setText:request];
    [lblInfo setText:@"No Info"]; 
    
    NSString *escapedUrl = [request   
                            stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *URL = [NSURL URLWithString:escapedUrl];
    
    NSError *error;
    NSString *XML = [NSString stringWithContentsOfURL:URL encoding:NSASCIIStringEncoding error:&error];
    
    @try {
        [collegeDesc setText:@""];
        
        NSString *link = [[[[XML componentsSeparatedByString:@"<table class=\"searchresult\">"] objectAtIndex:1] componentsSeparatedByString:@"</table>"] objectAtIndex:0];
   
        link = [link stringByReplacingOccurrencesOfString:@"<td class=\"col0\">" withString:@"<tp class=\"col0\">"]; 
        link = [link stringByReplacingOccurrencesOfString:@"<td class=\"lockeddata col6\">" withString:@"<tp class=\"col0\">"]; 
        link = [link stringByReplacingOccurrencesOfString:@"<td class=\"lockeddata col7\">" withString:@"<tp class=\"col0\">"]; 
        
        link = [link stringByReplacingOccurrencesOfString:@"></td>" withString:@"></tp>"]; 
   
        link = [link stringByReplacingOccurrencesOfString:@"type=\"checkbox\" value" withString:@"poop"]; 
        
        link = [link stringByReplacingOccurrencesOfString:@"input" withString:@"throughput"]; 
        
        link = [link stringByReplacingOccurrencesOfString:@"<div class=\"lockeddataicon\">&nbsp;</div>" withString:@""]; 
        
        //<div class="lockeddataicon">&nbsp;</div>
          link = [link stringByReplacingOccurrencesOfString:@"href=\"/" withString:@"href=\"http://colleges.usnews.rankingsandreviews.com/"]; 
        
        NSString* wwwTextAppend = [NSString stringWithFormat:@"<link type=\"text/css\" rel=\"stylesheet\" media=\"all\" href=\"http://static.usnews.com/css/education-colleges-search.css\" /><link type=\"text/css\" rel=\"stylesheet\" media=\"all\" href=\"http://static.usnews.com/css/cin-global.css\" /><table class=\"searchresult\">"];
        
        NSString *HTML = [NSString stringWithFormat:@"%@%@</table>",wwwTextAppend,link];
        
        [collegeDesc setText:HTML];
        
        [wWw loadHTMLString:HTML baseURL:nil];
        
        NSLog(@"%@",request);
        
    }
    @catch (NSException *e) {
        NSString *answer = @"Invalid Query.";
        
        [self performSelector:@selector(clear) withObject:nil afterDelay:0.01];
        
        NSLog(@"%@", answer);
        //[collegeDesc setText:answer];
         UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"college+: College Info" message:@"College Info not available or results do not exist." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
         nextVal = 0;
        [fullAlert show];
        NSLog(@"Exception: %@", e);
    }
    activityIndicator.hidden = 1;label2.hidden=1;   
    
    [collegeName resignFirstResponder];

}

- (IBAction)clear
{
    collegeDesc.text = @"";
    collegeTitle.text = @"";
    collegeName.text = @"";
    wWw.Hidden = true;
     nextVal = 0;
    NSString* wwwText = @"";
    [collegeName resignFirstResponder];
    
    [wWw loadHTMLString:wwwText baseURL:nil];
    
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1:
        {
            NSString *outputText = [[NSString alloc] initWithFormat:@"%@: %@ URL:%@",collegeTitle.text,lblInfo.text,lbllink.text];
            
            UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];
            appPasteBoard.persistent = YES;
            [appPasteBoard setString:outputText];
            
            
            
            switch (buttonIndex) {
                    
                    
                case 0: 
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/dialog/feed?app_id=376378949068881&redirect_uri=http%3A//www.facebook.com/apps/application.php?id=376378949068881&to&message=@[199116963445570%3A2048%3ACHANGE_OR_ALTER_THIS_WITH_YOUR_OWN_YOUR_OWN_MESSAGE]&display=touch"]];
                    
                    break;
                case 1: 
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.myspace.com/Modules/PostTo/Pages/?t=college%20plus:click%20paste%20on%20text%20box&c=message&l=1"]];
                    
                    break;                        
                case 2:
                
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/intent/tweet?source=webclient&text="]];
                    
                    break; 
                case 3:   
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://m.google.com/app/plus/x/976fbnrafv3e/?content=Paste%20Here&v=compose&pli=1&login=1"]];
                case 4:
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.tumblr.com/share"]];
                    
                    break;
                default: 
                    break; 
                        
            }
            break;  
        }
        default:break;
    }
}

- (IBAction)share
{
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Sharing option (the food name and url info is copied to your clipboard. Click the textbox and select paste):" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Share on Facebook",
                            @"Share on MySpace",
                            @"Share on Twitter",
                            @"Share on Google+",
                            @"Share on tumblr",
                            nil];
    
    [[[popup valueForKey:@"_buttons"] objectAtIndex:0] setImage:[UIImage imageNamed:@"facebook-icon.png"] forState:UIControlStateNormal];
    [[[popup valueForKey:@"_buttons"] objectAtIndex:1] setImage:[UIImage imageNamed:@"myspace-icon.png"] forState:UIControlStateNormal];
    [[[popup valueForKey:@"_buttons"] objectAtIndex:2] setImage:[UIImage imageNamed:@"twitter-icon.png"] forState:UIControlStateNormal];
    [[[popup valueForKey:@"_buttons"] objectAtIndex:3] setImage:[UIImage imageNamed:@"google-icon.png"] forState:UIControlStateNormal];
    [[[popup valueForKey:@"_buttons"] objectAtIndex:4] setImage:[UIImage imageNamed:@"Tumblr-icon.png"] forState:UIControlStateNormal];
    
    popup.tag = 1;
    
    [popup showInView:[UIApplication sharedApplication].keyWindow];
    
    //[popup release];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {

    }
}

#pragma mark - View lifecycle

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{   
    activityIndicator.hidden = true;
    nextVal = 0;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    wWw.delegate = self;
    [super viewDidLoad];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
