// Argun's generic defines

#define myAppDelegate		[[UIApplication sharedApplication] delegate]
#define DOCUMENTS_FOLDER	[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define bundlePath			[[NSBundle mainBundle] bundlePath]
#define appName				[[NSBundle mainBundle] objectForInfoDictionaryKey:kCFBundleNameKey]
#define deviceName			[[UIDevice currentDevice] name] 

#ifdef DEBUG
#define DebugLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... )
#endif


// HPC Specific
#define HPCFacebookURL		@"http://www.facebook.com/pages/HPC-Map-iPhone-App/321586984527863"