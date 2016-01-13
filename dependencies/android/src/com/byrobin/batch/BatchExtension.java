package com.byrobin.batch;


import android.app.Activity;
import android.content.res.AssetManager;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;

import com.batch.android.Batch;
import com.batch.android.Config;
import com.batch.android.BatchUnlockListener;
import com.batch.android.BatchURLListener;
import com.batch.android.BatchCodeListener;
import com.batch.android.Feature;
import com.batch.android.Offer;
import com.batch.android.FailReason;
import com.batch.android.CodeErrorInfo;
import com.batch.android.Resource;
import android.app.AlertDialog;
import java.util.Map;


import android.util.Log;
import org.haxe.lime.HaxeObject;

public class BatchExtension extends Extension {
	
	private static HaxeObject callback = null;
	
	public static void initBatch (String key, String gcm_sender_id, HaxeObject callback) {
		Log.w("trace", "BatchExtension initBatch");
		
		Batch.setConfig(new Config(key));
		if (gcm_sender_id != "")
			Batch.Push.setGCMSenderId(gcm_sender_id);
		
		Batch.Unlock.setURLListener(mBatchURLListener);
		Batch.Unlock.setUnlockListener(mBatchUnlockListener);
		Batch.onStart(Extension.mainActivity);
		
		BatchExtension.callback = callback;
		
		Extension.callbackHandler.post (new Runnable () {
						
			@Override public void run () {
				
				BatchExtension.callback.call ("batchEventReceipt", new Object[] { "INIT", "OK" , "", ""});
				
			}
						
		});	
	}
	
	/**
	 * Called when an activity you launched exits, giving you the requestCode 
	 * you started it with, the resultCode it returned, and any additional data 
	 * from it.
	 */
	public boolean onActivityResult (int requestCode, int resultCode, Intent data) {
		Log.w("trace", "BatchExtension onActivityResult");
		return super.onActivityResult (requestCode, resultCode, data);
		
		//return true;
		}
	
	/**
	 * Called when the activity is starting.
	 */
	public void onCreate (Bundle savedInstanceState) {
		Log.w("trace", "BatchExtension onCreate");
		
		
	}
	
	/**
	 * Perform any final cleanup before an activity is destroyed.
	 */
	public void onDestroy () {
		
		 Batch.onDestroy(Extension.mainActivity);
		
	}
	
	/**
	 * Called as part of the activity lifecycle when an activity is going into
	 * the background, but has not (yet) been killed.
	 */
	public void onPause () {
	}
	
	
	/**
	 * Called after {@link #onStop} when the current activity is being 
	 * re-displayed to the user (the user has navigated back to it).
	 */
	public void onRestart () {
	}
	
	
	/**
	 * Called after {@link #onRestart}, or {@link #onPause}, for your activity 
	 * to start interacting with the user.
	 */
	public void onResume () {
	}
	
	
	/**
	 * Called after {@link #onCreate} &mdash; or after {@link #onRestart} when  
	 * the activity had been stopped, but is now again being displayed to the 
	 * user.
	 */
	public void onStart () {
		Log.w("trace", "BatchExtension onStart");
	}
	
	
	/**
	 * Called when the activity is no longer visible to the user, because 
	 * another activity has been resumed and is covering this one. 
	 */
	public void onStop () {
		 Batch.onStop(Extension.mainActivity);
	}
	
    public void onNewIntent(Intent intent)
    {
        Batch.onNewIntent(Extension.mainActivity, intent);
        super.onNewIntent(intent);
    }
	
	static BatchUnlockListener mBatchUnlockListener = new BatchUnlockListener () {
	
		@Override
		public void onRedeemAutomaticOffer(Offer offer)
		{
			// Give resources & features contained in the offer to the user
			 for(Feature feature : offer.getFeatures())
			{
				final String featureRef = feature.getReference();
				final String value = feature.getValue();
				Log.w("trace", "BatchExtension onRedeemAutomaticOffer featureRef=" + featureRef + "  value=" + value);
				// Provide the feature to the user
				
				Extension.callbackHandler.post (new Runnable () {
							
					@Override public void run () {
						
						BatchExtension.callback.call ("batchEventReceipt", new Object[] { "REDEEM_OFFER", "FEATER", featureRef, value });
						
					}
								
				});	
			}

			for(Resource resource : offer.getResources() )
			{
				final String resourceRef = resource.getReference();
				final int quantity = resource.getQuantity();
				Log.w("trace", "BatchExtension onRedeemAutomaticOffer resourceRef=" + resourceRef + "  quantity=" + quantity);
				// Give the given quantity of the resource to the user
				
				Extension.callbackHandler.post (new Runnable () {
							
					@Override public void run () {
						BatchExtension.callback.call ("batchEventReceipt", new Object[] { "REDEEM_OFFER", "RESSOURCE", resourceRef, quantity });
					}			
				});	
			}
			
			
			Map<String, String> additionalParameters = offer.getOfferAdditionalParameters();
			String rewardMessage = additionalParameters.get("reward_message");
			String rewardTitle = additionalParameters.get("reward_title");
			
			if (rewardMessage != "" || rewardTitle != "") {
				// Build the Dialog
				AlertDialog.Builder builder = new AlertDialog.Builder(Extension.mainActivity);
				builder.setMessage(rewardMessage).setTitle(rewardTitle);

				AlertDialog dialog = builder.create();
				dialog.show();
			}
		}
	};
	
	
	static BatchURLListener mBatchURLListener = new BatchURLListener () {
		@Override
		public void onURLWithCodeFound(String code)
		{
			// Function called when your app is opened from a link that contains a Batch code. You may want to display a load UI to wait for success or fail callback
		}

		@Override
		public void onURLCodeSuccess(String code, Offer offer)
		{
			// Hide wait UI

			// Give features & resources contained in the offer to the user

			// Show success UI
		}

		@Override
		public void onURLCodeFailed(String code, FailReason reason, CodeErrorInfo infos)
		{
			// Hide wait UI

			// Show a message error to the user using the reason and infos
		}
	};
	
	
	private void onCodeEntered(String code)
	{
		// You need to show the user a wait UI, like a loading spinner or something

		Batch.Unlock.redeemCode(code, new BatchCodeListener()
		{
			@Override
			public void onRedeemCodeSuccess(String code, Offer offer)
			{
				// Hide the wait UI
				
				// Give the features & resources contained in the offer to the user
				
				// Show success UI
				
			}

			@Override
			public void onRedeemCodeFailed(String code, FailReason reason, CodeErrorInfo infos)
			{
				// Hide the wait UI

				// Show a message error to the user using the reason and infos
			}
		});
	}
		
}