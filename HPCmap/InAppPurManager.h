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

// add a couple notifications sent out when the transaction completes
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"


@interface InAppPurManager : NSObject <SKProductsRequestDelegate,SKProductsRequestDelegate>
{
    
    MyStoreObserver *observer ;
//
    
}

// public methods

- (BOOL)canMakePurchases;
+ (InAppPurManager *) sharedInstance ;
+ (InAppPurManager *) RemoveAdsPurchased ; 


@end