//
//  HPCMapViewController.h
//  HPCmap
//
//  Created by Barbara Collignon on 8/30/11.
//  Copyright 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"
#import <iAd/iAd.h>
#import "InAppPurManager.h"

@interface HPCMapViewController : UIViewController <MKMapViewDelegate,
UIScrollViewDelegate,ADBannerViewDelegate> {
//	UIActivityIndicatorView *activityView;
    MKMapView *_mapView;
    MKAnnotationView *_selectedAnnotationView;
	BasicMapAnnotation *_customAnnotation;
	BasicMapAnnotation *_normalAnnotation;
    NSMutableArray *eventPoints;
    NSMutableArray *eventPoints2;
     NSMutableArray *eventPoints_new;
    NSMutableArray *eventPoints2_new;
    NSMutableArray *eventPoints_black;
    NSMutableArray *eventPoints2_black;
    MKAnnotationView *greenpin;
    MKAnnotationView *toppin;
    UIActionSheet *actionSheet ;
    ADBannerView *bannerView;
    BOOL top500Bool;

}

//@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;
@property (nonatomic, retain) UIActionSheet *actionSheet;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) MKAnnotationView *selectedAnnotationView;
@property (nonatomic, retain) ADBannerView *bannerView;
@property (nonatomic,assign) BOOL bannerIsVisible;
@property (nonatomic,assign) BOOL NOV11;

-(void) loading ;

@end

NSTimer *timer;