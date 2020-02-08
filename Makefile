ARCHS = armv7s arm64 arm64e
THEOS_DEVICE_IP = 192.168.0.172
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Dockify

Dockify_FILES = Dockify.xm
Dockify_CFLAGS = -fobjc-arc
Dockify_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += dockifyprefs
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	echo "Made by Burrit0z"
	echo "Try not. Do or do not. There is no try."
