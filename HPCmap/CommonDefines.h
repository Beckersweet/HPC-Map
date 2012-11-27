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

// Uncomment the following line to not bother with purchases. Works only in DEBUG mode
//#define EVERYTHINGFREE

#define HPCFacebookURL						@"http://m.facebook.com/pages/HPC-Map-iPhone-App/321586984527863"
#define HPCFacebookMobileURL				@"http://m.facebook.com/pages/HPC-Map-iPhone-App/321586984527863"
#define kPurchasedLevelKey					@"PurchasedLevel"

#define kPurchaseLevelPay1ProductId			@"com.beckersweet.hpcmap.inapp.quiz1"
#define kPurchasedLevelValueFree			0
#define kPurchasedLevelValuePay1			1
#define kPurchasedLevelValuePay2			2

#define kDifficultyLevelTextBlank			@" "
#define kDifficultyLevelTextEasy			@"Easy"
#define kDifficultyLevelTextMedium			@"Medium"
#define kDifficultyLevelTextHard			@"Hard"
#define kLevelButtonNamePadding				@"   "

#define kDifficultyLevelTagEasy				@"_easy1"
#define kDifficultyLevelTagMedium			@"_medium1"
#define kDifficultyLevelTagHard				@"_hard1"
#define kDifficultyLevelTagCombo			@"_comb1"


// HPC Specific macros
#define requiredPayLevel(l)	(NSInteger)([payLevels characterAtIndex:l]-'0')
#define StoredPayLevel		[[NSUserDefaults standardUserDefaults] integerForKey:kPurchasedLevelKey]
