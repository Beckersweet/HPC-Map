//
//  RootViewController2.m
//  HPCmap
//
//  Created by Barbara Collignon on 11/14/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//


#import "RootViewController2.h" 
#import "HPCMapViewController.h"
#import "DetailViewController2.h"
#import "JSON.h"

#define debug(format, ...) CFShow([NSString stringWithFormat:format, ## __VA_ARGS__]);


@interface RootViewController2(private)
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)searchFlickrPhotos:(NSString *)text;
- (void)searchFlickrPhotos2:(NSString *)text;
@end

NSString *const FlickrAPIKey = @"844adbd0a252c2741a1fd4590a2e5919";
NSString *const userid = @"52210018@N06";
NSString *const groupid = @"72157627879677415";
NSString *const setid = @"72157627879677415";

//me
NSString *const userid2 = @"68382871@N05";
NSString *const groupid2 = @"72157627879677415";

@implementation RootViewController2

@synthesize myBOOL;
@synthesize delegate;
@synthesize mynewimage;

#pragma mark -
#pragma mark Private Methods


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    // receiveData.length=0;
    [receiveData setLength:0];
}

//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    [receiveData appendData:data];
//}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [receiveData release];
    receiveData=nil;
    [connection release];
    connection=nil;
	
	// ANT: The thread must now exit
	CFRunLoopStop(CFRunLoopGetCurrent());

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
  //  HPCMapViewController *map = [[HPCMapViewController alloc] init];
  //  [map.activityView stopAnimating];
  //  map.activityView.hidden=YES;
  //  [map release];
    

    [delegate flickrConnection:self didReceiveData:receiveData];
 //   [connection release];
 //    connection=nil;  
    
// jsonString=nil;
    
//  NSLog(@"BEFORE1");
    
 if (receiveData != nil) {
        NSString *jsonString=[[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
       
 //debug(@"jsonString: %@", jsonString);

            // Create a dictionary from the JSON string
        if([jsonString JSONValue] != nil){
            NSDictionary *results = [jsonString JSONValue];
         
            NSArray *photos=nil;
         
            if (myBOOL == YES) {
               // NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
               // [prefs setObject:photos forKey:@"dictionary"];
               // [prefs synchronize];
              //  NSLog(@"MYBOOL=YES");
            } else {
             //   NSLog(@"MYBOOL=NO");
                
              //  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
              //  [prefs removeObjectForKey:@"dictionary"];
              //  [prefs setObject:photos forKey:@"dictionary"];
              //  [prefs synchronize];
               // photos=nil;
            }
            
       //     myBOOL = NO;

                
                  
           //  NSLog(@"here again2");
            // Loop through each entry in the dictionary...
            for (NSDictionary *photo in photos)
            {
                // Get title of the image
                //  while (photo!=nil){
                //   if(photo != nil){
                NSString *title = [photo objectForKey:@"title"];
                NSString *owner =  [photo objectForKey:@"ownername"];
              
                if([title isEqualToString:@"I Want My Supercomputer"] == YES || [title isEqualToString:@"CRAY-XT5"] == YES ||[title isEqualToString:@"Curated Store"] == YES || [title isEqualToString:@"Control room MAX experiment"] == YES || [title isEqualToString:@"Nuclear Engineer Laural Briggs"] == YES || [title isEqualToString:@"MasPar Mug"] == YES || [title isEqualToString:@"Thinking Machines Mug"] == YES || [title isEqualToString:@"NAYLAMP,DHN-(El Callao,Perú)"] == YES ||[title isEqualToString:@"New Blue Gene Super Computer"] == YES || [title isEqualToString:@"DSCF3609"] == YES || [title isEqualToString:@"Deep Blue"] == YES || [title isEqualToString:@"Master Of Supercomputing"] == YES || [title isEqualToString:@"Amy on the Cray-1"] == YES || [title isEqualToString:@"CRAY-3"] == YES || [title isEqualToString:@"Gene Amdahl!"] == YES || [title isEqualToString:@"Danny Hillis and ? 77 million  IMG_4400"] == YES || [title isEqualToString:@"MHPCC_Supercomputer"] == YES || [owner isEqualToString:@"Ultimate fish"] == YES || [owner isEqualToString:@"danregal"] == YES || [title isEqualToString:@""] == YES || [owner isEqualToString:@""] == YES || [owner isEqualToString:@"peterhoneyman"] == YES || [owner isEqualToString:@"EbbeSand"] == YES || [owner isEqualToString:@"Fauxlaroid"] == YES || [owner isEqualToString:@"Monkey River Town"] == YES || [owner isEqualToString:@"Chris_Samuel"] == YES || [owner isEqualToString:@"Burpythehippo"] == YES || [owner isEqualToString:@"dabcanboulet"] == YES || [owner isEqualToString:@"nolan"] == YES || [owner isEqualToString:@"recompiler"] == YES || [owner isEqualToString:@"Kelt"] == YES || [owner isEqualToString:@"Eric E Johnson"] == YES || [owner isEqualToString:@"NoisyAstronomer"] == YES || [owner isEqualToString:@"Nik Bourbaki"] == YES || [owner isEqualToString:@"jonMR"] == YES || [owner isEqualToString:@"Grudnick"] == YES || [owner isEqualToString:@"ecoev"] == YES || [owner isEqualToString:@"kowgod"] == YES) {
                
            //    NSLog(@"OULALALALLALAL");
                
            } else {  
                
                
               [photoTitles addObject:(title.length > 0 ? title : @"Untitled")];      
               [ownerNames addObject:(owner.length > 0 ? owner : @"Unknown")];
               
                if ([title isEqualToString:@"Untitled"] == YES || [owner isEqualToString:@"Unknown"] == YES) {
                
                    // do nothing
                    
                } else {
                    
                    NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
                
                              
                [photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
                
                // Build and save the URL to the large image so we can zoom
                // in on the image if requested
                photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
                [photoURLsLargeImage addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];   
                
                }
            }
                
            }
            //  debug(@"photoURLsLareImage: %@\n\n", photoURLString); 
        }
        // }
        // Update the table with data
        // [theTableView reloadData];
        // }
     
      //  if(myBOOL == YES){
        [theTableView reloadData];
       // }
            
        
        [jsonString release];
        jsonString=nil;
        
      //   NSLog(@"here again6");
        
    }    
    
    [receiveData release];
    receiveData=nil;
  //  [connection release];
  //  connection=nil;

	// ANT: Moved the next line here as this whole method takes very long to finish
	// Ideally, we would turn off the network indicator at the top and have a different wait signal to the user on this view
	[UIApplication sharedApplication].networkActivityIndicatorVisible=NO;

    // ANT: The thread can now exit
	CFRunLoopStop(CFRunLoopGetCurrent());
    
   
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    // Store incoming data into a string
   
  [receiveData appendData:data];
 //  NSString *tempString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
   // jsonString=Nil;
    
}


-(void)searchFlickrPhotos:(NSString *)text
{
    // Build the string to call the Flickr API
   // 	NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=150&format=json&nojsoncallback=1", FlickrAPIKey, text];
    
    myBOOL=YES;
    
 //   NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&user_id=%@&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey,text,userid];
    
 //   NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=%@&photoset_id=72157627879677415&per_page=50&format=json&nojsoncallback=1",FlickrAPIKey];
    
 //   NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=%@&photoset_id=72157628113067064&per_page=200&format=json&nojsoncallback=1",FlickrAPIKey];
    //TO GET PIC OF KEVIN
  //NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=%@&photoset_id=72157626610784669&per_page=200&format=json&nojsoncallback=1",FlickrAPIKey];
    
    //TO GET PIC FROM THE SUPERCOMPUTERS GROUP
   NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.groups.pools.getPhotos&api_key=%@&group_id=1307213@N22&per_page=400&format=json&nojsoncallback=1",FlickrAPIKey];
    
    // Create NSURL string from formatted string
	NSURL *url = [NSURL URLWithString:urlString];
    
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
   [request release]; 
   
    if(connection){
        
        if (receiveData != nil) {
            [receiveData release];
            receiveData = nil;
        }
        receiveData=[[NSMutableData data] retain];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //        [connection release];
        //        connection=nil;
    } else {
        //  NSLog(@"search could not be performed");
    }

    
    [connection release];
   // [request release];
	
	// ANT: Now that this method is in a thread, keep it from exiting
	CFRunLoopRun(); // Avoid thread exiting

    
}
-(void)searchFlickrPhotos2:(NSString *)text
{
    // Build the string to call the Flickr API
    //	NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&group_id=%@&user_id=%@&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey, text,groupid,userid];

    myBOOL=NO;
    
   //    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&user_id=%@&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey,text,userid];
    
    //   NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=%@&photoset_id=72157627879677415&per_page=50&format=json&nojsoncallback=1",FlickrAPIKey];
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=%@&photoset_id=72157627879677415&per_page=10&format=json&nojsoncallback=1",FlickrAPIKey];
    
    
    
    // Create NSURL string from formatted string
	NSURL *url = [NSURL URLWithString:urlString];
    
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [request release];
    
    
    if(connection){
        
        if (receiveData != nil) {
            [receiveData release];
            receiveData = nil;
        }
        receiveData=[[NSMutableData data] retain];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //        [connection release];
        //        connection=nil;
    } else {
       // NSLog(@"search could not be performed");
    }
    
    
    [connection release];
    // [request release];
    
}




#pragma mark -
#pragma mark Initialization

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (id)init
{
 
    self.navigationItem.title=@"Supercomputers";
    
    UILabel * label = [[[UILabel alloc] initWithFrame:CGRectMake(0,0,45,45)] autorelease];
    label.textColor = [UIColor yellowColor];
    label.backgroundColor = [UIColor clearColor]; 
    label.text = self.navigationItem.title;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size: 22.0];
    self.navigationItem.titleView = label;
    [label sizeToFit];
    
    //self.navigationItem.title=@"Supercomputers";
   
    
    if (self = [super init])
    {
        self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
        
        myBOOL=NO;
        
        // Create table view
        theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
        [theTableView setDelegate:self];
        [theTableView setDataSource:self];
        [theTableView setRowHeight:80];
        [self.view addSubview:theTableView];
        [theTableView setBackgroundColor:[UIColor whiteColor]];
        [theTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        // Initialize our arrays
		photoTitles = [[NSMutableArray alloc] init];
        ownerNames = [[NSMutableArray alloc] init];
		photoSmallImageData = [[NSMutableArray alloc] init];
		photoURLsLargeImage = [[NSMutableArray alloc] init];

		// ANT: Changed the call for FlickrPhotos to run in the background to avoid hanging while it is done
//        [self searchFlickrPhotos:@"cray"];
		[self performSelectorInBackground:@selector(searchFlickrPhotos:) withObject:@"cray"];

    }
    
    if([UIApplication sharedApplication].networkActivityIndicatorVisible == NO) {
            
    } 
    
	return self;
    
}

#pragma mark -
#pragma mark Table Mgmt



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [photoTitles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cachedCell"];
    if (cell == nil)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cachedCell"] autorelease];
    
    NSString *textinlabel = [[[NSString alloc] initWithFormat:@"%@ from %@",[photoTitles objectAtIndex:indexPath.row],[ownerNames objectAtIndex:indexPath.row]] autorelease];
    
    
    UIFont *locationFont = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    
    UILabel *Label=[[UILabel alloc] initWithFrame:CGRectMake(88,-10, 222, 90)];
    //  tweetLabel.font=[UIFont systemFontSize:14];
    Label.font=locationFont;
    Label.numberOfLines=3;
    Label.text=textinlabel;
    
    /*
    CGSize maximumSize = CGSizeMake(222, 106);
    NSString *dateString = textinlabel;
    UIFont *dateFont = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    CGSize dateStringSize = [dateString sizeWithFont:dateFont 
                                   constrainedToSize:maximumSize 
                                       lineBreakMode:Label.lineBreakMode];
    
    CGRect dateFrame = CGRectMake(88, 0, 222, dateStringSize.height);
    
    Label.frame = dateFrame;
    Label.text=textinlabel;
    */
    
        
  //  cell.textLabel.text=nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   // cell.selectionStyle = UITableViewCellSelectionStyleGray ;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [cell addSubview:Label];
    [Label release];
    
	NSData *imageData = [photoSmallImageData objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageWithData:imageData];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
        
    NSData *imageData = [photoURLsLargeImage objectAtIndex:indexPath.row];
   // printf("row number:%d",indexPath.row);
  // NSData *imageData = [photoSmallImageData objectAtIndex:indexPath.row];
 //   UIImage *newimage = [UIImage imageWithData:imageData];
  //  self.mynewimage = newimage ;
   
    /*
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
  //  self.mynewimage = newimage ;
    [prefs setObject:UIImagePNGRepresentation(newimage) forKey:@"myfavimage"]; 
 //   [prefs setObject:self.mynewimage forKey:@"myfavimage"];
    [prefs synchronize];
    */
    
    DetailViewController2 *imageDetail = [[[DetailViewController2 alloc] initWithNibName:@"DetailViewController2" bundle:[NSBundle mainBundle]] autorelease] ;
    imageDetail.myimage = [[[UIImage alloc] initWithData:imageData] autorelease]; 
   // imageDetail.imageview.image = self.mynewimage ;
    imageDetail.author = [ownerNames objectAtIndex:indexPath.row]  ;
    imageDetail.caption = [photoTitles objectAtIndex:indexPath.row]  ;
    imageDetail.imageData = imageData ; 
    
    //gloveDetail.title=[[[gloveData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    [self.navigationController pushViewController:imageDetail animated:YES];
  //  [DetailViewController2 release];
    
    
    
    
}



#pragma mark -
#pragma mark Cleanup



- (void)dealloc 
{
	[theTableView release];
	[photoTitles release];
    [ownerNames release];
	[photoSmallImageData release];
    [photoURLsLargeImage release];
  
       
	[super dealloc];
}
 

@end
