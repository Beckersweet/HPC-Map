//
//  FBHandler.m
//  HPCmap
//
//  Created by Argun Tekant on 2012-10-03.
//
//

#import "FBHandler.h"

@implementation FBHandler
@synthesize attachedViewController;

+(BOOL)isSocialFrameworkAvailable
{
	// whether the iOS6 Social framework is available?
    return NSClassFromString(@"SLComposeViewController") != nil;
}

- (id)init
{
	if (self = [super init])
	{
		if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
			return nil;
	}
	
	return self;

}

- (void)postImage:(UIImage *)image withMessage:(NSString *)message
{
	if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
	{
		DebugLog(@"No facebook");
		return;
	}

	SLComposeViewController *controller= [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
	[controller setInitialText:message];
	[controller addURL:[NSURL URLWithString:HPCFacebookURL]];
	[controller addImage:image];
	
	SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result)
	{
		switch (result)
		{
			case SLComposeViewControllerResultCancelled:
				DebugLog(@"Cancelled");
				break;
			case SLComposeViewControllerResultDone:
			{
				DebugLog(@"Sent");
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Image posted" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert show];
			}
				break;
			default:
				DebugLog(@"Mystery button");
				break;
		}
		[controller dismissViewControllerAnimated:YES completion:Nil];
	};
	controller.completionHandler =myBlock;

	[attachedViewController presentViewController:controller animated:YES completion:nil];
}

@end
