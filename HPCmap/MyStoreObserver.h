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
}
@property (nonatomic,assign) id <AppleServerConnectionDelegate> delegate;

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction;
- (void) completeTransaction: (SKPaymentTransaction *)transaction;
- (void) failedTransaction: (SKPaymentTransaction *)transaction;
- (void) restoreTransaction: (SKPaymentTransaction *)transaction;
-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction;
-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error;

@end

@protocol AppleServerConnectionDelegate

-(void)AppleServerConnection:(MyStoreObserver*)connection
         didReceiveData:(NSData*)data;

@end
