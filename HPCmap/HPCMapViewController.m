//
//  HPCMapViewController.m
//  HPCmap
//
//  Created by Barbara Collignon on 8/30/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "HPCMapViewController.h"
#import "MapAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#import "DetailViewController.h"
#import "computingCenter.h"
#import <MapKit/MapKit.h>

@interface HPCMapViewController()

@property (nonatomic, retain) BasicMapAnnotation *normalAnnotation;

@end


@implementation HPCMapViewController

@synthesize mapView = _mapView;
@synthesize selectedAnnotationView = _selectedAnnotationView;
@synthesize normalAnnotation = _normalAnnotation;
@synthesize actionSheet;
@synthesize bannerIsVisible,bannerView, NOV11;
@synthesize activity ;

-(void)loading{
    
    if([UIApplication sharedApplication].networkActivityIndicatorVisible == YES){
        
        [activity startAnimating];
        
    } else {
        
        [activity stopAnimating];
        activity.hidden=YES;
    }
    
}


- (void)dealloc {
    [_mapView release];
    [_selectedAnnotationView release];
    [_normalAnnotation release];
    [actionSheet release];
    [activity release]; 
    //[activityView release];
    [super dealloc];
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible)
    {
        
     //   NSLog(@"BANNER is unvisible X = %4.4f",bannerView.frame.origin.x);
     //   NSLog(@"BANNER is unvisible Y = %4.4f",bannerView.frame.origin.y);
        
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
        
        
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible)
    {
     
     //   NSLog(@"BANNER failed X = %4.4f",bannerView.frame.origin.x);
     //   NSLog(@"BANNER failed Y = %4.4f",bannerView.frame.origin.y);

        
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}

- (void)dismissActionSheet:(id)sender {
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(void) showDetails:(id)sender{
    
    DetailViewController *dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    dvc.detailURL=[[[NSURL alloc] initWithString:self.normalAnnotation.url] autorelease] ;
  
    [self.navigationController pushViewController:dvc animated:YES];
   // dvc.detailURL = nil;
  //  [dvc release];
 //   [self presentModalViewController:dvc animated:YES];
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKPinAnnotationView *)view {
	
    
    computingCenter *event;
    computingCenter *event2;
 
if (NOV11 == TRUE) {
    
    for (event in eventPoints2) {
        
        if (event.latitude ==view.annotation.coordinate.latitude && event.longitude == view.annotation.coordinate.longitude ) {
            
              
                       self.normalAnnotation.url=event.url;
        }   
    }
    
    
    for (event2 in eventPoints) {
        
        if (event2.latitude == view.annotation.coordinate.latitude && event2.longitude == view.annotation.coordinate.longitude ) {
            
              self.normalAnnotation.url=event2.url;
           }    
    }
         
     } else {
         
         
         for (event in eventPoints2) {
             
             if (event.latitude ==view.annotation.coordinate.latitude && event.longitude == view.annotation.coordinate.longitude ) {
                 
                 
                 self.normalAnnotation.url=event.url;
             }   
         }
         
         
         for (event2 in eventPoints) {
             
             if (event2.latitude == view.annotation.coordinate.latitude && event2.longitude == view.annotation.coordinate.longitude ) {
                 
                 self.normalAnnotation.url=event2.url;
             }    
         }

         
         for (event in eventPoints2_new) {
             
             if (event.latitude ==view.annotation.coordinate.latitude && event.longitude == view.annotation.coordinate.longitude ) {
                 
                 
                 self.normalAnnotation.url=event.url;
             }   
         }
         
         
         for (event2 in eventPoints_new) {
             
             if (event2.latitude == view.annotation.coordinate.latitude && event2.longitude == view.annotation.coordinate.longitude ) {
                 
                 self.normalAnnotation.url=event2.url;
             }    
         }

         
         for (event in eventPoints2_black) {
             
             if (event.latitude ==view.annotation.coordinate.latitude && event.longitude == view.annotation.coordinate.longitude ) {
                 
                 
                 self.normalAnnotation.url=event.url;
             }   
         }
         
         
         for (event2 in eventPoints_black) {
             
             if (event2.latitude == view.annotation.coordinate.latitude && event2.longitude == view.annotation.coordinate.longitude ) {
                 
                 self.normalAnnotation.url=event2.url;
             }    
         }

         
         
         
     }
    
    
      
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //  [rightButton setTitle:event.name forState:UIControlStateNormal];
    [rightButton addTarget:self
                    action:@selector(showDetails:)
          forControlEvents:UIControlEventTouchUpInside];
    //self.normalAnnotation.rightCalloutAccessoryView = rightButton;
    view.rightCalloutAccessoryView=rightButton; 
    view.highlighted=YES;
    view.opaque=NO;

    
		//}
		//[self.mapView addAnnotation:self.calloutAnnotation];
    self.selectedAnnotationView = view;
  
	//}
}

/*
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
	if (self.calloutAnnotation && view.annotation == self.customAnnotation) {
		[self.mapView removeAnnotation: self.calloutAnnotation];
	}
}
*/

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
        MKPinAnnotationView *annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"NormalAnnotation"] autorelease];
	        
    computingCenter *event;
  
    
    if (NOV11 == TRUE) {
    
    
    
    for (event in eventPoints2) {
        
        if (event.latitude == annotationView.annotation.coordinate.latitude && event.longitude == annotationView.annotation.coordinate.longitude ) {
            
          //  self.normalAnnotation.url=event.url;
            annotationView.pinColor = MKPinAnnotationColorGreen;
        }   
    }
    
        
    } else {
        
        
        for (event in eventPoints2) {
            
            if (event.latitude == annotationView.annotation.coordinate.latitude && event.longitude == annotationView.annotation.coordinate.longitude ) {
                
                //  self.normalAnnotation.url=event.url;
                annotationView.pinColor = MKPinAnnotationColorGreen;
            }   
        }

        
    for (event in eventPoints_new) {
        
        if (event.latitude == annotationView.annotation.coordinate.latitude && event.longitude == annotationView.annotation.coordinate.longitude ) {
            
            //  self.normalAnnotation.url=event.url;
            annotationView.pinColor = MKPinAnnotationColorGreen;
        }   
    }
    
    for (event in eventPoints2_new) {
        
        if (event.latitude == annotationView.annotation.coordinate.latitude && event.longitude == annotationView.annotation.coordinate.longitude ) {
            
            //  self.normalAnnotation.url=event.url;
            annotationView.pinColor = MKPinAnnotationColorGreen;
        }   
    }
    
    for (event in eventPoints2_black) {
        
        if (event.latitude == annotationView.annotation.coordinate.latitude && event.longitude == annotationView.annotation.coordinate.longitude ) {
            
            //  self.normalAnnotation.url=event.url;
            annotationView.pinColor = MKPinAnnotationColorPurple;
        }   
    }
    
    for (event in eventPoints_black) {
        
        if (event.latitude == annotationView.annotation.coordinate.latitude && event.longitude == annotationView.annotation.coordinate.longitude ) {
            
            //  self.normalAnnotation.url=event.url;
            annotationView.pinColor = MKPinAnnotationColorPurple;
        }   
    }

    }
      
    annotationView.canShowCallout = YES;   
    return annotationView;
      
}

-(void) segmentAction:(id)sender {
    
    UISegmentedControl *segmentControl = sender;
    
    if([segmentControl selectedSegmentIndex] == 0)
    {
      //  NSLog(@"LIST VIEW CHOSEN!");
     //   [self.navigationController popViewControllerAnimated:YES];
     //   [self.navigationController pushViewController:listViewController animated:YES];
     //   [self.mapView setHidden:NO];
      //  [secondView setHidden:YES];
        
        NOV11 = TRUE ;
        
        [self.mapView removeAnnotations:eventPoints_new];
        [self.mapView removeAnnotations:eventPoints];
        [self.mapView removeAnnotations:eventPoints2];
        [self.mapView removeAnnotations:eventPoints2_new];
        [self.mapView removeAnnotations:eventPoints_black];
        [self.mapView removeAnnotations:eventPoints2_black];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                             NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *finalPath = [documentsDirectory stringByAppendingPathComponent: 
                               [NSString stringWithFormat: @"%@.plist",@"Property List"] ];
        //  [finalPath retain];
        
        // If it's not there, copy it from the bundle
        NSFileManager *fileManger = [NSFileManager defaultManager];
        // if([fileManger fileExistsAtPath:finalPath]){
        [fileManger removeItemAtPath:finalPath error:nil];
        
        if ( ![fileManger fileExistsAtPath:finalPath] ) {
            NSString *pathToSettingsInBundle = [[NSBundle mainBundle] 
                                                pathForResource:@"Property List" ofType:@"plist"];
            NSError *error = nil;
            
            [[NSFileManager defaultManager] copyItemAtPath:pathToSettingsInBundle
                                                    toPath:finalPath
                                                     error:&error];  
            
            //   NSLog(@"Path to Plist in Bundle:%@",pathToSettingsInBundle);
            //   NSLog(@"Path to Plist in Document:%@",finalPath);
            //   NSLog(@"Error: %@", [error description]);
            
        }		
        
        
        // NSLog(@"Path to Plist in Bundle:%@",pathToSettingsInBundle);
        // NSLog(@"Path to Plist in Document:%@",finalPath);
        
        
        
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath] ;
        
        
        
        //  NSDictionary *plistData = [[NSDictionary dictionaryWithContentsOfFile:@"Property List.plist"] retain];
        
        //   if(plistData != nil)
        // NSLog(@"plistData created");
        
        NSDictionary *top500 = [plistData objectForKey:@"TOP500"] ;
        NSDictionary *green500 = [plistData objectForKey:@"GREEN500"] ;
        
        NSArray *mysupercomputers = [top500 objectForKey:@"Name"] ;
        NSArray *mysupercomputers2 = [green500 objectForKey:@"Name"] ;
        
        NSArray *myorganization = [top500 objectForKey:@"Organization"] ;
        NSArray *myorganization2 = [green500 objectForKey:@"Organization"] ;
        
        NSArray *myurl = [top500 objectForKey:@"URL"] ;
        NSArray *myurl2 = [green500 objectForKey:@"URL"] ;
        
        NSArray *mylatitudes =  [[plistData objectForKey:@"TOP500"] objectForKey:@"Latitude"] ;
        NSArray *mylatitudes2 =  [[plistData objectForKey:@"GREEN500"] objectForKey:@"Latitude"]  ;
        
        NSArray *mylongitudes = [[plistData objectForKey:@"TOP500"] objectForKey:@"Longitude"]  ;
        NSArray *mylongitudes2 = [[plistData objectForKey:@"GREEN500"] objectForKey:@"Longitude"] ;
        
        int count=0;
        int count2=0;
        
        eventPoints = [[NSMutableArray array] retain];
        eventPoints2 = [[NSMutableArray array] retain] ;
        computingCenter *event=nil;
        computingCenter *event2=nil;
        
        self.normalAnnotation = nil;
        
        //   event = [[computingCenter alloc] init];
        //   event2 = [[computingCenter alloc] init] ;
        //   event=nil;
        //   event2=nil;
        
        while (1) {
            
            // values = [line componentsSeparatedByString:@","];
            //   NSLog(@"name:%@",event.name);
            event = [[[computingCenter alloc] init] autorelease];
            event.name = [mysupercomputers objectAtIndex:count2];
            //  NSLog(@"name:%@",event.name);
            event.org= [myorganization objectAtIndex:count2];
            // NSLog(@"In the loop: Name:%@",[mysupercomputers objectAtIndex:count]); 
            event.latitude = [[mylatitudes objectAtIndex:count2] doubleValue];
            event.longitude = [[mylongitudes objectAtIndex:count2] doubleValue];
            event.url=[myurl objectAtIndex:count2] ;
            // event.CPUTime = [[values objectAtIndex:4] floatValue];
            
            self.normalAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:event.latitude andLongitude:event.longitude] autorelease];
            self.normalAnnotation.title=event.name;
            // self.normalAnnotation.subtitle=event.org;
            self.normalAnnotation.subtitle=event.org;
            self.normalAnnotation.url=event.url;
            
            //[self.mapView addAnnotation:self.customAnnotation];
            [eventPoints addObject:self.normalAnnotation];
            
            count2++;
            //  NSLog(@"count:%d",count2);
            if(count2 == 34) {
                //limit number of events to 300
                break;
            }
            
            // [event release];    
        }  
        
        while (1) {
            event2 = [[[computingCenter alloc] init] autorelease];
            event2.name = [mysupercomputers2 objectAtIndex:count];
            event2.org= [myorganization2 objectAtIndex:count];
            //NSLog(@"In the loop: Name:%@",[mysupercomputers2 objectAtIndex:count]); 
            event2.latitude = [[mylatitudes2 objectAtIndex:count] doubleValue];
            event2.longitude = [[mylongitudes2 objectAtIndex:count] doubleValue];
            //event.CPUTime = [[values objectAtIndex:4] floatValue];
            event2.url=[myurl2 objectAtIndex:count];
            
            self.normalAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:event2.latitude andLongitude:event2.longitude] autorelease];
            self.normalAnnotation.title=event2.name;
            self.normalAnnotation.subtitle=event2.org;
            self.normalAnnotation.url=event2.url;
            
            // if(event.latitude != 0.0 || event2.latitude != 0.0){        
            [eventPoints2 addObject:self.normalAnnotation];
            // }
            
            count++;
            //  NSLog(@"count:%d",count);
            if(count == 36) {
                //limit number of events to 300
                break;
            }
        }
        //  NSLog(@"Outside the loop");
        
        [_mapView addAnnotations:eventPoints];
        [_mapView addAnnotations:eventPoints2];

         
    }
    else
    {
     
     //   [self.mapView setHidden:YES];
        
        NOV11 = FALSE ;
        
        [self.mapView removeAnnotations:eventPoints];
        [self.mapView removeAnnotations:eventPoints2];
        
        self.normalAnnotation = nil;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                             NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *finalPath = [documentsDirectory stringByAppendingPathComponent: 
                               [NSString stringWithFormat: @"%@.plist",@"Property List2"] ];
        //  [finalPath retain];
        
        // If it's not there, copy it from the bundle
        NSFileManager *fileManger = [NSFileManager defaultManager];
        // if([fileManger fileExistsAtPath:finalPath]){
        [fileManger removeItemAtPath:finalPath error:nil];
        
        if ( ![fileManger fileExistsAtPath:finalPath] ) {
            NSString *pathToSettingsInBundle = [[NSBundle mainBundle] 
                                                pathForResource:@"Property List2" ofType:@"plist"];
            NSError *error = nil;
            
            [[NSFileManager defaultManager] copyItemAtPath:pathToSettingsInBundle
                                                    toPath:finalPath
                                                     error:&error];  
            
            //   NSLog(@"Path to Plist in Bundle:%@",pathToSettingsInBundle);
            //   NSLog(@"Path to Plist in Document:%@",finalPath);
            //   NSLog(@"Error: %@", [error description]);
            
        }		
        
        
        // NSLog(@"Path to Plist in Bundle:%@",pathToSettingsInBundle);
        // NSLog(@"Path to Plist in Document:%@",finalPath);
               
        NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath] ;
        //  NSDictionary *plistData = [[NSDictionary dictionaryWithContentsOfFile:@"Property List.plist"] retain];
        
        // if(plistData != nil)
        // NSLog(@"plistData created");
        
        NSDictionary *top500 = [plistData objectForKey:@"TOP500"] ;
        NSDictionary *gr500n = [plistData objectForKey:@"GR500_new"] ;
        NSDictionary *green500 = [plistData objectForKey:@"GREEN500"] ;
        NSDictionary *green500n = [plistData objectForKey:@"GREEN500_new"] ;
        NSDictionary *black500 = [plistData objectForKey:@"BLACK500"] ;
        NSDictionary *black500_2 = [plistData objectForKey:@"BLACK500_2"] ;
        
        NSArray *mysupercomputers = [top500 objectForKey:@"Name"] ;
        NSArray *mysupercomputersn = [gr500n objectForKey:@"Name"] ;
        NSArray *mysupercomputers2 = [green500 objectForKey:@"Name"] ;
         NSArray *mysupercomputers2n = [green500n objectForKey:@"Name"] ;
        
        NSArray *mysupercomputersb = [black500 objectForKey:@"Name"] ;
        NSArray *mysupercomputers2b = [black500_2 objectForKey:@"Name"] ;
        
        
        NSArray *myorganization = [top500 objectForKey:@"Organization"] ;
        NSArray *myorganizationn = [gr500n objectForKey:@"Organization"] ;
        NSArray *myorganization2 = [green500 objectForKey:@"Organization"] ;
        NSArray *myorganization2n = [green500n objectForKey:@"Organization"] ;
        
        NSArray *myorganizationb = [black500 objectForKey:@"Organization"] ;
        NSArray *myorganization2b = [black500_2 objectForKey:@"Organization"] ;
        
        NSArray *myurl = [top500 objectForKey:@"URL"] ;
        NSArray *myurln = [gr500n objectForKey:@"URL"] ;
        NSArray *myurl2 = [green500 objectForKey:@"URL"] ;
        NSArray *myurl2n = [green500n objectForKey:@"URL"] ;
        
        NSArray *myurlb = [black500 objectForKey:@"URL"] ;
        NSArray *myurl2b = [black500_2 objectForKey:@"URL"] ;
        
        NSArray *mylatitudes =  [[plistData objectForKey:@"TOP500"] objectForKey:@"Latitude"] ;
        NSArray *mylatitudesn =  [[plistData objectForKey:@"GR500_new"] objectForKey:@"Latitude"] ;
        NSArray *mylatitudes2 =  [[plistData objectForKey:@"GREEN500"] objectForKey:@"Latitude"]  ;
        NSArray *mylatitudes2n =  [[plistData objectForKey:@"GREEN500_new"] objectForKey:@"Latitude"]  ;
        
        NSArray *mylatitudesb =  [[plistData objectForKey:@"BLACK500"] objectForKey:@"Latitude"]  ;
        NSArray *mylatitudes2b =  [[plistData objectForKey:@"BLACK500_2"] objectForKey:@"Latitude"]  ;
        
        NSArray *mylongitudes = [[plistData objectForKey:@"TOP500"] objectForKey:@"Longitude"]  ;
         NSArray *mylongitudesn = [[plistData objectForKey:@"GR500_new"] objectForKey:@"Longitude"]  ;
        NSArray *mylongitudes2 = [[plistData objectForKey:@"GREEN500"] objectForKey:@"Longitude"] ;
         NSArray *mylongitudes2n = [[plistData objectForKey:@"GREEN500_new"] objectForKey:@"Longitude"] ;
        
        NSArray *mylongitudesb = [[plistData objectForKey:@"BLACK500"] objectForKey:@"Longitude"] ;
        NSArray *mylongitudes2b = [[plistData objectForKey:@"BLACK500_2"] objectForKey:@"Longitude"] ;
        
                
        int count=0;
        int count2=0;
         int countn=0;
         int count2n=0;
         int countb=0;
         int count2b=0;
        
        eventPoints = [[NSMutableArray array] retain];
        eventPoints2 = [[NSMutableArray array] retain] ;
        eventPoints_new = [[NSMutableArray array] retain] ;
        eventPoints2_new = [[NSMutableArray array] retain] ;
        
        eventPoints_black = [[NSMutableArray array] retain] ;
        eventPoints2_black = [[NSMutableArray array] retain] ;
        
        computingCenter *event=nil;
        computingCenter *event2=nil;
        computingCenter *eventn=nil;
        computingCenter *event2n=nil;
        
        computingCenter *eventb=nil;
        computingCenter *event2b=nil;
        
        
        //   event = [[computingCenter alloc] init];
        //   event2 = [[computingCenter alloc] init] ;
        //   event=nil;
        //   event2=nil;
        
        
        
        while (1) {
            
            // values = [line componentsSeparatedByString:@","];
            //   NSLog(@"name:%@",event.name);
            event = [[[computingCenter alloc] init] autorelease];
            event.name = [mysupercomputers objectAtIndex:count];
            //  NSLog(@"name:%@",event.name);
            event.org= [myorganization objectAtIndex:count];
            // NSLog(@"In the loop: Name:%@",[mysupercomputers objectAtIndex:count]); 
            event.latitude = [[mylatitudes objectAtIndex:count] doubleValue];
            event.longitude = [[mylongitudes objectAtIndex:count] doubleValue];
            event.url=[myurl objectAtIndex:count] ;
            // event.CPUTime = [[values objectAtIndex:4] floatValue];
            
            self.normalAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:event.latitude andLongitude:event.longitude] autorelease];
            self.normalAnnotation.title=event.name;
            // self.normalAnnotation.subtitle=event.org;
            self.normalAnnotation.subtitle=event.org;
            self.normalAnnotation.url=event.url;
            
            //[self.mapView addAnnotation:self.customAnnotation];
            [eventPoints addObject:self.normalAnnotation];
            
            count++;
            //  NSLog(@"count:%d",count2);
            if(count == 32) {
                //limit number of events to 300
                break;
            }
            
            // [event release];    
        }  
        
        self.normalAnnotation=nil;
        
        while (1) {
            
            // values = [line componentsSeparatedByString:@","];
            //   NSLog(@"name:%@",event.name);
            eventn = [[[computingCenter alloc] init] autorelease];
            eventn.name = [mysupercomputersn objectAtIndex:countn];
            //  NSLog(@"name:%@",event.name);
            eventn.org= [myorganizationn objectAtIndex:countn];
            // NSLog(@"In the loop: Name:%@",[mysupercomputers objectAtIndex:count]); 
            eventn.latitude = [[mylatitudesn objectAtIndex:countn] doubleValue];
            eventn.longitude = [[mylongitudesn objectAtIndex:countn] doubleValue];
            eventn.url=[myurln objectAtIndex:countn] ;
            // event.CPUTime = [[values objectAtIndex:4] floatValue];
            
            self.normalAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:eventn.latitude andLongitude:eventn.longitude] autorelease];
            self.normalAnnotation.title=eventn.name;
            // self.normalAnnotation.subtitle=event.org;
            self.normalAnnotation.subtitle=eventn.org;
            self.normalAnnotation.url=eventn.url;
            
            
            
            //[self.mapView addAnnotation:self.customAnnotation];
            [eventPoints_new addObject:self.normalAnnotation];
            
            countn++;
            //  NSLog(@"count:%d",count2);
            if(countn == 14) {
                //limit number of events to 300
                break;
            }
            
            // [event release];    
        }  

        self.normalAnnotation=nil;
        
        while (1) {
            event2 = [[[computingCenter alloc] init] autorelease];
            event2.name = [mysupercomputers2 objectAtIndex:count2];
            event2.org= [myorganization2 objectAtIndex:count2];
            //NSLog(@"In the loop: Name:%@",[mysupercomputers2 objectAtIndex:count]); 
            event2.latitude = [[mylatitudes2 objectAtIndex:count2] doubleValue];
            event2.longitude = [[mylongitudes2 objectAtIndex:count2] doubleValue];
            //event.CPUTime = [[values objectAtIndex:4] floatValue];
            event2.url=[myurl2 objectAtIndex:count2];
            
            self.normalAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:event2.latitude andLongitude:event2.longitude] autorelease];
            self.normalAnnotation.title=event2.name;
            self.normalAnnotation.subtitle=event2.org;
            self.normalAnnotation.url=event2.url;
            
            // if(event.latitude != 0.0 || event2.latitude != 0.0){        
            [eventPoints2 addObject:self.normalAnnotation];
            // }
            
            count2++;
            //  NSLog(@"count:%d",count);
            if(count2 == 14) {
                //limit number of events to 300
                break;
            }
        }
        //  NSLog(@"Outside the loop");
        
        self.normalAnnotation=nil;
        
        while (1) {
            event2n = [[[computingCenter alloc] init] autorelease];
            event2n.name = [mysupercomputers2n objectAtIndex:count2n];
            event2n.org= [myorganization2n objectAtIndex:count2n];
            //NSLog(@"In the loop: Name:%@",[mysupercomputers2 objectAtIndex:count]); 
            event2n.latitude = [[mylatitudes2n objectAtIndex:count2n] doubleValue];
            event2n.longitude = [[mylongitudes2n objectAtIndex:count2n] doubleValue];
            //event.CPUTime = [[values objectAtIndex:4] floatValue];
            event2n.url=[myurl2n objectAtIndex:count2n];
            
            self.normalAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:event2n.latitude andLongitude:event2n.longitude] autorelease];
            self.normalAnnotation.title=event2n.name;
            self.normalAnnotation.subtitle=event2n.org;
            self.normalAnnotation.url=event2n.url;
            
        //    NSLog(@"%@:%@",event2n.url,event2n.name);
            
            // if(event.latitude != 0.0 || event2.latitude != 0.0){        
            [eventPoints2_new addObject:self.normalAnnotation];
            // }
            
            count2n++;
            //  NSLog(@"count:%d",count);
            if(count2n == 17) {
                //limit number of events to 300
                break;
            }
        }
        
        self.normalAnnotation=nil;

        
        while (1) {
            eventb = [[[computingCenter alloc] init] autorelease];
            eventb.name = [mysupercomputersb objectAtIndex:countb];
            eventb.org= [myorganizationb objectAtIndex:countb];
            //NSLog(@"In the loop: Name:%@",[mysupercomputers2 objectAtIndex:count]); 
            eventb.latitude = [[mylatitudesb objectAtIndex:countb] doubleValue];
            eventb.longitude = [[mylongitudesb objectAtIndex:countb] doubleValue];
            //event.CPUTime = [[values objectAtIndex:4] floatValue];
            eventb.url=[myurlb objectAtIndex:countb];
            
            self.normalAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:eventb.latitude andLongitude:eventb.longitude] autorelease];
            self.normalAnnotation.title=eventb.name;
            self.normalAnnotation.subtitle=eventb.org;
            self.normalAnnotation.url=eventb.url;
            
            // if(event.latitude != 0.0 || event2.latitude != 0.0){        
            [eventPoints_black addObject:self.normalAnnotation];
            // }
            
            countb++;
            //  NSLog(@"count:%d",count);
            if(countb == 17) {
                //limit number of events to 300
                break;
            }
        }
        
        self.normalAnnotation=nil;
 
        while (1) {
            event2b = [[[computingCenter alloc] init] autorelease];
            event2b.name = [mysupercomputers2b objectAtIndex:count2b];
            event2b.org= [myorganization2b objectAtIndex:count2b];
            //NSLog(@"In the loop: Name:%@",[mysupercomputers2 objectAtIndex:count]); 
            event2b.latitude = [[mylatitudes2b objectAtIndex:count2b] doubleValue];
            event2b.longitude = [[mylongitudes2b objectAtIndex:count2b] doubleValue];
            //event.CPUTime = [[values objectAtIndex:4] floatValue];
            event2b.url=[myurl2b objectAtIndex:count2b];
            
            self.normalAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:event2b.latitude andLongitude:event2b.longitude] autorelease];
            self.normalAnnotation.title=event2b.name;
            self.normalAnnotation.subtitle=event2b.org;
            self.normalAnnotation.url=event2b.url;
            
            // if(event.latitude != 0.0 || event2.latitude != 0.0){        
            [eventPoints2_black addObject:self.normalAnnotation];
            // }
            
            count2b++;
            //  NSLog(@"count:%d",count);
            if(count2b == 12) {
                //limit number of events to 300
                break;
            }
        }

        
        
        [_mapView addAnnotations:eventPoints];
        [_mapView addAnnotations:eventPoints_new];
        [_mapView addAnnotations:eventPoints2];
        [_mapView addAnnotations:eventPoints2_new];
        [_mapView addAnnotations:eventPoints_black];
        [_mapView addAnnotations:eventPoints2_black];
        
        //  NSLog(@"MAP VIEW CHOSEN!");
      //  [self.navigationController popViewControllerAnimated:YES];
      //  [self.navigationController pushViewController:mapViewController animated:YES];
    }
    
}

- (void)viewDidLoad {
    
    
  //  [self.activityView startAnimating];
    
    [activity startAnimating];
            
   top500Bool=NO;
    
    NOV11 = TRUE;
  
   self.mapView.delegate=self;
 //  self.bannerView.delegate= self;
    
 ///   bannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
 //   bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
 //   [self.view addSubview:bannerView];
    
  //  NSLog(@"BANNER X = %4.4f",bannerView.frame.size.width);
  //   NSLog(@"BANNER Y = %4.4f",bannerView.frame.size.height);
    
 //   [bannerView release];
    
 //   self.bannerIsVisible = YES;

    //   NSString *finalPath = [[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"];
    
    // Look in Documents for an existing plist file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *finalPath = [documentsDirectory stringByAppendingPathComponent: 
                   [NSString stringWithFormat: @"%@.plist",@"Property List"] ];
  //  [finalPath retain];
    
    // If it's not there, copy it from the bundle
    NSFileManager *fileManger = [NSFileManager defaultManager];
   // if([fileManger fileExistsAtPath:finalPath]){
    [fileManger removeItemAtPath:finalPath error:nil];

    if ( ![fileManger fileExistsAtPath:finalPath] ) {
        NSString *pathToSettingsInBundle = [[NSBundle mainBundle] 
                                            pathForResource:@"Property List" ofType:@"plist"];
        NSError *error = nil;
        
        [[NSFileManager defaultManager] copyItemAtPath:pathToSettingsInBundle
                                                toPath:finalPath
                                                 error:&error];  
        
     //   NSLog(@"Path to Plist in Bundle:%@",pathToSettingsInBundle);
     //   NSLog(@"Path to Plist in Document:%@",finalPath);
     //   NSLog(@"Error: %@", [error description]);
    
   }		
    
       
   // NSLog(@"Path to Plist in Bundle:%@",pathToSettingsInBundle);
   // NSLog(@"Path to Plist in Document:%@",finalPath);
    
   
     
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath] ;
    
    
    
   //  NSDictionary *plistData = [[NSDictionary dictionaryWithContentsOfFile:@"Property List.plist"] retain];
    
    //   if(plistData != nil)
    // NSLog(@"plistData created");

    NSDictionary *top500 = [plistData objectForKey:@"TOP500"] ;
    NSDictionary *green500 = [plistData objectForKey:@"GREEN500"] ;
    
    NSArray *mysupercomputers = [top500 objectForKey:@"Name"] ;
    NSArray *mysupercomputers2 = [green500 objectForKey:@"Name"] ;
    
    NSArray *myorganization = [top500 objectForKey:@"Organization"] ;
    NSArray *myorganization2 = [green500 objectForKey:@"Organization"] ;
      
    NSArray *myurl = [top500 objectForKey:@"URL"] ;
    NSArray *myurl2 = [green500 objectForKey:@"URL"] ;
    
    NSArray *mylatitudes =  [[plistData objectForKey:@"TOP500"] objectForKey:@"Latitude"] ;
    NSArray *mylatitudes2 =  [[plistData objectForKey:@"GREEN500"] objectForKey:@"Latitude"]  ;
    
    NSArray *mylongitudes = [[plistData objectForKey:@"TOP500"] objectForKey:@"Longitude"]  ;
    NSArray *mylongitudes2 = [[plistData objectForKey:@"GREEN500"] objectForKey:@"Longitude"] ;
    
    int count=0;
    int count2=0;
 
    eventPoints = [[NSMutableArray array] retain];
    eventPoints2 = [[NSMutableArray array] retain] ;
    computingCenter *event;
    computingCenter *event2;

//   event = [[computingCenter alloc] init];
//   event2 = [[computingCenter alloc] init] ;
//   event=nil;
//   event2=nil;
    
    while (1) {
        
    // values = [line componentsSeparatedByString:@","];
     //   NSLog(@"name:%@",event.name);
        event = [[[computingCenter alloc] init] autorelease];
        event.name = [mysupercomputers objectAtIndex:count2];
      //  NSLog(@"name:%@",event.name);
        event.org= [myorganization objectAtIndex:count2];
        // NSLog(@"In the loop: Name:%@",[mysupercomputers objectAtIndex:count]); 
        event.latitude = [[mylatitudes objectAtIndex:count2] doubleValue];
        event.longitude = [[mylongitudes objectAtIndex:count2] doubleValue];
        event.url=[myurl objectAtIndex:count2] ;
        // event.CPUTime = [[values objectAtIndex:4] floatValue];
        
        self.normalAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:event.latitude andLongitude:event.longitude] autorelease];
        self.normalAnnotation.title=event.name;
     // self.normalAnnotation.subtitle=event.org;
        self.normalAnnotation.subtitle=event.org;
        self.normalAnnotation.url=event.url;

        //[self.mapView addAnnotation:self.customAnnotation];
         [eventPoints addObject:self.normalAnnotation];
              
        count2++;
      //  NSLog(@"count:%d",count2);
        if(count2 == 34) {
            //limit number of events to 300
            break;
        }

       // [event release];    
    }  
       
    while (1) {
        event2 = [[[computingCenter alloc] init] autorelease];
        event2.name = [mysupercomputers2 objectAtIndex:count];
        event2.org= [myorganization2 objectAtIndex:count];
        //NSLog(@"In the loop: Name:%@",[mysupercomputers2 objectAtIndex:count]); 
        event2.latitude = [[mylatitudes2 objectAtIndex:count] doubleValue];
        event2.longitude = [[mylongitudes2 objectAtIndex:count] doubleValue];
        //event.CPUTime = [[values objectAtIndex:4] floatValue];
        event2.url=[myurl2 objectAtIndex:count];
        
        self.normalAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:event2.latitude andLongitude:event2.longitude] autorelease];
        self.normalAnnotation.title=event2.name;
        self.normalAnnotation.subtitle=event2.org;
        self.normalAnnotation.url=event2.url;
       
       // if(event.latitude != 0.0 || event2.latitude != 0.0){        
        [eventPoints2 addObject:self.normalAnnotation];
       // }
        
        count++;
      //  NSLog(@"count:%d",count);
        if(count == 36) {
            //limit number of events to 300
            break;
        }
    }
 //  NSLog(@"Outside the loop");
    
    [_mapView addAnnotations:eventPoints];
    [_mapView addAnnotations:eventPoints2];
    //[top500 release];
    
    NSArray * segmentItems= [NSArray arrayWithObjects: @"Nov 2011", @"Jun 2012", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentItems];
    [segmentedControl setSelectedSegmentIndex:0];
    [segmentedControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [segmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    [[self navigationItem] setTitleView:segmentedControl];
    [segmentedControl release];
    
    
     timer = [NSTimer scheduledTimerWithTimeInterval:(0.5) target:self selector:@selector(loading) userInfo:nil repeats:YES];
    
    [super viewDidLoad];  
           
}

- (void)viewDidUnload {
	self.mapView = nil;
	self.normalAnnotation = nil;
    self.activity=nil;
}





@end
