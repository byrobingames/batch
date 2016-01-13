#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include "Utils.h"
#include <stdio.h>

using namespace batchextension;

AutoGCRoot* batchEventHandle = 0;


static value batch_set_event_handle(value onEvent)
{
	batchEventHandle = new AutoGCRoot(onEvent);
	return alloc_null();
}
DEFINE_PRIM(batch_set_event_handle, 1);


static value batchextension_init_method (value key) {
	#ifdef IPHONE
	initBatch(val_string(key));
	#endif
	return alloc_null();
	
}
DEFINE_PRIM (batchextension_init_method, 1);



extern "C" void batchextension_main () {
	
	val_int(0); // Fix Neko init
	
}
DEFINE_ENTRY_POINT (batchextension_main);



extern "C" int batchextension_register_prims () { return 0; }

extern "C" void  sendBatchEvent(const char* type, const char* arg1, const char* arg2, const char* arg3)
{
    value o = alloc_empty_object();
    alloc_field(o,val_id("type"),alloc_string(type));
	
    if (arg1 != NULL) 
	alloc_field(o,val_id("arg1"),alloc_string(arg1));
    if (arg2 != NULL) 
	alloc_field(o,val_id("arg2"),alloc_string(arg2));
    if (arg3 != NULL) 
	alloc_field(o,val_id("arg3"),alloc_string(arg3));
	
    val_call1(batchEventHandle->get(), o);
}

