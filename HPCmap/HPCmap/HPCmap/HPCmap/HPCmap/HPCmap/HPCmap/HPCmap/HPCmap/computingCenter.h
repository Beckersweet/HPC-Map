//
//  computingCenter.h
//  HPCmap
//
//  Created by Barbara Collignon on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface computingCenter : NSObject  <MKAnnotation> {
 
    double latitude;
    double longitude;
    NSString *name;
    NSString *org;
    NSString *url;
    float CPUTime;
   
}

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic,assign) NSString *name;
@property (nonatomic,assign) NSString *org;
@property (nonatomic,assign) NSString *url;

@property (nonatomic) float CPUTime;




//MKAnnotation
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end

