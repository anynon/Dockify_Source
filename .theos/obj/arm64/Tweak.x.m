#line 1 "Tweak.x"

#import <SpringBoard/SpringBoard.h>
#import <SpringBoard/SBDockIconListView.h>
#import <Cephei/HBPreferences.h>
#include <UIKit/UIKit.h>


static BOOL transparent;
static BOOL hidden;
static double setHeight;
static double customOpacity;
static NSInteger setIconNumber;

HBPreferences *preferences;



#include <substrate.h>
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

@class SBDockIconListView; @class SBDockView; 
static void (*_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$)(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST, SEL, double); static void _logos_method$_ungrouped$SBDockView$setBackgroundAlpha$(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST, SEL, double); static double (*_logos_orig$_ungrouped$SBDockView$dockHeight)(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST, SEL); static double _logos_method$_ungrouped$SBDockView$dockHeight(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST, SEL); static NSInteger (*_logos_meta_orig$_ungrouped$SBDockIconListView$maxIcons)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static NSInteger _logos_meta_method$_ungrouped$SBDockIconListView$maxIcons(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); 

#line 17 "Tweak.x"



static void _logos_method$_ungrouped$SBDockView$setBackgroundAlpha$(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, double arg1)  {
    if (transparent == NO && hidden == NO) { 
      _logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$(self, _cmd, customOpacity);
    }else if (transparent || hidden) { 
      _logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$(self, _cmd, 0.0); 
    } else {
      NSLog(@"Dock not Transparent/hidden, no custom opacity\n");
    }
}

static double _logos_method$_ungrouped$SBDockView$dockHeight(_LOGOS_SELF_TYPE_NORMAL SBDockView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return (_logos_orig$_ungrouped$SBDockView$dockHeight(self, _cmd)*setHeight); 
  }





static NSInteger _logos_meta_method$_ungrouped$SBDockIconListView$maxIcons(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
  if (hidden) {
    return (0);
  } else {
    return (setIconNumber);
  }
}



static __attribute__((constructor)) void _logosLocalCtor_44056092(int __unused argc, char __unused **argv, char __unused **envp) {
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
{Class _logos_class$_ungrouped$SBDockView = objc_getClass("SBDockView"); MSHookMessageEx(_logos_class$_ungrouped$SBDockView, @selector(setBackgroundAlpha:), (IMP)&_logos_method$_ungrouped$SBDockView$setBackgroundAlpha$, (IMP*)&_logos_orig$_ungrouped$SBDockView$setBackgroundAlpha$);MSHookMessageEx(_logos_class$_ungrouped$SBDockView, @selector(dockHeight), (IMP)&_logos_method$_ungrouped$SBDockView$dockHeight, (IMP*)&_logos_orig$_ungrouped$SBDockView$dockHeight);Class _logos_class$_ungrouped$SBDockIconListView = objc_getClass("SBDockIconListView"); Class _logos_metaclass$_ungrouped$SBDockIconListView = object_getClass(_logos_class$_ungrouped$SBDockIconListView); MSHookMessageEx(_logos_metaclass$_ungrouped$SBDockIconListView, @selector(maxIcons), (IMP)&_logos_meta_method$_ungrouped$SBDockIconListView$maxIcons, (IMP*)&_logos_meta_orig$_ungrouped$SBDockIconListView$maxIcons);} }
#line 62 "Tweak.x"
