//
//  costreduction.m
//  HPCmap
//
//  Created by Barbara Collignon on 1/3/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "costreduction.h"
//#import "supercostreduction.h"

@implementation costreduction

@synthesize value1;
@synthesize mysavings,hardware,energy;

-(void) dealloc{
    
    [value1 release];
    [mysavings release];
    [hardware release];
    [energy release];
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
    
   // UIAlertView *alertDialog;
    
    float x = [value1.text floatValue];
    //float y = [value2.text floatValue];
    //float z = [wearyrs.text floatValue];
    
    float ha = 4000.00;
    float eb = 755.50;

    float haa = 600.00;
    float ebb = 94.50;
    
    hardware.text = [[[NSString alloc] initWithFormat:@"%4.1f",(x*(ha-haa))] autorelease];

    energy.text = [[[NSString alloc] initWithFormat:@"%4.1f",(x*(eb-ebb))] autorelease];
    
    float a=[energy.text floatValue];
    float b=[hardware.text floatValue];
    
    mysavings.text = [[[NSString alloc] initWithFormat:@"%4.1f %s",(a+b),"$"] autorelease];
    
    UIAlertView *alertDialog;
    
    alertDialog = [[UIAlertView alloc] initWithTitle:@"Annual Cost Reduction (Hardware & Energy)" message:mysavings.text delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alertDialog show];
    // [mysavings release];
    [alertDialog release];
    
    
 //   float inth=[hardware.text floatValue];
  //  float inte=[energy.text floatValue];
    
 //   NSLog(@"%f + %f",inth,inte);
/*    
mysavings.text = [[[NSString alloc] initWithFormat:@"%4.4f %s",(inth+inte),"$"] autorelease];
        
    alertDialog = [[UIAlertView alloc] initWithTitle:@"Annual Cost Savings" message:mysavings.text delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alertDialog show];
  //  [mysavings release];
    [alertDialog release];
 */
    
}


- (IBAction) hideKeyBoard:(id)sender {
    [value1 resignFirstResponder];
  //  [value2 resignFirstResponder];
}

- (IBAction) clear {
    
    value1.text=nil;
    mysavings.text=nil;
    hardware.text=nil;
    energy.text=nil;
}

- (void)cancel:(id)sender {
	
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark - View lifecycle
/*
- (void)calculatemod:(id)sender {
           
    supercostreduction *mymodalview = [[supercostreduction alloc] init];
    
    //  [modalView.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    
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
   
    
    self.navigationItem.title=@"Cost Reduction";

    
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
