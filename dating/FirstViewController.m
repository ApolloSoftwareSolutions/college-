//
//  FirstViewController.m
//  nutrition+
//
//  Created by Amit Barman on 1/4/12.
//  Copyright (c) 2012 Apollo Software. All rights reserved.
//

#import "FirstViewController.h"
NSString *lat;
NSString *lon;
static inline double radians (double degrees) {return degrees * M_PI/180;}
float barlat;
float barlon;

float latitude, longitude;
NSString *type=@"road";
int zoom=17;
NSString *URL1;


@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Faces", @"Faces");
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
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

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1:
        {
            UIPasteboard *appPasteBoard = [UIPasteboard generalPasteboard];
            appPasteBoard.persistent = YES;
            [appPasteBoard setString:locationLabel.text];
            
            
            
            switch (buttonIndex) {
                    
                    
                case 0: 
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/dialog/feed?app_id=157440634364835&redirect_uri=http%3A//www.facebook.com/apps/application.php?id=157440634364835&to&message=@[199116963445570%3A2048%3ACHANGE_OR_ALTER_THIS_WITH_YOUR_OWN_YOUR_OWN_MESSAGE]&display=touch"]];
                    
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


- (void) take
{
    
    imagePickerController = [[[UIImagePickerController alloc] init] autorelease];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
	
	[self presentModalViewController:imagePickerController animated:YES];
    
    activityIndicator.hidden = 1;label2.hidden=1;
    
 //   UIImage* imageToSave = [iv image]; // alternatively, imageView.image
    // Save it to the camera roll / saved photo album
//    UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
    activityIndicator.hidden = 1;label2.hidden=1;
}

- (void) find
{
    imagePickerController = [[[UIImagePickerController alloc] init] autorelease];imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
	
	[self presentModalViewController:imagePickerController animated:YES];
    activityIndicator.hidden = 1;label2.hidden=1;
}

- (void)imagePickerController:(UIImagePickerController *)picker 
		didFinishPickingImage:(UIImage *)image
				  editingInfo:(NSDictionary *)editingInfo
{
    iv.image = image;
    UIImage *newImage = [self resizeImage:iv.image];
    iv.image = newImage;
    
    [picker dismissModalViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
}

- (void) save
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-d_YYYY-ss"];
    NSString *dateString = [dateFormat stringFromDate:date];  
    
    NSLog(@"%@", date);
    
    NSString *nowTime = [NSString stringWithFormat:@"photo_%@.png",dateString];
    
    UIImage* imageToSave = [iv image]; // alternatively, imageView.image
    // Save it to the camera roll / saved photo album
    UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
    activityIndicator.hidden = 1;label2.hidden=1;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:nowTime];
    UIImage *image = iv.image; // imageView is my image from camera
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:NO];   
    
    UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"dating+: Save" message:@"Image has been saved to your Camera Roll Photo Library & your Documents Library. You can access your documents library from iTunes, under apps, then under File Sharing." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
    
    [fullAlert show];
}


- (IBAction)savePicture
{
       label2.text = @"saving picture...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(save) withObject:nil afterDelay:0.01];
}
- (IBAction)findPhoto:(id) sender
{
       label2.text = @"loading picker...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(find) withObject:nil afterDelay:0.01];
}
- (IBAction)takePhoto:(id) sender
{
       label2.text = @"loading camera...";
    activityIndicator.hidden = 0;label2.hidden=0;
    [activityIndicator startAnimating];
    [self performSelector:@selector(take) withObject:nil afterDelay:0.01];
}
- (IBAction)trash
{
    iv.image = nil;
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
- (IBAction)searchBars
{
    
}
- (void)locationUpdate:(CLLocation *)location {
    locationLabel.text = [location description];
    latitude =location.coordinate.latitude;
    longitude = location.coordinate.longitude;
    
}

- (void)locationError:(NSError *)error {
    locationLabel.text = [error description];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    //message.hidden = NO;
    [self dismissModalViewControllerAnimated:YES];
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

- (void) sms
{
    
    NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [locationLabel text]];
    int numLtrs = [urlpath length];
    
    if (numLtrs > 1)
    {  
        @try
        {
            NSString *staticMapUrl = [NSString stringWithFormat:@"%@",[locationLabel text]];
            
            NSString *outputText = [[NSString alloc] initWithFormat:@"%@",staticMapUrl];
            
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
                UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"dating+ SMS" message:@"Sorry. I don't support SMS™ on this device." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
                
                [fullAlert show];
            }
        }
        @catch (NSException *e) {
            UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"dating+: SMS" message:@"Sorry. I don't support SMS™ on this device." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
            
            [fullAlert show];
            
        }
    }
    else
    {
        UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"dating+: Location" message:@"Location not available" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [fullAlert show];
        
    }
    
    [activityIndicator stopAnimating];
    activityIndicator.hidden = 1;label2.hidden=1;
    
    
}
- (void) mail
{
    
    NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [locationLabel text]];
    int numLtrs = [urlpath length];
    
    
    NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/staticmap?center=%f,%f&zoom=%d&size=320x323&sensor=false&maptype=%@",latitude,longitude,zoom,type];
    
    
    if (numLtrs > 1)
    {    
        NSString *urlpath = [[NSString alloc] initWithFormat:@"%@", [locationLabel text]];
        NSString *urlString = [NSString stringWithFormat:urlpath];
        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest* request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
        [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1" forHTTPHeaderField:@"User-Agent"];
        
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self; 
        
        NSString *subText = [[NSString alloc] initWithFormat:@"dating+: Photo"];
        NSString *msgText = [[NSString alloc] initWithFormat:@"<b>My Info: </b><br>%@<br><b>Map: </b><br><a href='%@'>%@</a><br>",locationLabel.text,staticMapUrl,staticMapUrl];
        
        NSData *data = UIImagePNGRepresentation(iv.image);
        
        [picker addAttachmentData:data mimeType:@"image/png" 
                         fileName:@"myloc.png"];
        
        [picker setSubject:subText];
        [picker setMessageBody:msgText isHTML:YES];
        picker.navigationBar.barStyle = UIBarStyleDefault; 
        [self presentModalViewController:picker animated:YES];
    }
    else
    {
        UIAlertView *fullAlert = [[UIAlertView alloc] initWithTitle:@"dating+: Location" message:@"Location not available" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        
        [fullAlert show];
        
    }
    
    
    activityIndicator.hidden = 1;label2.hidden=1;

}

-(UIImage *)resizeImage:(UIImage *)image {
    
    
	// convert to grey scale and shrink the image by 4 - this makes processing a lot faster!
	// ImageWrapper *greyScale=Image::createImage(image, image.size.width, image.size.height);
	// you can play around with the numbers to see how it effects the edge extraction
	// typical numbers are  tlow 0.20-0.50, thigh 0.60-0.90
	// ImageWrapper *edges=greyScale.image->gaussianBlur().image->cannyEdgeExtract(0.25,0.75);
	// show the results
	// image=edges.image->toUIImage();
    // iv.image = image;
    
    // [self contrast:100];
    // image = iv.image;
    
	CGImageRef imageRef = [image CGImage];
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
	CGColorSpaceRef colorSpaceInfo = CGColorSpaceCreateDeviceRGB();
	
	if (alphaInfo == kCGImageAlphaNone)
		alphaInfo = kCGImageAlphaNoneSkipLast;
	
	int width, height;
    
	
        width = image.size.width;//[image size].width;
        height = image.size.width;//[image size].height;
     
	
	CGContextRef bitmap;
	
	if (image.imageOrientation == UIImageOrientationUp | image.imageOrientation == UIImageOrientationDown) {
		bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, alphaInfo);
		
	} else {
		bitmap = CGBitmapContextCreate(NULL, height, width, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, alphaInfo);
		
	}
	
	if (image.imageOrientation == UIImageOrientationLeft) {
		NSLog(@"image orientation left");
		CGContextRotateCTM (bitmap, radians(90));
		CGContextTranslateCTM (bitmap, 0, -height);
		
	} else if (image.imageOrientation == UIImageOrientationRight) {
		NSLog(@"image orientation right");
		CGContextRotateCTM (bitmap, radians(-90));
		CGContextTranslateCTM (bitmap, -width, 0);
		
	} else if (image.imageOrientation == UIImageOrientationUp) {
		NSLog(@"image orientation up");	
		
	} else if (image.imageOrientation == UIImageOrientationDown) {
		NSLog(@"image orientation down");	
		CGContextTranslateCTM (bitmap, width,height);
		CGContextRotateCTM (bitmap, radians(-180.));
		
	}
	
	CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
	UIImage *result = [UIImage imageWithCGImage:ref];
	
	CGContextRelease(bitmap);
	CGImageRelease(ref);
	
	return result;	
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
#pragma mark - View lifecycle

- (void)viewDidLoad
{    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [super viewDidLoad];
    
    locationController = [[MyCLController alloc] init];
    locationController.delegate = self;
    [locationController.locationManager startUpdatingLocation];

	// Do any additional setup after loading the view, typically from a nib.
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
