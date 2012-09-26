//
//  RootViewController2.h
//  HPCmap
//
//  Created by Barbara Collignon on 11/14/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DetailViewController;


@protocol FlickrConnectionDelegate;


//Boolean myBOOL=NO;

@interface RootViewController2 : UITableViewController <UITableViewDataSource,UITableViewDelegate> {
    
    
    id <FlickrConnectionDelegate> delegate;
    DetailViewController *detailViewController;
 //   Favorites *myfavorites;
    //  JSONFlickrViewController *myjson;
    
    UITableView     *theTableView;
  //  NSMutableString *jsonString;
    NSMutableData   *receiveData;
    NSMutableArray  *photoTitles;  
     NSMutableArray  *ownerNames;// Titles of images
    NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
    NSMutableArray  *photoURLsLargeImage; // URL to larger image 
     UINavigationBar *navigBar;
    UIImage *mynewimage;
    Boolean myBOOL;
    int i;

}

@property (nonatomic,assign) id <FlickrConnectionDelegate> delegate;
@property (nonatomic, assign)  Boolean myBOOL;
@property (nonatomic,retain) UIImage *mynewimage ; 

@end

@protocol FlickrConnectionDelegate

-(void)flickrConnection:(RootViewController2*)connection
          didReceiveData:(NSData*)data;

@end

