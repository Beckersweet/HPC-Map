//
//  QuizClass.m
//  HPCmap
//
//  Created by Argun Tekant on 2012-10-23.
//
//

#import "QuizClass.h"

@implementation QuizClass
@synthesize name, difficulties, payLevels, leaderboard;

- (id)initWithData:(NSDictionary *)classEntry
{
	if (self= [super init])
	{
		name=			[classEntry objectForKey:@"Name"];
		difficulties=	[classEntry objectForKey:@"Difficulties"];
		payLevels=		[classEntry objectForKey:@"Paylevels"];
		leaderboard=	[classEntry objectForKey:@"Leaderboard"];
	}
	return self;
}

@end
