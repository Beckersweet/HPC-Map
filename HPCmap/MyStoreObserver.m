//
//  MyStoreObserver.m
//  HPCmap
//
//  Created by Barbara Collignon on 7/18/12.
//  Copyright (c) 2012 Beckersweet Technology Inc. All rights reserved.
//

#import "MyStoreObserver.h"
#import<UIKit/UIKit.h>
#import<UIKit/UIAlert.h>
#import "JSON.h"

#import "InAppPurManager.h"

#define debug(format, ...) CFShow([NSString stringWithFormat:format, ## __VA_ARGS__]);


@interface MyStoreObserver(private)
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
//- (void)searchReceipt:(SKPaymentTransaction *)transaction;
- (BOOL)verifyReceipt:(SKPaymentTransaction *)transaction;
- (NSString *)encode:(const uint8_t *)input length:(NSInteger)length;
@end


//tutorial: http://forum.thegamecreators.com/?m=forum_view&t=191568&b=41

@implementation MyStoreObserver

@synthesize delegate;
@synthesize callingController;

- (BOOL)verifyReceipt:(SKPaymentTransaction *)transaction {
    NSString *jsonObjectString = [self encode:(uint8_t *)transaction.transactionReceipt.bytes length:transaction.transactionReceipt.length];
	DebugLog(@"verifyReceipt: %@", jsonObjectString);
  //  NSString *completeString = [NSString stringWithFormat:@"https://sandbox.itunes.apple.com/verifyReceipt", jsonObjectString];      
    NSString *completeString = [NSString stringWithFormat:@"https://sandbox.itunes.apple.com/verifyReceipt"];
    NSURL *urlForValidation = [NSURL URLWithString:completeString];       
    NSMutableURLRequest *validationRequest = [[NSMutableURLRequest alloc] initWithURL:urlForValidation];              
    [validationRequest setHTTPMethod:@"GET"];         
    NSData *responseData = [NSURLConnection sendSynchronousRequest:validationRequest returningResponse:nil error:nil];  
    [validationRequest release];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
    NSInteger response = [responseString integerValue];
    [responseString release];
    return (response == 0);
}

- (NSString *)encode:(const uint8_t *)input length:(NSInteger)length {
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData *data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t *output = (uint8_t *)data.mutableBytes;
    
    for (NSInteger i = 0; i < length; i += 3) {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger index = (i / 3) * 4;
        output[index + 0] =                    table[(value >> 18) & 0x3F];
        output[index + 1] =                    table[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
}

/*
- (void)searchReceipt:(SKPaymentTransaction *)transaction {
    
 //   NSString *urlString = [NSString stringWithFormat:@"http://www.myURL.com/vReceipt.php?receipt=%@"];
    
  //  NSURL *sandboxStoreURL = [[NSURL alloc] initWithString: @"https://sandbox.itunes.apple.com/verifyReceipt"];
    
     NSString *sandboxStoreURL = [NSString stringWithFormat:@"https://sandbox.itunes.apple.com/verifyReceipt"];
    
    // Create NSURL string from formatted string
//	NSURL *url = [NSURL URLWithString:urlString];
    NSURL *url = [NSURL URLWithString:sandboxStoreURL];
    
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [request release]; 
    
    if(connection){
        
        if (receiveData != nil) {
            [receiveData release];
            receiveData = nil;
        }
        receiveData=[[NSMutableData data] retain];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //        [connection release];
        //        connection=nil;
    } else {
        //  NSLog(@"search could not be performed");
    }
    
    
    [connection release];
    // [request release];

    
}
*/

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
	DebugLog(@"4 - paymentQueue");
	
	for (SKPaymentTransaction* transaction in transactions)
	{
		switch (transaction.transactionState)
		{
			case SKPaymentTransactionStatePurchased:
//				DebugLog(@"Complete Transaction");
				[self completeTransaction:transaction];
              //  [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
				break;
				
			case SKPaymentTransactionStateFailed:
				[self failedTransaction:transaction];
//				DebugLog(@"failed Transaction");
				break;
				
			case SKPaymentTransactionStateRestored:
				[self restoreTransaction:transaction];
//            	DebugLog(@"restoreTransaction");
				break;
				
            case SKPaymentTransactionStatePurchasing:
               // [self PurchasedTransaction:transaction];
               //  [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
               // [self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
				DebugLog(@"PurchasingTransaction");
                break;
                        
			default:
				break;
		}
	}
}

-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction
{
    DebugLog(@"Purchased Transaction");
	 
    NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];
	[self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
	[transactions release];
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
	// Your application should implement these two methods.
    //   [self recordTransaction: transaction];
    //   [self provideContent: transaction.payment.productIdentifier];
    
  //  [self searchReceipt];
    
      DebugLog(@"complete Transaction");
    
	if (transaction.transactionState==SKPaymentTransactionStatePurchased) 
	{
//		[InAppPurManager RemoveAdsPurchased];
		[self handleSuccessfulPurchaseResults:transaction];
	}
	
   // NSArray *transactions = [[SKPaymentQueue defaultQueue] transactions];
   // for(id transaction in transactions){
   //     [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
   // }
    
	// Remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
	
	DebugLog(@"Transaction　complete");
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
	DebugLog(@"failedTransaction: %@", transaction.JSONRepresentation);
    
	[self handleFailedPurchaseResults:transaction];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"failedTransaction" object:nil];
	[[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    //[self recordTransaction: transaction];
    //[self provideContent: transaction.originalTransaction.payment.productIdentifier];
	
	// save data
	// change ads state
    DebugLog(@"restoreTransaction");
    
	// This was superfluous
	//[InAppPurManager RemoveAdsPurchased];
	
	if (transaction.transactionState == SKPaymentTransactionStatePurchased ||
		transaction.transactionState == SKPaymentTransactionStateRestored) 
	{
//        [InAppPurManager RemoveAdsPurchased];
		[self handleSuccessfulPurchaseResults:transaction];
	}
	
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

//-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction
-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentQueue *)queue
{
	DebugLog(@"paymentQueueRestoreCompletedTransactionsFinished:%d", queue.transactions.count);
}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
	DebugLog(@"restoreCompletedTransactionsFailedWithError:%@", error);
	[self handleFailedPurchaseResults:nil];
}

// use this to get the receipt
#pragma mark connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	DebugLog(@"%@",  [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]);
	//[self.receivedData appendData:data];
     [receiveData setLength:0];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
       
    [delegate AppleServerConnection:self didReceiveData:receiveData];
    
    if (receiveData != nil) {
        NSString *jsonString=[[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
        
        debug(@"jsonString: %@", jsonString);
        
        // Create a dictionary from the JSON string
        if([jsonString JSONValue] != nil){
            NSDictionary *results = [jsonString JSONValue];
            
            NSArray *receipt=nil;
            DebugLog(@"Returned JSON stuf: %@, %@", results, receipt);
             
        
        [jsonString release];
        jsonString=nil;
        }
        //   NSLog(@"here again6");
        
    [receiveData release];
    receiveData=nil;
    //  [connection release];
    //  connection=nil;
    }
    
   
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    
    [receiveData release];
    receiveData=nil;
    [connection release];
    connection=nil;
    
}

#pragma mark - Local store
- (void)handleSuccessfulPurchaseResults:(SKPaymentTransaction *)transaction
{
	[InAppPurManager RemoveAdsPurchased];
	[self saveTransactionResults:transaction];
	[self.callingController performSelector:@selector(purchaseCompleted) withObject:nil afterDelay:1];
}

- (void)handleFailedPurchaseResults:(SKPaymentTransaction *)transaction
{
	[self.callingController performSelector:@selector(purchaseCompleted) withObject:nil];
}

- (void)saveTransactionResults:(SKPaymentTransaction *)transaction
{
	NSUserDefaults *prefs= [NSUserDefaults standardUserDefaults];
	NSInteger purchasedLevel= 0;
	
	if ([transaction.payment.productIdentifier isEqualToString:kPurchaseLevelPay1ProductId])
		purchasedLevel= kPurchasedLevelValuePay1;
	
	[prefs setInteger:purchasedLevel forKey:kPurchasedLevelKey];
	[prefs synchronize];

}

@end