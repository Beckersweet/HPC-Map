//
//  MyStoreObserver.h
//  HPCmap
//
//  Created by Barbara Collignon on 7/18/12.
//  Copyright (c) 2012 Beckersweet Technology Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h> 
#import <StoreKit/SKPaymentTransaction.h> 

@protocol AppleServerConnectionDelegate;

@interface MyStoreObserver : NSObject <SKPaymentTransactionObserver> 
{
    id <AppleServerConnectionDelegate> delegate ;
     NSMutableData   *receiveData;
	
	id callingController;
}
@property (nonatomic,assign) id <AppleServerConnectionDelegate> delegate;
@property (nonatomic, assign) id callingController;

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction;
- (void) completeTransaction: (SKPaymentTransaction *)transaction;
- (void) failedTransaction: (SKPaymentTransaction *)transaction;
- (void) restoreTransaction: (SKPaymentTransaction *)transaction;
-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction;
-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error;

- (void)handleSuccessfulPurchaseResults:(SKPaymentTransaction *)transaction;
- (void)handleFailedPurchaseResults:(SKPaymentTransaction *)transaction;
- (void)handleFailedRestoreResults:(SKPaymentTransaction *)transaction;
- (void)saveTransactionResults:(SKPaymentTransaction *)transaction;

@end

@protocol AppleServerConnectionDelegate

-(void)AppleServerConnection:(MyStoreObserver*)connection
         didReceiveData:(NSData*)data;

@end
