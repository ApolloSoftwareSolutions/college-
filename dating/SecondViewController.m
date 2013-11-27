//
//  SecondViewController.m
//  nutrition+
//
//  Created by Amit Barman on 1/4/12.
//  Copyright (c) 2012 Apollo Software. All rights reserved.
//

#import "SecondViewController.h"
NSString *lat;
NSString *lon;

float barlat;
float barlon;

float latitude, longitude;
NSString *type;
int zoom,pan1;
NSString *URL1,*pic;
NSString *toggle1;


@implementation SecondViewController

+(BOOL) isIPad {
    BOOL isIPad=NO;
    NSString* model = [UIDevice currentDevice].model;
    if ([model rangeOfString:@"iPad"].location != NSNotFound) {
        return YES;
    }
    return isIPad;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Locations", @"Locations");
        self.tabBarItem.image = [UIImage imageNamed:@"globe"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)barShow
{
    
    UIImageView *imageView1;
    imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 286, 200)];
    
    imageView1.contentMode = UIViewContentModeScaleAspectFill;    
    UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"location+: Bar Map" message:@"\n\n\n\n\n\n\n\n\n" delegate:nil cancelButtonTitle:@"Close Image" otherButtonTitles:nil];
    
    NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/staticmap?center=%f,%f&zoom=%d&size=320x323&markers=color:blue|color:blue|label:B|%f,%f&sensor=false&maptype=%@",barlat,barlon,zoom,barlat,barlon,type];
    
    NSLog(@"Bar URL: %@", staticMapUrl);
    
    
    NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]; 
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
    
    //UIImage *bkgImg = [[UIImage alloc] initWithContentsOfFile:path];
    [imageView1 setImage:image];
    
        activityIndicator.hidden = 1;label2.hidden=1;
    [successAlert addSubview:imageView1];
    [successAlert show];

}

- (void)barShow2
{  
    

    NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/staticmap?center=%f,%f&zoom=%d&size=320x323&markers=color:blue|color:blue|label:B|%f,%f&sensor=false&maptype=%@",barlat,barlon,zoom,barlat,barlon,type];

        NSLog(@"Bar URL: %@", staticMapUrl);
    
    
    NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]; 
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
    
    
    NSLog(@"URL: %@", staticMapUrl);
    
    
    //UIImage *bkgImg = [[UIImage alloc] initWithContentsOfFile:path];
    [map setImage:image];
    
    
    activityIndicator.hidden = 1;label2.hidden=1;
    
}

- (void)loadMap
{  
    
    label2.text = @"loading map...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(loadstreet) withObject:nil afterDelay:0.01]; 
    
    zoomer.hidden = false;
    pan.hidden = true;
    [streetview setTitle:@"street" forState:UIControlStateNormal];
    pic=@"map";
    
    NSLog(@"Location: %@", locationLabel.text);
    
    NSLog(@"Latitude: %f", latitude);
    NSLog(@"Longitude: %f", longitude);
    
    NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/staticmap?center=%f,%f&zoom=%d&size=320x323&markers=color:red|color:red|label:U|%f,%f&sensor=false&maptype=%@",latitude,longitude,zoom,latitude,longitude,type];
    
    if (toggle1 == @"bing")
    {
        NSString *type1 = @"Aerial";
     
        if  (type == @"satellite")
        {
            type1 = @"Aerial";
        }
        
        if  (type == @"hybrid")
        {
            type1 = @"AerialWithLabels";
        }
        
        if  (type == @"road")
        {
            type1 = @"Road";
        }
        
             staticMapUrl = [NSString stringWithFormat:@"http://dev.virtualearth.net/REST/v1/Imagery/Map/%@/%f,%f/%d?mapSize=320,323&pp=%f,%f;21;U&key=AsDTsMUE7Rr9oqizyP434eZR9L7UULMuGA8eGNgCUalK9TOTuVZ4Qd-d0K3rqcBz",type1,latitude,longitude,zoom,latitude,longitude];
    } 
    else if (toggle1 == @"mapquest")
    {
        
        
        NSString *type1 = @"hyb";
        
        if  (type == @"satellite")
        {
            type1 = @"sat";
        }
        
        if  (type == @"hybrid")
        {
            type1 = @"hyb";
        }
        
        if  (type == @"road")
        {
            type1 = @"map";
        }
        if (zoom > 16) 
        {
            zoom = 16;   
            zoomer.value = 16;
        }

             staticMapUrl = [NSString stringWithFormat:@"http://www.mapquestapi.com/staticmap/v3/getmap?key=Fmjtd|luua29uanl,rw=o5-hwtsd&center=%f,%f&zoom=%d&size=320,323&type=%@&imagetype=png&pois=U,%f,%f,-20,-20|mcenter,%f,%f",latitude,longitude,zoom,type1,latitude,longitude,latitude,longitude];
    }
    
 
    
    
    
   // NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?markers=color:red|%f,%f&%@&sensor=true",yourLatitude, yourLongitude,@"zoom=10&size=270x70"];   
    
    
    NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]; 
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
    
        NSLog(@"URL: %@", staticMapUrl);

    
    
    //UIImage *bkgImg = [[UIImage alloc] initWithContentsOfFile:path];
    [map setImage:image];
    

    activityIndicator.hidden = 1;label2.hidden=1;
}

- (IBAction)loadSat
{    
    type = @"satellite";
    
    label2.text = @"loading map...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(loadMap) withObject:nil afterDelay:0.01]; 
}

- (IBAction)loadHybrid
{    
    type = @"hybrid";
    
    label2.text = @"loading map...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(loadMap) withObject:nil afterDelay:0.01]; 
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        //     exit(0);
    }
    else
    {
        
        
        label2.text = @"loading map...";
        activityIndicator.hidden = 0;label2.hidden=0;
        [activityIndicator startAnimating];
        [self performSelector:@selector(barShow) withObject:nil afterDelay:0.01];
        
        //   [successAlert dismissWithClickedButtonIndex:0 animated:YES];
    }
}


- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1:
        {
            
             NSString *clip = [NSString stringWithFormat:@"%@ %@",locationLabel.text,street.text];   
            
            UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];
            appPasteBoard.persistent = YES;
            [appPasteBoard setString:clip];
            
            
            
            switch (buttonIndex) {
                    
                    
                case 0: 
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/dialog/feed?app_id=125466940905835&redirect_uri=http%3A//www.facebook.com/apps/application.php?id=125466940905835&to&message=@[199116963445570%3A2048%3ACHANGE_OR_ALTER_THIS_WITH_YOUR_OWN_YOUR_OWN_MESSAGE]&display=touch"]];
                    
                    break;
                case 1: 
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.myspace.com/Modules/PostTo/Pages/?t=translate%20plus:click%20paste%20on%20text%20box&c=message&l=1"]];
                    
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
- (IBAction)toggleAPI
{
    zoomer.hidden = false;
    pan.hidden = true;
    [streetview setTitle:@"street" forState:UIControlStateNormal];
    pic=@"map";
    
    if (toggle1 == @"google")
    {
        toggle1 = @"bing";
        [toggle setTitle:@"bing"];
    }
    else if (toggle1 == @"bing")
    {
        toggle1 = @"mapquest";
        [toggle setTitle:@"mapquest"];
    }
    else if (toggle1 == @"mapquest")
    {
        toggle1 = @"google";
        [toggle setTitle:@"google"];
    }
    
 
    label2.text = @"loading map...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(loadMap) withObject:nil afterDelay:0.01]; 
}

- (void) mail
{

 //   [self performSelector:@selector(loadBar) withObject:nil afterDelay:0.01];  
    
    NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [locationLabel text]];
    int numLtrs = [urlpath length];
    
    
    
    if (numLtrs > 1)
    {    
        NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [locationLabel text]];
        NSString *urlString = [NSString stringWithFormat:urlpath];
        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
        [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1" forHTTPHeaderField:@"User-Agent"];
        
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self; 
        
        NSString *subText = [[NSString alloc] initWithFormat:@"location+: Location"];
        NSString *msgText = [[NSString alloc] initWithFormat:@"<b>My Info: </b><br>%@<br><b>Street Address: </b><br>%@",locationLabel.text,street.text];
        
        NSData *data = UIImagePNGRepresentation(map.image);
        
        [picker addAttachmentData:data mimeType:@"image/png" 
                         fileName:@"myloc.png"];
        
        [picker setSubject:subText];
        [picker setMessageBody:msgText isHTML:YES];
        picker.navigationBar.barStyle = UIBarStyleDefault; 
        [self presentModalViewController:picker animated:YES];
    }
    else
    {
        UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"location+: Location" message:@"Location not available" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [fullAlert show];
        
    }
    
    
    activityIndicator.hidden = 1;label2.hidden=1;
    
    
}
- (IBAction)searchStreet
{
    if (pic==@"map")
    {
        zoomer.hidden = true;
        pan.hidden = false;
        [streetview setTitle:@"map" forState:UIControlStateNormal];
        pic=@"street";
        
        label2.text = @"loading street...";
        activityIndicator.hidden = 0;label2.hidden=0;
        [activityIndicator startAnimating];
        [self performSelector:@selector(loadstreet) withObject:nil afterDelay:0.01];   
        
        label2.text = @"loading street view...";
        activityIndicator.hidden = 0;label2.hidden=0;
        [activityIndicator startAnimating];
        [self performSelector:@selector(loadstreet1) withObject:nil afterDelay:0.01];    
    }
    else
    {
        zoomer.hidden = false;
        pan.hidden = true;
       [streetview setTitle:@"street" forState:UIControlStateNormal];
        pic=@"map";
        
        label2.text = @"loading street...";
        activityIndicator.hidden = 0;label2.hidden=0;
        [activityIndicator startAnimating];
        [self performSelector:@selector(loadstreet) withObject:nil afterDelay:0.01];   
        
        label2.text = @"loading map...";
        activityIndicator.hidden = 0;label2.hidden=0;
        [activityIndicator startAnimating];
        [self performSelector:@selector(loadMap) withObject:nil afterDelay:0.01]; 
        
        }
    
}
- (void) loadstreet1
{
    
    @try { 
    NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/streetview?size=320x323&location=%f,%f&fov=90&heading=%d&pitch=10&sensor=false",latitude,longitude,pan1];

    NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]; 
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];

    NSLog(@"URL: %@", staticMapUrl);

    [map setImage:image];

        activityIndicator.hidden = 1;label2.hidden=1;
    }
    @catch (NSException *e) {
    
    activityIndicator.hidden = 1;label2.hidden=1;
    
    UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"location+: Street not found" message:@"Sorry. No street view has been found within the vicinity." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
    
    [fullAlert show];
    
    }
}

- (IBAction)panStreet
{
    pan1 = pan.value;
    
    label2.text = @"loading street view...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(loadstreet1) withObject:nil afterDelay:0.01]; 
}

- (void) loadstreet
{
      @try { 
    NSError *error2;
    
    URL1 = [[NSString alloc] initWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",latitude,longitude];     
    
    NSString *request2 = [NSString stringWithFormat:@"%@",URL1];
    NSString *escapedUrl2 = [request2   
                             stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *URL2 = [NSURL URLWithString:escapedUrl2];
    
    NSString *XML2 = [NSString stringWithContentsOfURL:URL2 encoding:NSASCIIStringEncoding error:&error2];
    
    NSString *street1 = [[[[XML2 componentsSeparatedByString:@"\"formatted_address\" : \""] objectAtIndex:1] componentsSeparatedByString:@"\""] objectAtIndex:0];
    
          street.text = street1;
      }
    @catch (NSException *e) {
        
        activityIndicator.hidden = 1;label2.hidden=1;
        
        UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"location+: Street not found" message:@"Sorry. No street has been found within the vicinity." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [fullAlert show];
        
    }
}

- (void) search
{
    @try
    {
        NSError *error2;
    
        URL1 = [[NSString alloc] initWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=500&types=bar&sensor=false&key=AIzaSyCWebInFjJ83DUVijUT03jV9fYu-9FpVIU",latitude,longitude];     
        
        NSString *request2 = [NSString stringWithFormat:@"%@",URL1];
        NSString *escapedUrl2 = [request2   
                                 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *URL2 = [NSURL URLWithString:escapedUrl2];
        
        NSString *XML2 = [NSString stringWithContentsOfURL:URL2 encoding:NSASCIIStringEncoding error:&error2];
        
        NSString *barlat1 = [[[[XML2 componentsSeparatedByString:@"\"lat\" : "] objectAtIndex:1] componentsSeparatedByString:@","] objectAtIndex:0];
        
        NSString *barlon1 = [[[[XML2 componentsSeparatedByString:@"\"lng\" : "] objectAtIndex:1] componentsSeparatedByString:@" "] objectAtIndex:0];
        
        barlat = [barlat1 floatValue];
        barlon = [barlon1 floatValue];
        
        bname = [[[[XML2 componentsSeparatedByString:@"name\" : \""] objectAtIndex:1] componentsSeparatedByString:@"\""] objectAtIndex:0];
        
        vicinity = [[[[XML2 componentsSeparatedByString:@"vicinity\" : \""] objectAtIndex:1] componentsSeparatedByString:@"\""] objectAtIndex:0];
        
        icon = [[[[XML2 componentsSeparatedByString:@"icon\" : \""] objectAtIndex:1] componentsSeparatedByString:@"\""] objectAtIndex:0];
        
        lbname.text = bname;
        lvicinity.text = vicinity;
        licon.text = icon;
        
        NSString *msg = [[NSString alloc] initWithFormat:@"Name:%@\nVicinity:%@\nLatitude:%f\nLongitude:%f\n",bname,vicinity,barlat,barlon]; 
        
        NSLog(@"Bar Lat: %f", barlat);
        NSLog(@"Bar Lon: %f", barlon);
        NSLog(@"Bar Name: %@", bname);
        NSLog(@"Bar Vicinity: %@", vicinity);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"location+: Bar Search" message:msg  delegate:self cancelButtonTitle:@"close" otherButtonTitles:@"map",nil];
        //show image, or load image details to molecule action
        
        
        [alert show];
        
        activityIndicator.hidden = 1;label2.hidden=1;
    }
    @catch (NSException *e) {
        
            activityIndicator.hidden = 1;label2.hidden=1;
        
        UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"location+: Bar Search" message:@"Sorry. No bars have been found within the vicinity." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [fullAlert show];
        
    }
    
}
- (void) sms
{
    
    NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [locationLabel text]];
    int numLtrs = [urlpath length];
    
    if (numLtrs > 1)
    {  
        @try
        {
                NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/staticmap?center=%f,%f&zoom=%d&size=320x323&sensor=false&maptype=%@",latitude,longitude,zoom,type];
            
            if (toggle1 == @"bing")
            {
                NSString *type1 = @"Aerial";
                
                if  (type == @"satellite")
                {
                    type1 = @"Aerial";
                }
                
                if  (type == @"hybrid")
                {
                    type1 = @"AerialWithLabels";
                }
                
                if  (type == @"road")
                {
                    type1 = @"Road";
                }
                
                staticMapUrl = [NSString stringWithFormat:@"http://dev.virtualearth.net/REST/v1/Imagery/Map/%@/%f,%f/%d?mapSize=320,323&key=AsDTsMUE7Rr9oqizyP434eZR9L7UULMuGA8eGNgCUalK9TOTuVZ4Qd-d0K3rqcBz",type1,latitude,longitude,zoom];
            }
            else if (toggle1 == @"mapquest")
            {
                
                
                NSString *type1 = @"hyb";
                
                if  (type == @"satellite")
                {
                    type1 = @"sat";
                }
                
                if  (type == @"hybrid")
                {
                    type1 = @"hyb";
                }
                
                if  (type == @"road")
                {
                    type1 = @"map";
                }
                if (zoom > 16) 
                {
                    zoom = 16;   
                    zoomer.value = 16;
                }
                
                staticMapUrl = [NSString stringWithFormat:@"http://www.mapquestapi.com/staticmap/v3/getmap?center=%f,%f&zoom=%d&size=320,323&type=%@&imagetype=png&key=Fmjtd|luua29uanl,rw=o5-hwtsd",latitude,longitude,zoom,type1];
            }
            
            
            
            NSString *outputText = [[NSString alloc] initWithFormat:@"%@ Street:%@",staticMapUrl,street.text];
            
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
                UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"location+ SMS" message:@"Sorry. I don't support SMS™ on this device." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
                
                [fullAlert show];
            }
        }
        @catch (NSException *e) {
            UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"location+: SMS" message:@"Sorry. I don't support SMS™ on this device." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
            
            [fullAlert show];
            
        }
    }
    else
    {
        UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"location+: Location" message:@"Location not available" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [fullAlert show];
        
    }
    
    [activityIndicator stopAnimating];
    activityIndicator.hidden = 1;label2.hidden=1;
    
    
}


- (IBAction)share
{
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Sharing option (the location text is copied to your clipboard. Click the textbox and select paste):" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
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

- (IBAction) mailLoad
{
    label2.text = @"loading e-mail...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(mail) withObject:nil afterDelay:0.01];
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)zoomMap
{ 
    zoom = zoomer.value;
    
    label2.text = @"loading map...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(loadMap) withObject:nil afterDelay:0.01]; 
}

- (IBAction)refresh
{    
    if (pic==@"map")
    {
        zoomer.hidden = false;
        pan.hidden = true;
        [streetview setTitle:@"street" forState:UIControlStateNormal];
        pic=@"map";
        

        
        label2.text = @"loading street...";
        activityIndicator.hidden = 0;label2.hidden=0;
        [activityIndicator startAnimating];
        [self performSelector:@selector(loadstreet) withObject:nil afterDelay:0.01]; 
        
        label2.text = @"loading map...";
        activityIndicator.hidden = 0;label2.hidden=0;
        [activityIndicator startAnimating];
        [self performSelector:@selector(loadMap) withObject:nil afterDelay:0.01]; 
 
    }
    else
    {
        
        zoomer.hidden = true;
        pan.hidden = false;
        [streetview setTitle:@"map" forState:UIControlStateNormal];
        pic=@"street";
        
        label2.text = @"loading street...";
        activityIndicator.hidden = 0;label2.hidden=0;
        [activityIndicator startAnimating];
        [self performSelector:@selector(loadstreet) withObject:nil afterDelay:0.01];   
        
        label2.text = @"loading street view...";
        activityIndicator.hidden = 0;label2.hidden=0;
        [activityIndicator startAnimating];
        [self performSelector:@selector(loadstreet1) withObject:nil afterDelay:0.01];   
    }
}

- (IBAction)loadRoad
{    
    type = @"road";

    label2.text = @"loading map...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(loadMap) withObject:nil afterDelay:0.01]; 
}

- (void)viewDidLoad
{   
    pic=@"map";
    
     [self.view bringSubviewToFront:toolbar1];
    
    NSString *reqSysVer = @"5.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
    {
        zoomer.hidden = FALSE;
    }
    else
    {
        zoomer.hidden = TRUE;
    }
        
    
    toggle1= @"google";
    type = @"hybrid";
    zoom = 18;
    pan1 = 90;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    locationController = [[MyCLController alloc] init];
    locationController.delegate = self;
    [locationController.locationManager startUpdatingLocation];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    label2.text = @"loading map...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(loadMap) withObject:nil afterDelay:2.5];
    
    label2.text = @"loading street...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(loadstreet) withObject:nil afterDelay:2.5];  
}

- (void)locationUpdate:(CLLocation *)location {
    locationLabel.text = [location description];
    latitude =location.coordinate.latitude;
    longitude = location.coordinate.longitude;
    
}

- (void)locationError:(NSError *)error {
    locationLabel.text = [error description];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
