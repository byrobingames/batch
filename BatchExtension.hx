package;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if android
import openfl.utils.JNI;
#end

class BatchExtension {
	
	 public static var FEATER_Reference:String = "";
	 public static var FEATER_Value:String = "";
	 public static var RESSOURCE_Reference:String = "";
	 public static var RESSOURCE_Quantity:String = "";
	
	public function new () {
	}
	
	public static function initBatch (key:String, gcm_sender_id:String = ""):Void {
		
		#if ios
		
		set_event_handle (notifyListeners);
		batchextension_init_method(key);
		
		#elseif android
		if (batchextension_init_method_jni == null)
			batchextension_init_method_jni = JNI.createStaticMethod ("com.byrobin.batch.BatchExtension", "initBatch", "(Ljava/lang/String;Ljava/lang/String;Lorg/haxe/lime/HaxeObject;)V");
			
		batchextension_init_method_jni(key, gcm_sender_id, new BatchExtension());
		
		#else
			
		#end
		
	}

	public static function setRedeemOffer(type:String = "", arg1:String = "", arg2:String = "", arg3:String = ""):Void {
	
		if (type == "REDEEM_OFFER") 
		{
			if(arg1 == "FEATER")
			{
				FEATER_Reference = arg2;
				FEATER_Value = arg3;	
			}
			else if(arg1 == "RESSOURCE")
			{
				RESSOURCE_Reference = arg2;
				RESSOURCE_Quantity = arg3;
			}
			else
			{
				return;
			}
		}
		else if(type == "INIT")
		{
			//do stuff when batch succesfully is init.
		}
	
	}
	
	public static function getRedeemOffer(offer:Int):String {
	
		if(offer == 0){
			return FEATER_Reference;
		}
		else if(offer == 1){
			return FEATER_Value;
		}
		else if(offer == 2){
			return RESSOURCE_Reference;
		}
		else if(offer == 3){
			return RESSOURCE_Quantity;
		}
		else{
			return null;
		}
	}
	
	
	private static function notifyListeners (inEvent:Dynamic):Void {
		
		#if ios
		
		var type = Std.string (Reflect.field (inEvent, "type"));
		var arg1 = Std.string (Reflect.field (inEvent, "arg1"));
		var arg2 = Std.string (Reflect.field (inEvent, "arg2"));
		var arg3 = Std.string (Reflect.field (inEvent, "arg3"));
		trace(type);
		trace(arg1);
		trace(arg2);
		trace(arg3);
		
		setRedeemOffer(type, arg1, arg2, arg3);
		
	}
	#end
	
	#if android
	public function batchEventReceipt (type:String, arg1:String, arg2:String, arg3:String):Void {
		trace(type);
		trace(arg1);
		trace(arg2);
		trace(arg3);
		
		setRedeemOffer(type, arg1, arg2, arg3);
	}
	#end
	
	#if android
	private static var batchextension_init_method_jni:Dynamic;
	#elseif ios
	private static var batchextension_init_method = Lib.load ("batchextension", "batchextension_init_method", 1);
	private static var set_event_handle = Lib.load ("batchextension", "batch_set_event_handle", 1);
	#end
	
}

	
