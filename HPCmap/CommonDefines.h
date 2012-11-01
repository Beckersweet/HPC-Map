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


// HPC Specific constants
//#define kMyFeatureIdentifier				@"com.beckersweet.hpcmap.inapptest"
//#define kInAppPurchaseProUpgradeProductId	@"com.beckersweet.hpcmap.inapptest"
//#define kMyFeatureIdentifier				@"com.beckersweet.hpcmap.inapp.removeads"
//#define kInAppPurchaseProUpgradeProductId	@"com.beckersweet.hpcmap.inapp.removeads"

#define HPCFacebookURL						@"http://www.facebook.com/pages/HPC-Map-iPhone-App/321586984527863"
#define kPurchasedLevelKey					@"PurchasedLevel"

#define kPurchaseLevelPay1ProductId			@"com.beckersweet.hpcmap.inapp.removeads"
#define kPurchasedLevelValueFree			0
#define kPurchasedLevelValuePay1			1
#define kPurchasedLevelValuePay2			2

#define kDifficultyLevelTextBlank			@" "
#define kDifficultyLevelTextEasy			@"Easy"
#define kDifficultyLevelTextMedium			@"Medium"
#define kDifficultyLevelTextHard			@"Hard"
#define kLevelButtonNamePadding				@"   "


// HPC Specific macros
#define requiredPayLevel(l)	(NSInteger)([payLevels characterAtIndex:l]-'0')
#define StoredPayLevel		[[NSUserDefaults standardUserDefaults] integerForKey:kPurchasedLevelKey]
