//import needed files/headers
#import <SpringBoard/SpringBoard.h>
#import <Cephei/HBPreferences.h>

//Set up variables for use with Cephei
static BOOL transparent;
static BOOL hidden;
static double setHeight;
static double customOpacity;

HBPreferences *preferences;

//hook the dock
%hook SBDockView

//this deals with everything adjusting opacity/transparency
-(void)setBackgroundAlpha:(double)arg1  {
    if (transparent == NO && hidden == NO) { //if not transparent and not hidden
      %orig(customOpacity);
    }else if (transparent || hidden) { // Note: || means or in objc
      %orig(0.0); //hides background of the dock (transparent)
    } else {
      NSLog(@"Dock not Transparent/hidden, no custom opacity\n");
    }
}

-(double)dockHeight {
  if (hidden) {
    return (-50); //just puts the dock barely off screen lol
  } else {
    return (%orig*setHeight); //sets custom height if dock is not set to hidden
  }
  }

%end

%ctor {
	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.burritoz.dockifyprefs"];
	[preferences registerDefaults:@{ //defaults for prefernces
    @"setHeight": @1,
    @"customOpacity": @1,
    @"hidden": @NO
	}];
	[preferences registerBool:&transparent default:YES forKey:@"transparent"]; //registering transparent as a Boolean
  [preferences registerBool:&hidden default:NO forKey:@"hidden"]; //registering hidden as a Boolean
	[preferences registerDouble:(double *)&setHeight default:1 forKey:@"setHeight"]; //registering setHeigt as a double (number)
  [preferences registerDouble:(double *)&customOpacity default:1 forKey:@"customOpacity"]; //registering customOpacity as a double (number)
}
