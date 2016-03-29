#include "Utils.h"
#import <UIKit/UIKit.h>
#import <Batch/Batch.h>

extern "C" void sendBatchEvent(const char* type, const char* arg1, const char* arg2, const char* arg3);

@interface BatchExtension : NSObject<UIApplicationDelegate, BatchUnlockDelegate>
+ (BatchExtension *)instance;
@end


@implementation BatchExtension 


+ (BatchExtension *)instance{
			static BatchExtension *instance;

			@synchronized(self){
			if (!instance)
				instance = [[BatchExtension alloc] init];

			return instance;
			}
		}



- (void) initBatch :(NSString*)key
{
	NSLog(@"connect with id: %@",key);
	
	[BatchUnlock setupUnlockWithDelegate:self];	
	[Batch startWithAPIKey:key];
	
	[BatchPush registerForRemoteNotifications];
	
	sendBatchEvent("INIT", "", "", "");
}

- (void)automaticOfferRedeemed:(id<BatchOffer>)offer
{
    NSLog(@"automaticOfferRedeemed ");
    // Features treatment.
    for (id<BatchFeature> feature in [offer features])
    {
        NSString *reference = feature.reference;
        NSString *value = feature.value;
        
        // Unlock this feature to the user.
        NSLog(@"automaticOfferRedeemed Feature ref= %@  value= %@", reference, value);
		sendBatchEvent("REDEEM_OFFER", "FEATER", [reference UTF8String], [value UTF8String]);
    }
    
    NSLog(@"automaticOfferRedeemed 2");

    
    // Resources treatment.
    for (id<BatchResource> resource in [offer resources])
    {
        NSString *reference = resource.reference;
        NSUInteger quantity = resource.quantity;
        
        // Provide this resource quantity to the user.
		NSLog(@"automaticOfferRedeemed Ressource ref= %@  value= %@", reference, [NSString stringWithFormat:@"%li", (unsigned long)quantity]);

		sendBatchEvent("REDEEM_OFFER", "RESSOURCE", [reference UTF8String], [[NSString stringWithFormat:@"%li", (unsigned long)quantity]UTF8String]);
    }
    
    NSDictionary *parameters = [offer offerAdditionalParameters];
    NSString *rewardMessage = [parameters objectForKey:@"reward_message"];
    NSString *reward_title = [parameters objectForKey:@"reward_title"];
    NSString *reward_button_ok = [parameters objectForKey:@"reward_button_OK"];
    
    if (reward_button_ok == nil)
	reward_button_ok = [[NSString alloc] initWithUTF8String:"Ok"];
	
	if (rewardMessage != nil && reward_title != nil)
    {
		// Build the AlertView
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:reward_title message:rewardMessage delegate:nil cancelButtonTitle:reward_button_ok otherButtonTitles:nil];
		[alert show];
	}
}

@end


namespace batchextension {

	static BatchExtension* batchExtension = nil;

	void initBatch( const char *key){
		NSLog(@"batchextension initBatch");
		
		batchExtension = [[BatchExtension alloc] init];
		NSString* NSKey = [[NSString alloc] initWithUTF8String:key];

		[batchExtension initBatch:NSKey];
	}
}
