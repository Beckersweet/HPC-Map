//
//  supergpue.m
//  HPCmap
//
//  Created by Barbara Collignon on 1/5/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "supergpue.h"
#import "gpue.h"

@implementation supergpue

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

- (void)cancel:(id)sender {
	//self.selectedImage = nil;
    //	CustomImagePickerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	//[self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
}


#pragma mark - View lifecycle
- (void)calculatemod:(id)sender {
    
       
    gpue *mymodalview = [[gpue alloc] init];
    
    //  [modalView.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
    
    UINavigationController *cntrol = [[[UINavigationController alloc] initWithRootViewController:mymodalview] autorelease]; 
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:cntrol animated:YES];
    // [cntrol release]; 
    [mymodalview release];            
    
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] 
									 initWithTitle:@"Cancel" 
									 style:UIBarButtonItemStylePlain 
									 target:self 
									 action:@selector(cancel:)];
	self.navigationItem.leftBarButtonItem = cancelButton;
 	[cancelButton release];

   
    self.navigationItem.title=@"Wikipedia";
   

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
