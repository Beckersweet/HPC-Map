//
//  FBNewsViewController.m
//  HPCmap
//
//  Created by Barbara Collignon on 9/18/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "FBNewsViewController.h"

@interface FBNewsViewController ()

@end

@implementation FBNewsViewController

@synthesize webView ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *urlAddress = HPCFacebookURL;
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
    
    // Do any additional setup after loading the view from its nib.
	
	// ANT: Just testing purchases here without needing a button
	[[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
