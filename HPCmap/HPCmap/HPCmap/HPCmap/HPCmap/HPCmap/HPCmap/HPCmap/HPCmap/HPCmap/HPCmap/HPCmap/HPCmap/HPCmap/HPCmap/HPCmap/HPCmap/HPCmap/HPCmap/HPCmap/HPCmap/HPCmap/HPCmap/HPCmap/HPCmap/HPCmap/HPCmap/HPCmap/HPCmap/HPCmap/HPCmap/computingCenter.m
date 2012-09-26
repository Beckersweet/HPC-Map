//
//  computingCenter.m
//  HPCmap
//
//  Created by Barbara Collignon on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "computingCenter.h"

@implementation computingCenter

@synthesize latitude;
@synthesize longitude;
@synthesize CPUTime;
@synthesize name;
@synthesize org;
@synthesize url;

@synthesize coordinate;

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coord = {self.latitude, self.longitude};
    return coord;
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"%1.3f, %1.3f, %1.3f", 
            self.latitude, self.longitude, self.CPUTime];
}
@end


