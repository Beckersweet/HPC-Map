//
//  GCHandler.m
//  HPCmap
//
//  Created by Argun Tekant on 2012-10-18.
//
//

#import "GCHandler.h"

@implementation GCHandler
@synthesize gameCenterAvailable;
@synthesize presentingViewController;
@synthesize match;
@synthesize delegate;

#pragma mark Initialization

static GCHandler *sharedHandler= nil;

+ (GCHandler *) sharedInstance
{
    if (!sharedHandler)
	{
        sharedHandler= [[GCHandler alloc] init];
    }
    return sharedHandler;
}

// Implemented as stated in Game Kit Programming Guide although it doesn't make sense anymore
// Not going to tempt fate or 
- (BOOL)isGameCenterAvailable
{
    // check for presence of GKLocalPlayer API
    Class gcClass= (NSClassFromString(@"GKLocalPlayer"));
	
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
										   options:NSNumericSearch] != NSOrderedAscending);
	
    return (gcClass && osVersionSupported);
}

- (id)init
{
    if ((self = [super init])) {
        gameCenterAvailable= [self isGameCenterAvailable];
        if (gameCenterAvailable)
		{
            NSNotificationCenter *nc= [NSNotificationCenter defaultCenter];
            [nc addObserver:self selector:@selector(authenticationChanged) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
        }
    }
    return self;
}

- (void)authenticationChanged
{
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated)
	{
		DebugLog(@"Authentication changed: player authenticated.");
		userAuthenticated= TRUE;
    }
	else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated)
	{
		DebugLog(@"Authentication changed: player not authenticated");
		userAuthenticated= FALSE;
    }
	
}

- (void)authenticateLocalUser
{
    if (!gameCenterAvailable)
		return;
	
    DebugLog(@"Authenticating local user...");
    if ([GKLocalPlayer localPlayer].authenticated == NO)
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
    else
		DebugLog(@"Already authenticated!");
}

- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers
				 viewController:(UIViewController *)viewController
					   delegate:(id<GCHandlerDelegate>)theDelegate
{
    if (!gameCenterAvailable)
		return;
	
    matchStarted= NO;
    self.match= nil;
    self.presentingViewController= viewController;
    delegate= theDelegate;
    [presentingViewController dismissModalViewControllerAnimated:NO];
	
    GKMatchRequest *request= [[GKMatchRequest alloc] init];
    request.minPlayers= minPlayers;
    request.maxPlayers= maxPlayers;
	
    GKMatchmakerViewController *mmvc= [[GKMatchmakerViewController alloc] initWithMatchRequest:request];
    mmvc.matchmakerDelegate= self;
	
    [presentingViewController presentModalViewController:mmvc animated:YES];
	
}

- (void)reportScore:(int64_t)score forCategory:(NSString *)category
{
	GKScore *scoreReporter= [[GKScore alloc] initWithCategory:category];
	scoreReporter.value = score;
	[scoreReporter reportScoreWithCompletionHandler: ^(NSError *error)
	 {
		 DebugLog(@"Score reported for category %@: %lld", category, score);
	 }];
}

#pragma mark - Match making
- (void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController *)viewController
{
	DebugLog(@"matchmakerViewControllerWasCancelled");
}

- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFailWithError:(NSError *)error
{
	DebugLog(@"matchmakerViewController didFailWithError: %@", error);
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID;
{
	DebugLog(@"match didReceiveData:%@\nfromPlayer:%@", data, playerID);
}

@end
