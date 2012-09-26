//
//  RootViewController.h
//  HPCmap
//
//  Created by Barbara Collignon on 8/27/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class pue;

@interface RootViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate> {
//@interface RootViewController : UITableViewController {
    DetailViewController *detailViewController;
    pue *puedetail;
    
    NSMutableArray *gloveData;
    NSMutableArray *gloveSections;
    NSMutableArray *sect1Gloves;
    NSMutableArray *sect2Gloves;
   // NSMutableArray *sect3Gloves;
}

-(void) createGloveData;

@end
