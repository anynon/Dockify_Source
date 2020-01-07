#import <Cephei/HBPreferences.h>

@interface SBCoverSheetPrimarySlidingViewController : UIViewController
- (void)viewDidDisappear:(BOOL)arg1;
- (void)viewDidAppear:(BOOL)arg1;
@end

//Set up variables for use with Cephei
static BOOL transparent;
static BOOL hidden;
static double setHeight;
static double customOpacity;
static NSInteger setIconNumber;
//nepeta like drm
BOOL dpkgInvalid = NO;
//static NSInteger setDockRowNumber;
//static CGFloat setRowSpacing;

HBPreferences *preferences;

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

//hook the dock
%hook SBDockView

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

//ios 13
-(double)defaultHeight {
  if (hidden) {
    return (0);
  } else {
    return (%orig*setHeight); //sets custom height if dock is not set to hidden
  }
}

//ios 12
-(double)dockHeight {
  if (hidden) {
    return (0);
  } else {
    return (%orig*setHeight); //sets custom height if dock is not set to hidden
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
- (NSUInteger)iconColumnsForCurrentOrientation {
  if (hidden) {
    return (0);
  } else {
    NSInteger reg = %orig;
    return reg; //basically just returns the original value
  }
}
%end
//ios 13
%hook SBIconListGridLayoutConfiguration

-(void)setNumberOfPortraitColumns:(unsigned long long)arg1 {
  if (setIconNumber == 4) {
    NSIntegr reg = %orig;
    %orig(reg);
  } else {
    %orig(setIconNumber);
  }
}
%end

%hook SBIconListView
//fix so it doesnt set all pages to 5 columns ios 13
-(unsigned long long)iconColumnsForCurrentOrientation {
  return (4);
}
-(BOOL)automaticallyAdjustsLayoutMetricsToFit {
  return YES;
}
%end
//fix for icons being off the page ios 13 and maybe 12
%hook SBIconListFlowLayout
- (NSUInteger)numberOfColumnsForOrientation:(NSInteger)arg1 {
  return (4);
}
%end
//another fix for the folders ios12
%hook SBFolderIconListView
+(unsigned long long)iconColumnsForInterfaceOrientation:(long long)arg1 {
  return (4);
}
%end

// Thanks to Nepeta for the DRM, and thanks to Sh0rtflow as well
%ctor {
  dpkgInvalid = ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.burritoz.dockify.list"];
  if (!dpkgInvalid) dpkgInvalid = ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/com.burritoz.dockify.md5sums"];


	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.burritoz.dockifyprefs"];
  [preferences registerDefaults:@ { //defaults for prefernces
    @"setHeight": @1,
    @"customOpacity": @1,
    @"hidden": @NO,
    @"setIconNumber": @4,
//    @"setRowSpacing": @0,
	}];
	[preferences registerBool:&transparent default:YES forKey:@"transparent"]; //registering transparent as a Boolean
  [preferences registerBool:&hidden default:NO forKey:@"hidden"]; //registering hidden as a Boolean
	[preferences registerDouble:(double *)&setHeight default:1 forKey:@"setHeight"]; //registering setHeigt as a double (number)
  [preferences registerDouble:(double *)&customOpacity default:1 forKey:@"customOpacity"]; //registering customOpacity as a double (number)
  [preferences registerInteger:(NSInteger *)&setIconNumber default:4 forKey:@"setIconNumber"]; //Integer of how many icons to allow
//  [preferences registerInteger:(NSInteger *)&setDockRowNumber default:1 forKey:@"setDockRowNumber"]; //Integer of how many dock rows to allow
//  [preferences registerFloat:(CGFloat *)&setRowSpacing default:0 forKey:@"setRowSpacing"]; //custom dock row spacing?
}
