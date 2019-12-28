//Set up stuff
//#import <SpringBoardHome/SBDockIconListView.h>
//#import <SpringBoardHome/SBDockView.h>
//#import <SpringBoardHome/SBIconListView.h>
#import <Cephei/HBPreferences.h>

@interface SBDockView
@property (nonatomic, assign) double dockHeight;
@end

@interface SBDockIconListView
@end

@interface SBIconListView
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

+(NSInteger)maxIcons {
  if (hidden) {
    return (0);
  } else {
    return (setIconNumber);
  }
}

-(BOOL)allowsAddingIconCount:(unsigned long long)arg1 {
  if (hidden) {
    return (0);
    %orig(NO);
  } else {
    %orig(YES);
    return (setIconNumber);
  }
}

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
