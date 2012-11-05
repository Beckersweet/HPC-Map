//
//  Achievement.h
//  HPCmap
//
//  Created by Argun Tekant on 2012-11-05.
//
//

#import <Foundation/Foundation.h>

@interface Achievement : NSObject
{
	NSString *achievement;
	NSString *name;
	NSString *trigger;
	NSInteger triggerValue;
}

@property (nonatomic, strong) NSString *achievement;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *trigger;
@property (nonatomic, assign) NSInteger triggerValue;

- (id)initWithData:(NSDictionary *)achievementEntry;

@end
