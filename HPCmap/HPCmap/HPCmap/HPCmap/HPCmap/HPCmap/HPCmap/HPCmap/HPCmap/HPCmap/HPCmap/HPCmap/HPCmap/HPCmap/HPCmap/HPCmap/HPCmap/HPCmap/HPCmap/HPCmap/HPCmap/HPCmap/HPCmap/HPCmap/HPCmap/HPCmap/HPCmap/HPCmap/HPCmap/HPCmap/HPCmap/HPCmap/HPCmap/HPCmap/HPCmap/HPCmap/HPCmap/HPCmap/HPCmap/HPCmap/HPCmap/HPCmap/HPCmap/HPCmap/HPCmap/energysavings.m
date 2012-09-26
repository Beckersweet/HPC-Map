//
//  energysavings.m
//  GloveCatalogue
//
//  Created by Barbara Collignon on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "energysavings.h"
//#import "superenergysavings.h"

@implementation energysavings

@synthesize mysavings;
@synthesize value1;

-(void) dealloc{
    
    [value1 release];
    [mysavings release];
    [super dealloc];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction) calculate {
    
    UIAlertView *alertDialog;
    
    float x = [value1.text floatValue];
    float a = 7555.5;
    float b = 944.5;
    // float z = [wearyrs.text floatValue];
    
    mysavings.text = [[[NSString alloc] initWithFormat:@"%4.1f %s",(x*a-x*b),"kWh"] autorelease];
    
    alertDialog = [[UIAlertView alloc] initWithTitle:@"Annual Energy Savings (sever usage & cooling)" message:mysavings.text delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alertDialog show];
    [alertDialog release];

}


- (IBAction) hideKeyBoard:(id)sender {
    [value1 resignFirstResponder];
   
}

- (IBAction) clear {
    
    value1.text=nil;
    mysavings.text=nil;
}


- (void)cancel:(id)sender {
	//self.selectedImage = nil;
    //	CustomImagePickerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	//[self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
}

#pragma mark - View lifecycle
/*
- (void)calculatemod:(id)sender {
            
    superenergysavings *mymodalview = [[superenergysavings alloc] init];
         
    UINavigationController *cntrol = [[[UINavigationController alloc] initWithRootViewController:mymodalview] autorelease]; 
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:cntrol animated:YES];
    // [cntrol release]; 
    [mymodalview release];            
    
    
}
*/


#pragma mark - View lifecycle

- (void)viewDidLoad
{
 
     
     self.navigationItem.title=@"Energy Savings";
        
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
