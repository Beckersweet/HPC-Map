//
//  Achievement.m
//  HPCmap
//
//  Created by Argun Tekant on 2012-11-05.
//
//

#import "Achievement.h"

@implementation Achievement
@synthesize name, achievement, trigger, triggerValue;

- (id)initWithData:(NSDictionary *)achievementEntry
{
	if (self= [super init])
	{
		name=			[achievementEntry objectForKey:@"Name"];
		achievement=	[achievementEntry objectForKey:@"Achievement"];
		trigger=		[achievementEntry objectForKey:@"Trigger"];
		triggerValue=	[(NSNumber *)[achievementEntry objectForKey:@"Value"] integerValue];
	}
	return self;
}


@end
