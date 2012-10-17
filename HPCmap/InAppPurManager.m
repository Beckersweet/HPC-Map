//
//  InAppPurManager.m
//  HPCmap
//
//  Created by Barbara Collignon on 7/18/12.
//  Copyright (c) 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "InAppPurManager.h"
#import "MyStoreObserver.h"

#pragma mark SotoreKit method
// kMyFeatureIdentifier is the product id which you defined in the iTunes Connect
#define kMyFeatureIdentifier @"com.beckersweet.hpcmap.inapptest"
#define kInAppPurchaseProUpgradeProductId @"com.beckersweet.hpcmap.inapptest"

// case of mulyiple products: http://stackoverflow.com/questions/4223366/iphone-in-app-purchase-problem
// best in app tutorial : http://troybrant.net/blog/2010/01/in-app-purchases-a-full-walkthrough/

@implementation InAppPurManager

@synthesize productNoAds, productGamesLevel2, productGamesLevel3;
@synthesize observer;


#pragma mark - Class lifecycle
- (id) init
{
    self = [super init];
    if (!self) return nil;
       
   // delegate = nil;
    
	observer= [[MyStoreObserver alloc] init];
	if ([SKPaymentQueue canMakePayments])
        [[SKPaymentQueue defaultQueue] addTransactionObserver:observer];

	
    return self;
}

- (void) dealloc
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:observer];
	[observer release];
    
    //[myselectProduct release];
    
    //if (request != nil)
    //  productsRequest = nil;
    
    [super dealloc];
}

#pragma mark - Action methods

//
// call this before making a purchase
// or to frequently check that the guy
// did nt change his in-app purchase
// set up
//
- (BOOL) canMakePurchases
{
    if ([SKPaymentQueue canMakePayments])
        return YES;
    else {
		
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Payment Error" message:@"You are not authorized to purchase from AppStore" delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];
		
        [alerView release];
        return NO;
        
    }
}

- (void)makePurchases
{
    if ([SKPaymentQueue canMakePayments]) {
        [self requestProductData];
//        [[SKPaymentQueue defaultQueue] addTransactionObserver:observer];
    } else {
        
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Payment Error" message:@"You are not authorized to purchase from AppStore" delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];
        
        [alerView release];
        
    }
    
}


// 4 - Retrieve information about products.
- (void)requestProductData
{
	DebugLog(@"1 - requestProductData");
	SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers: [NSSet setWithObject: kMyFeatureIdentifier]];
	request.delegate = self;
	[request start];
}

#pragma mark - Class methods
+ (InAppPurManager *) sharedInstance
{
    static InAppPurManager *myInstance = nil;
    
    if (nil == myInstance) {
        myInstance  = [[[self class] alloc] init];
    }
    
    return myInstance;
}

+ (InAppPurManager *) RemoveAdsPurchased {
    
    static InAppPurManager *myInstance = nil;
    
    
    DebugLog(@"REMOVE ALL ADD PURCHASED") ;
    
    
    return myInstance;
    
}

#pragma mark - Delegate methods
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
	DebugLog(@"2 - ProductsRequest did receiveResponse");
	//NSArray *myProduct = response.products;

    NSArray *myProduct = [[NSArray alloc] initWithArray:response.products];
    NSArray *invalidProducts = [[NSArray alloc] initWithArray:response.invalidProductIdentifiers];
    
   DebugLog(@"3.1 - the response description is %@", response.description);
   DebugLog(@"3.2 - the response debug description is %@", response.debugDescription);
  
    
	//NSArray *myProduct = [[NSArray alloc] initWithObjects:repon , nil
        
    DebugLog(@"3.3 - the count of valid products is %d", [myProduct count]);
    DebugLog(@"3.4 - the count of invalid products is %d", [invalidProducts count]);
	
	// populate UI
	for(SKProduct *product in myProduct)
	{
		DebugLog(@"%@", [product description]);
		DebugLog(@"%@", [product productIdentifier]);
        
        // to be changed
      //  myselectProduct = [SKProduct  product ;
	}
    
    // populate UI
	for(SKProduct *product in invalidProducts)
	{
		DebugLog(@"%@", [product description]);
		DebugLog(@"%@", [product productIdentifier]);
        
        // to be changed
        //  myselectProduct = [SKProduct  product ;
	}
	
    //SHOULD use paymentwithproduct instead of paymentwithpid
	SKPayment *payment = [SKPayment paymentWithProductIdentifier:kMyFeatureIdentifier];
	[[SKPaymentQueue defaultQueue] addPayment:payment];
	[request autorelease];
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
	UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"Alert" message:[error localizedDescription]
													   delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];
	
	[alerView show];
	[alerView release];
}



@end
