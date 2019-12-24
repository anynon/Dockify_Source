#import <SpringBoard/SpringBoard.h>
#import <Cephei/HBPreferences.h>

static BOOL transparent;
static BOOL hidden;
static double setHeight;
static double customOpacity;

HBPreferences *preferences;

%hook SBDockView
-(void)setBackgroundAlpha:(double)arg1  {
    if (transparent == NO) {
      %orig(customOpacity);
    }else if (transparent) {
      %orig(0.0);
    } else {
      NSLog(@"Dock not Transparent, no custom opacity\n");
    }
}

-(double)dockHeight {
  if (hidden) {
    return (-500);
  } else {
    return (%orig*setHeight);
  }
  }

%end

%ctor {
	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.burritoz.dockifyprefs"];
	[preferences registerDefaults:@{
    @"setHeight": @1,
    @"customOpacity": @1,
    @"hidden": @NO
	}];
	[preferences registerBool:&transparent default:YES forKey:@"transparent"];
  [preferences registerBool:&hidden default:NO forKey:@"hidden"];
	[preferences registerDouble:(double *)&setHeight default:1 forKey:@"setHeight"];
  [preferences registerDouble:(double *)&customOpacity default:1 forKey:@"customOpacity"];
}
