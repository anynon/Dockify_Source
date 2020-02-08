//Please note, in order to use MSHookIvar, this file needs to be .xm
#import <Cephei/HBPreferences.h>
#import <Foundation/Foundation.h>

@interface SBCoverSheetPrimarySlidingViewController : UIViewController
- (void)viewDidDisappear:(BOOL)arg1;
- (void)viewDidAppear:(BOOL)arg1;
@end

@interface SBIconListGridLayoutConfiguration
@property (nonatomic, assign) NSString *location;

- (NSString *)findLocation;
- (NSUInteger)numberOfPortraitColumns;
- (NSUInteger)numberOfPortraitRows;
@end

//Set up variables for use with Cephei
static BOOL tweakEnabled;
static BOOL transparent;
static BOOL hidden;
static double setHeight;
static double customOpacity;
static NSInteger setIconNumber;
//nepeta like drm
BOOL dpkgInvalid = NO;

HBPreferences *preferences;

%group allVersions
%hook SBCoverSheetPrimarySlidingViewController
- (void)viewDidDisappear:(BOOL)arg1 {

    %orig; //  Thanks to Nepeta for the DRM
    if (!dpkgInvalid) return;
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Pirate Detected!"
		message:@"Seriously? Pirating a free Tweak is awful!\nPiracy repo's Tweaks could contain Malware if you didn't know that, so go ahead and get Dockify from the official Source https://Burrit0z.github.io/repo/.\nIf you're seeing this but you got it from the official source then make sure to add https://Burrit0z.github.io/repo to Cydia or Sileo."
		preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Aww man" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

			UIApplication *application = [UIApplication sharedApplication];
			[application openURL:[NSURL URLWithString:@"https://Burrit0z.github.io/repo"] options:@{} completionHandler:nil];

	}];
    [alertController addAction:cancelAction];
		[self presentViewController:alertController animated:YES completion:nil];

}
%end
%end

%group version12
//hook the dock
%hook SBDockView
//ios 12
-(double)dockHeight {
  if (hidden) {
    return (0);
  } else {
    return (%orig*setHeight); //sets custom height if dock is not set to hidden
  }
}
//this deals with everything adjusting opacity/transparency
//ios 12 and 13
-(void)setBackgroundAlpha:(double)arg1 {
    if (transparent == NO && hidden == NO) { //if not transparent and not hidden
      %orig(customOpacity);
    }else if (transparent || hidden) { // Note: || means or in objc
      %orig(0.0); //hides background of the dock (transparent)
    } else {
      NSLog(@"Dock not Transparent/hidden, no custom opacity\n");
    }
}
%end

//NEW HOOK FOR ICON STATE
%hook SBDockIconListView
//ios 12 required piece
+(NSInteger)maxIcons {
  if (hidden) {
    return (0);
  } else {
    return (setIconNumber);
  }
}
%end
%end

//NEW GROUP FOR ios13
%group version13
%hook SBDockView
//ios 13
-(double)dockHeight {
  if (hidden) {
    return (0);
  } else {
    return (%orig*setHeight); //sets custom height if dock is not set to hidden
  }
}
//this deals with everything adjusting opacity/transparency
//ios 12 and 13
-(void)setBackgroundAlpha:(double)arg1 {
    if (transparent == NO && hidden == NO) { //if not transparent and not hidden
      %orig(customOpacity);
    }else if (transparent || hidden) { // Note: || means or in objc
      %orig(0.0); //hides background of the dock (transparent)
    } else {
      NSLog(@"Dock not Transparent/hidden, no custom opacity\n");
    }
}
%end
//fix for icons being off the page ios 13
%hook SBIconListGridLayoutConfiguration

%property (nonatomic, assign) NSString *location;

%new //Modeled off of Kritanta's solution with ivars
- (NSString *)findLocation {
    if (self.location) return self.location;
    else {
        NSUInteger rows = MSHookIvar<NSUInteger>(self, "_numberOfPortraitRows");
        NSUInteger columns = MSHookIvar<NSUInteger>(self, "_numberOfPortraitColumns");
        // dock
        if (rows < 2) {
            self.location =  @"Dock";
        } else if (rows == 3 && columns == 3) {
            self.location =  @"Folder";
        } else {
            self.location =  @"Root";
        }
    }
    return self.location;
}

- (NSUInteger)numberOfPortraitColumns {
  [self findLocation];
    if ([self.location isEqualToString:@"Dock"]) {
      if (hidden) {
        return (0);
      } else {
        return (setIconNumber);
      }
    } else {
      return (%orig);
    }
}
%end
%end
// Thanks to Nepeta for the DRM, and thanks to Litten as well
%ctor {
  dpkgInvalid = ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.burritoz.dockify.list"];
  if (!dpkgInvalid) dpkgInvalid = ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.burritoz.dockify.md5sums"];


	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.burritoz.dockifyprefs"];
  [preferences registerDefaults:@ { //defaults for prefernces
    @"tweakEnabled": @YES,
    @"setHeight": @1,
    @"customOpacity": @1,
    @"hidden": @NO,
    @"setIconNumber": @4,
	}];
  [preferences registerBool:&tweakEnabled default:YES forKey:@"tweakEnabled"];
	[preferences registerBool:&transparent default:YES forKey:@"transparent"]; //registering transparent as a Boolean
  [preferences registerBool:&hidden default:NO forKey:@"hidden"]; //registering hidden as a Boolean
	[preferences registerDouble:(double *)&setHeight default:1 forKey:@"setHeight"]; //registering setHeigt as a double (number)
  [preferences registerDouble:(double *)&customOpacity default:1 forKey:@"customOpacity"]; //registering customOpacity as a double (number)
  [preferences registerInteger:(NSInteger *)&setIconNumber default:4 forKey:@"setIconNumber"]; //Integer of how many icons to allow
if (tweakEnabled) {
  %init(allVersions);
  if (kCFCoreFoundationVersionNumber < 1600) //This means version < 12
    {
        %init(version12);
    }
    else
    {
        %init(version13);
    }
  }
}
