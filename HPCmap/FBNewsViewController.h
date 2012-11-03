//
//  FBNewsViewController.h
//  HPCmap
//
//  Created by Barbara Collignon on 9/18/12.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InAppPurManager.h"
#import "CommonDefines.h"

@interface FBNewsViewController : UIViewController {
    
    
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;

- (void)loadFBPage;

@end
