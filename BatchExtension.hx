package;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if android
import openfl.utils.JNI;
#end

import flash.events.Event;
import flash.events.EventDispatcher;

class BatchExtension extends Event {
	
	public static var dispatcher = new EventDispatcher ();
	
	public static function initBatch (key:String, gcm_sender_id:String = ""):Void {
		
		#if ios
		
		set_event_handle (notifyListeners);
		batchextension_init_method(key);
		
		#elseif android
		if (batchextension_init_method_jni == null)
			batchextension_init_method_jni = JNI.createStaticMethod ("com.byrobin.batch.BatchExtension", "initBatch", "(Ljava/lang/String;Ljava/lang/String;Lorg/haxe/lime/HaxeObject;)V");
			
		batchextension_init_method_jni(key, gcm_sender_id, new BatchHandler());
		
		#else
			
		#end
		
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
		
		dispatchEvent(new BatchEvent("REDEEM_OFFER", arg1, arg2, arg3));
		
		#end
	}
	
	
	
	
	public static function addEventListener (type:String, listener:Dynamic, useCapture:Bool = false, priority:Int = 0, useWeakReference:Bool = false):Void {
		
		dispatcher.addEventListener (type, listener, useCapture, priority, useWeakReference);
		
	}

	public static function removeEventListener (type:String, listener:Dynamic, capture:Bool = false):Void {
		
		dispatcher.removeEventListener (type, listener, capture);
		
	}
	
	public static function dispatchEvent (event:Event):Bool {
		
		return dispatcher.dispatchEvent (event);
		
	}
	
	public static function hasEventListener (type:String):Bool {
		
		return dispatcher.hasEventListener (type);
		
	}
	
	
	
	
	#if android
	private static var batchextension_init_method_jni:Dynamic;
	#elseif ios
	private static var batchextension_init_method = Lib.load ("batchextension", "batchextension_init_method", 1);
	private static var set_event_handle = Lib.load ("batchextension", "batch_set_event_handle", 1);
	#end
	
}

	
private class BatchHandler {

	public function new () {
	}
	
	public function batchEventReceipt (type:String, arg1:String, arg2:String, arg3:String):Void {
		trace(type);
		trace(arg1);
		trace(arg2);
		trace(arg3);
		
		if (type == "REDEEM_OFFER") {
				BatchExtension.dispatcher.dispatchEvent(new BatchEvent("REDEEM_OFFER", arg1, arg2, arg3));
		}
	}
}

class BatchEvent extends Event {
	
	public var arg1:String;
	public var arg2:String;
	public var arg3:String;
	
	public function new (type:String, arg1:String = "", arg2:String = "", arg3:String = "") {
		super (type);
		this.arg1 = arg1;
		this.arg2 = arg2;
		this.arg3 = arg3;
	}
}
