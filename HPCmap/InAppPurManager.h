//
//  InAppPurManager.h
//  HPCmap
//
//  Created by Barbara Collignon on 7/18/12.
//  Copyright (c) 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "MyStoreObserver.h"
#import <StoreKit/StoreKit.h>
#import <StoreKit/SKPaymentTransaction.h>
#import <UIKit/UIKit.h>
#import "CommonDefines.h"

// add a couple notifications sent out when the transaction completes
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"


@interface InAppPurManager : NSObject <SKProductsRequestDelegate>
{
    
    MyStoreObserver *observer;
//
	SKProduct *productNoAds;
	SKProduct *productGamesLevel2;
	SKProduct *productGamesLevel3;
    SKProductsRequest *productsRequest;
    
	id callingController;
}

@property (nonatomic, retain) SKProduct *productNoAds;
@property (nonatomic, retain) SKProduct *productGamesLevel2;
@property (nonatomic, retain) SKProduct *productGamesLevel3;
@property (nonatomic, retain) MyStoreObserver *observer;
@property (nonatomic, retain) id callingController;

// public methods

- (BOOL)canMakePurchases;
- (void)requestProductData;
+ (InAppPurManager *) sharedInstance ;
+ (InAppPurManager *) RemoveAdsPurchased ; 


@end