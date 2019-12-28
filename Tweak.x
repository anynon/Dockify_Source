//I looked at Kritanta's "Home Plus" tweak for help with ios13 stuff. I DID NOT
//copy anything, at least knowingly because these tweaks are simillar, please
//understand the code may be simillar becuase we are doing similar things.
//I am liscensing this under MIT, anyone can use anything they need to from here
#include <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>

@interface SBDockView
@property (nonatomic, assign) double dockHeight;
@end

@interface SBDockIconListView
@end

@interface SBIconListView
@end

@interface SBRootIconListView : UIView
+ (NSInteger)iconColumnsForInterfaceOrientation;
@end

@interface SBDockIconListView : SBRootIconListView
@end

//Set up variables for use with Cephei
static BOOL transparent;
static BOOL hidden;
static double setHeight;
static double customOpacity;
static NSInteger setIconNumber;

HBPreferences *preferences;

//hook the dock
%hook SBDockView

//this deals with everything adjusting opacity/transparency
//ios 12 and 13
-(void)setBackgroundAlpha:(double)arg1  {
    if (transparent == NO && hidden == NO) { //if not transparent and not hidden
      %orig(customOpacity);
    }else if (transparent || hidden) { // Note: || means or in objc
      %orig(0.0); //hides background of the dock (transparent)
    } else {
      NSLog(@"Dock not Transparent/hidden, no custom opacity\n");
    }
}

//ios 12
-(double)dockHeight {
    return (%orig*setHeight); //sets custom height if dock is not set to hidden
  }
//ios 13
+(double)defaultHeight {
    return (%orig*setHeight); //sets custom height if dock is not set to hidden
  }

%end


%hook SBDockIconListView

//ios 12
+(NSInteger)maxIcons {
  if (hidden) {
    return (0);
  } else {
    return (setIconNumber);
  }
}

//ios13

%end

%ctor {
	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.burritoz.dockifyprefs"];
	[preferences registerDefaults:@{ //defaults for prefernces
    @"setHeight": @1,
    @"customOpacity": @1,
    @"hidden": @NO,
    @"setIconNumber": @4,
	}];
	[preferences registerBool:&transparent default:YES forKey:@"transparent"]; //registering transparent as a Boolean
  [preferences registerBool:&hidden default:NO forKey:@"hidden"]; //registering hidden as a Boolean
	[preferences registerDouble:(double *)&setHeight default:1 forKey:@"setHeight"]; //registering setHeigt as a double (number)
  [preferences registerDouble:(double *)&customOpacity default:1 forKey:@"customOpacity"]; //registering customOpacity as a double (number)
  [preferences registerInteger:(NSInteger *)&setIconNumber default:4 forKey:@"setIconNumber"]; //Integer of how many icons to allow
}
