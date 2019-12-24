include /Users/carsonzielinski/Documents/theos/makefiles/common.mk

BUNDLE_NAME = dockifyprefs

dockifyprefs_FILES = burRootListController.m
dockifyprefs_INSTALL_PATH = /Library/PreferenceBundles
dockifyprefs_FRAMEWORKS = UIKit
dockifyprefs_PRIVATE_FRAMEWORKS = Preferences
dockifyprefs_CFLAGS = -fobjc-arc
dockifyprefs_EXTRA_FRAMEWORKS +=CepheiPrefs Cephei

include /Users/carsonzielinski/Documents/theos/makefiles/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/dockifyprefs.plist$(ECHO_END)
