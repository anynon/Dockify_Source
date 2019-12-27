#line 1 "Tweak.x"




#import <SpringBoard/SBDockIconListView.h>
#import <SpringBoard/SBDockView.h>
#import <SpringBoard/SBIconListView.h>
#import <SpringBoard/SpringBoard.h>
#import <Cephei/HBPreferences.h>


static BOOL transparent;
static BOOL hidden;
static double setHeight;
static double customOpacity;
static NSInteger setIconNumber;

HBPreferences *preferences;



#include <objc/message.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

__attribute__((unused)) static void _logos_register_hook$(Class _class, SEL _cmd, IMP _new, IMP *_old) {
unsigned int _count, _i;
Class _searchedClass = _class;
Method *_methods;
while (_searchedClass) {
_methods = class_copyMethodList(_searchedClass, &_count);
for (_i = 0; _i < _count; _i++) {
if (method_getName(_methods[_i]) == _cmd) {
if (_class == _searchedClass) {
*_old = method_getImplementation(_methods[_i]);
*_old = method_setImplementation(_methods[_i], _new);
} else {
class_addMethod(_class, _cmd, _new, method_getTypeEncoding(_methods[_i]));
}
free(_methods);
return;
}
}
free(_methods);
_searchedClass = class_getSuperclass(_searchedClass);
}
}
@class SBDockIconListView; @class SBDockView; 
static Class _logos_superclass$_ungrouped$SBDockView; static Class _logos_supermetaclass$_ungrouped$SBDockView; static void (*_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$)(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST, SEL, double);static double (*_logos_orig$_ungrouped$SBDockView$dockHeight)(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST, SEL);static double (*_logos_meta_orig$_ungrouped$SBDockView$defaultHeight)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL);static Class _logos_supermetaclass$_ungrouped$SBDockIconListView; static NSInteger (*_logos_meta_orig$_ungrouped$SBDockIconListView$maxIcons)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL);

#line 21 "Tweak.x"



static void _logos_method$_ungrouped$SBDockView$setBackgroundAlpha$(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, double arg1)  {
    if (transparent == NO && hidden == NO) { 
      (_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$ ? _logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$ : (__typeof__(_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$))class_getMethodImplementation(_logos_superclass$_ungrouped$SBDockView, @selector(setBackgroundAlpha:)))(self, _cmd, customOpacity);
    }else if (transparent || hidden) { 
      (_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$ ? _logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$ : (__typeof__(_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$))class_getMethodImplementation(_logos_superclass$_ungrouped$SBDockView, @selector(setBackgroundAlpha:)))(self, _cmd, 0.0); 
    } else {
      NSLog(@"Dock not Transparent/hidden, no custom opacity\n");
    }
}


static double _logos_method$_ungrouped$SBDockView$dockHeight(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return ((_logos_orig$_ungrouped$SBDockView$dockHeight ? _logos_orig$_ungrouped$SBDockView$dockHeight : (__typeof__(_logos_orig$_ungrouped$SBDockView$dockHeight))class_getMethodImplementation(_logos_superclass$_ungrouped$SBDockView, @selector(dockHeight)))(self, _cmd)*setHeight); 
  }

static double _logos_meta_method$_ungrouped$SBDockView$defaultHeight(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return ((_logos_meta_orig$_ungrouped$SBDockView$defaultHeight ? _logos_meta_orig$_ungrouped$SBDockView$defaultHeight : (__typeof__(_logos_meta_orig$_ungrouped$SBDockView$defaultHeight))class_getMethodImplementation(_logos_supermetaclass$_ungrouped$SBDockView, @selector(defaultHeight)))(self, _cmd)*setHeight); 
  }





static NSInteger _logos_meta_method$_ungrouped$SBDockIconListView$maxIcons(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
  if (hidden) {
    return (0);
  } else {
    return (setIconNumber);
  }
}



static __attribute__((constructor)) void _logosLocalCtor_7d006fd9(int __unused argc, char __unused **argv, char __unused **envp) {
	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.burritoz.dockifyprefs"];
	[preferences registerDefaults:@{ 
    @"setHeight": @1,
    @"customOpacity": @1,
    @"hidden": @NO,
    @"setIconNumber": @4,
	}];
	[preferences registerBool:&transparent default:YES forKey:@"transparent"]; 
  [preferences registerBool:&hidden default:NO forKey:@"hidden"]; 
	[preferences registerDouble:(double *)&setHeight default:1 forKey:@"setHeight"]; 
  [preferences registerDouble:(double *)&customOpacity default:1 forKey:@"customOpacity"]; 
  [preferences registerInteger:(NSInteger *)&setIconNumber default:4 forKey:@"setIconNumber"]; 
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBDockView = objc_getClass("SBDockView"); Class _logos_metaclass$_ungrouped$SBDockView = object_getClass(_logos_class$_ungrouped$SBDockView); _logos_superclass$_ungrouped$SBDockView = class_getSuperclass(_logos_class$_ungrouped$SBDockView); _logos_supermetaclass$_ungrouped$SBDockView = class_getSuperclass(_logos_metaclass$_ungrouped$SBDockView); { _logos_register_hook$(_logos_class$_ungrouped$SBDockView, @selector(setBackgroundAlpha:), (IMP)&_logos_method$_ungrouped$SBDockView$setBackgroundAlpha$, (IMP *)&_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$);}{ _logos_register_hook$(_logos_class$_ungrouped$SBDockView, @selector(dockHeight), (IMP)&_logos_method$_ungrouped$SBDockView$dockHeight, (IMP *)&_logos_orig$_ungrouped$SBDockView$dockHeight);}{ _logos_register_hook$(_logos_metaclass$_ungrouped$SBDockView, @selector(defaultHeight), (IMP)&_logos_meta_method$_ungrouped$SBDockView$defaultHeight, (IMP *)&_logos_meta_orig$_ungrouped$SBDockView$defaultHeight);}Class _logos_class$_ungrouped$SBDockIconListView = objc_getClass("SBDockIconListView"); Class _logos_metaclass$_ungrouped$SBDockIconListView = object_getClass(_logos_class$_ungrouped$SBDockIconListView); _logos_supermetaclass$_ungrouped$SBDockIconListView = class_getSuperclass(_logos_metaclass$_ungrouped$SBDockIconListView); { _logos_register_hook$(_logos_metaclass$_ungrouped$SBDockIconListView, @selector(maxIcons), (IMP)&_logos_meta_method$_ungrouped$SBDockIconListView$maxIcons, (IMP *)&_logos_meta_orig$_ungrouped$SBDockIconListView$maxIcons);}} }
#line 71 "Tweak.x"
